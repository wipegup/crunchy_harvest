{%- macro simple_cte(ref_name, alias='') -%}
    {%- set alias = ref_name if alias=='' else alias -%}
    {{ alias }} as ( select * from {{ ref(ref_name) }} )
{% endmacro %}
