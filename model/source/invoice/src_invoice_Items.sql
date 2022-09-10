{{ config(
    materialized = 'view',
    cluster_by = 'InvoiceLineId'
) }}

    select
        * 
    from
        {{ source('invoice','invoice_items') }}
