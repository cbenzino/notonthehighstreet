{{ config(
    materialized = 'view',
    cluster_by = 'TrackId',
    partition_by ={ 'field': 'InvoiceDate',
    'data_type': 'date',
    'granularity': 'month' },
) }}

with cte_tracks as (
    select
        *
    from {{ ref('src_tracks') }}
),

cte_invoice_items as 
    select
        *
    from {{ ref('src_invoice_items') }}
),

cte_invoices as 
    select
        *
    from {{ ref('src_invoices') }}
),

cte_monthly_sales as (
    select 
         cast(to_char(("InvoiceDate"::date), '01-MM-YYYY') as date)       as calender_month_year -- aggregated to the first of everymonth
       , t.TrackId
       , Name                                                             as track_name
       , sum(Quantity)                                                    as number_times_bought
       , sum (i.UnitPrice * i.Quantity)                                   as total_sold
    from cte_tracks t
         left join cte_invoice_items i
                    on t.TrackId = i.TrackId
         inner join cte_invoices inv
                    on i.InvoiceId = inv.InvoiceId
    group by 1, 2, 3
)

select
*
from cte_monthly_sales