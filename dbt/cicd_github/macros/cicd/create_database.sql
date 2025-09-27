{% macro create_database(database_name, retention=1, transient=False, grant_to_role="") %}
  {% if database_name %}

    {{ log("Creating database " ~ database_name ~ "...", info=True) }}

    {% call statement('create_database', fetch_result=True, auto_begin=False) -%}
      CREATE OR REPLACE
        {% if transient %}TRANSIENT{% endif %}
        DATABASE {{ database_name }}
        DATA_RETENTION_TIME_IN_DAYS = {{ retention }}
    {%- endcall %}

    {%- set result = load_result('create_database') -%}
    {{ log(result['data'][0][0], info=True) }}

    {% if grant_to_role %}
      {{ log("Granting privileges to role " ~ grant_to_role, info=True) }}

      {% call statement('grant_usage', auto_begin=False) %}
        GRANT USAGE ON DATABASE {{ database_name }} TO ROLE {{ grant_to_role }}
      {% endcall %}

      {% call statement('grant_create_schema', auto_begin=False) %}
        GRANT CREATE SCHEMA ON DATABASE {{ database_name }} TO ROLE {{ grant_to_role }}
      {% endcall %}
    {% endif %}

  {% else %}
    {{ exceptions.raise_compiler_error("Invalid arguments. Missing database name") }}
  {% endif %}
{% endmacro %}
