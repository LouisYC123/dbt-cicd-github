{{ config(
    materialized='table',
    tags=['ci_testing']
    ) 
}}

with source_data as (
    select
        1 as id,
        'test_value_1' as test_col_1
    union all
    select
        2 as id,
        'test_value_2' as test_col_1
    union all
    select
        3 as id,
        'test_value_3' as test_col_1
)

select * from source_data
