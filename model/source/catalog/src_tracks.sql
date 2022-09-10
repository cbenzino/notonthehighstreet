{{ config(
    materialized = 'view',
    cluster_by = 'TrackId'
) }}

    select
        * 
    from
        {{ source('catalog','tracks') }}