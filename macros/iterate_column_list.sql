{% macro iterate_column_list(columns, prefix='', suffix='') %}
    {%- set returned_columns = [] %}
    {%- for col in columns %}
        {%- if col is mapping %}
            {%- for k,v in col.items() %}
                {%- do returned_columns.append(dict(base=k, alias=(prefix ~ v ~ suffix), **kwargs)) %}
            {%- endfor %}
        {%- else %}
        {#- check if string else error? #}
            {%- do returned_columns.append(dict(base=col, alias=(prefix ~ col ~ suffix), **kwargs)) %}
        {%- endif %}
    {%- endfor %}
    {{ return(returned_columns) }}
{% endmacro %}