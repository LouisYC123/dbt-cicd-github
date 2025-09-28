{{ config(tags=['ci_testing']) }}


select *
from {{ ref('model_1') }}
where id = 1
