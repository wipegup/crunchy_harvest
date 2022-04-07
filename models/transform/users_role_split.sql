{%- call statement('roles', fetch_result=True) %}
    SELECT distinct(flattened_roles) FROM {{ ref('stg_harvest__users') }} CROSS JOIN UNNEST(roles) AS flattened_roles
{%- endcall %}
{%- set roles = load_result('roles')['data'] %}

with
src as (select * from {{ ref('stg_harvest__users') }}),

added_roles as (
    select *,
    {% for role in roles %}
        '{{role[0]}}' in unnest(roles) AS {{'is_' ~ dbt_utils.slugify(role[0])}}{% if not loop.last %},{% endif %}
    {% endfor %}
    from src)

select * from added_roles