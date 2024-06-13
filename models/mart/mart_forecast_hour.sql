select 
    staging_location.*,
    prep_forecast_hour.*,
    concat('&nbsp;&nbsp;&nbsp;&nbsp;![weather_icon](', prep_forecast_hour.condition_icon,'?width=35)') as condition_icon_md
from {{ref'prep_forecast_hour'}}
right join {{ref'staging_location'}} using(city)
