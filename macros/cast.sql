{% macro cast(kind) %}
    {{ return(iterate_column_list(*varargs, cast=kind, **kwargs)) }}
{% endmacro %}
