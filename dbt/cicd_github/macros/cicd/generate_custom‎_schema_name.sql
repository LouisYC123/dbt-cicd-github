/*
Note: We can ignore the warnings here https://docs.getdbt.com/docs/build/custom-schemas#changing-the-way-dbt-generates-a-schema-name
because each dev has their own database, so there is no risk of overwriting
another dev's work.
In UAT and prod, we need a CI job to check the branch is up to date with main.
This will prevent any issues with previous MRs getting overwritten.

*/

{% macro generate_schema_name(custom_schema_name, node) -%}
    {{ custom_schema_name | lower }}
{%- endmacro %}