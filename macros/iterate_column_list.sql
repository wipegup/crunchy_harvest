
{% macro iterate_column_list(columns, prefix='', suffix='', except=[], transform='') %}
    {%- set except_cols = [] %}
    {%- for ex in except %}
        {%- if col is mapping %}
            {%- for k, v in col.items() %}
                {%- do except_cols.append(k|lower) %}
            {%- endfor %}
        {%- else %}
            {%- do except_cols.append(ex|lower) %}
        {%- endif %}
    {%- endfor %}
    {%- set returned_columns = [] %}
    {%- for col in columns %}
        {%- if col is mapping %}
            {%- for k,v in col.items() %}
                {%- if k|lower not in except %}
                    {%- if transform == '' %}
                        {%- do returned_columns.append(dict(base=k, alias=(prefix ~ v ~ suffix), **kwargs)) %}
                    {%- elif transform == 'upper' %}
                        {%- do returned_columns.append(dict(base=k, alias=(prefix ~ v ~ suffix)|upper, **kwargs)) %}
                    {%- elif transform == 'lower' %}
                        {%- do returned_columns.append(dict(base=k, alias=(prefix ~ v ~ suffix)|lower, **kwargs)) %}
                    {% endif %}
                {%- endif %}
            {%- endfor %}
        {%- else %}
        {#- check if string else error? #}
            {%- if col|lower not in except %}
                {%- if transform == '' %}
                        {%- do returned_columns.append(dict(base=col, alias=(prefix ~ col ~ suffix), **kwargs)) %}
                    {%- elif transform == 'upper' %}
                        {%- do returned_columns.append(dict(base=col, alias=(prefix ~ col ~ suffix)|upper, **kwargs)) %}
                    {%- elif transform == 'lower' %}
                        {%- do returned_columns.append(dict(base=col, alias=(prefix ~ col ~ suffix)|lower, **kwargs)) %}
                    {% endif %}
            {%- endif %}
        {%- endif %}
    {%- endfor %}
    {{ return(returned_columns) }}
{% endmacro %}