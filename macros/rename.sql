{% macro rename() %}
    {{ return(iterate_column_list(*varargs, **kwargs)) }}
{% endmacro %}