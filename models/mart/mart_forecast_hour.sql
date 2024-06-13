select 
    staging_location.*,
    prep_forecast_hour.*,
    concat('&nbsp;&nbsp;&nbsp;&nbsp;![weather_icon](', prep_forecast_hour.condition_icon,'?width=35)') as condition_icon_md
from {{ref('staging_location')}} 
right join {{ref('prep_forecast_hour')}} 
	on staging_location.city = prep_forecast_hour.city
