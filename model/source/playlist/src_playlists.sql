{{ config(
    materialized = 'view',
    cluster_by = 'PlaylistId'
) }}

    select
        * 
    from
        {{ source('playlist','playlists') }}