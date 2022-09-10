{{ config(
    materialized = 'view',
    cluster_by = 'customerid'
) }}

    select
        * 
    from
        {{ source('customer','customer') }}
