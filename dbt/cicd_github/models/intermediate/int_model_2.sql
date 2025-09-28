{{ config(tags=['ci_testing']) }}


select *
from {{ ref('stg_model_1') }}
where id = 1
