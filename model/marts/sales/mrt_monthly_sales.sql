{{ config(
    materialized = 'incremental',
    unique_key = 'TrackId',
    cluster_by = 'TrackId',
    partition_by ={ 'field': 'InvoiceDate',
    'data_type': 'date',
    'granularity': 'month' }
) }}

select
*
from {{ ref('stg_monthly_sales') }}

  -- this filter will only be applied on an incremental run
  where InvoiceDate > (select max(InvoiceDate) from {{ this }})

{% endif %}
