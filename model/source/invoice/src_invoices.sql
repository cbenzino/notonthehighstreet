{{ config(
    materialized = 'incremental',
    unique_key = 'InvoiceId',
    partition_by ={ 'field': 'invoice_date',
    'data_type': 'date',
    'granularity': 'day' },
    cluster_by = 'InvoiceId'
) }}

    select
        *
        ,  DATE_TRUNC('day', InvoiceDate::date) as invoice_date
    from {{ source('invoice','invoice') }}

        {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where InvoiceDate > (select max(InvoiceDate) from {{ this }})

{% endif %}
