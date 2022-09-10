{{ config(
    materialized = 'view',
    cluster_by = 'MediaTypeId'
) }}

    select
        * 
    from
        {{ source('catalog','media_types') }}