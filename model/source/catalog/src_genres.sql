{{ config(
    materialized = 'view',
    cluster_by = 'GenreId'
) }}

    select
        * 
    from
        {{ source('catalog','genres') }}