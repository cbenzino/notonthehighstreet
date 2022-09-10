{{ config(
    materialized = 'view',
    cluster_by = 'ArtistId'
) }}

    select
        * 
    from
        {{ source('catalog','artists') }}