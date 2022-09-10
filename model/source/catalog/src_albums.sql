{{ config(
    materialized = 'view',
    cluster_by = 'InvoiceId'
) }}

    select
        * 
    from
        {{ source('catalog','albums') }}