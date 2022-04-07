{% macro stage_columns(rel, except=[], exclude_modified=true, modified=[], all_upper=true ) %}
{#- TODO: add in including arg #}
    {#- Below is ugly, precedent at https://github.com/dbt-labs/dbt-utils/blob/d2795428e163fee6e4dbc3ab9b8296e9e813c0b4/macros/sql/get_filtered_columns_in_relation.sql#L14-L21 #}
    {%- set unnested_modified = [] %}
    {%- for m in modified %}
        {%- if m is mapping %}
            {%- do unnested_modified.append(m) %}
        {%- else %}
            {%- do unnested_modified.extend(m) %}
        {%- endif %}
    {%- endfor %}
    {%- for m in unnested_modified %}
        {%- set alias_key = 'alias' if 'alias' in m else 'base'%}
        {%- set alias = (adapter.quote(m[alias_key])|trim) %}
        {%- set base = (adapter.quote(m['base'])|trim) %}
        {%- if all_upper %}
            {%- set base = base|upper %}
            {%- set alias = alias|upper %}
        {%- endif %}
        {%- if 'relation_alias' in kwargs %}{%- set base = (kwargs['relation_alias'] ~ '.' ~ base) %}{%- endif %}
        {%- if 'cast' in m %}{%- set base = 'CAST(' ~ base ~' AS ' ~ (m['cast']|upper) ~ ')' %}{%- endif %}
    {{base}} AS {{ alias }},
        {#- check to see if other columns will be added too for comma + newline? -#}
        {#- Where is newline coming from? unwrapped 'base as alias'? #}
        {%- if exclude_modified %}{%- do except.append(m['base']) %}{%- endif %}
    {%- endfor %}  
    {{ dbt_utils.star(rel, except=(except|unique), **kwargs) }}
{%- endmacro %}