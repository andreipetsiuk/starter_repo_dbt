select 
    prep_forecast_hour.date
    staging_location.city,
    staging_location.region,
    staging_location.country,
    staging_location.lat as latitude,
    staging_location.lon as longitude,
    staging_location.timezone_id,
    prep_forecast_hour.time_epoch,
    prep_forecast_hour.date_time,
    prep_forecast_hour.condition_text,
    prep_forecast_hour.condition_icon,
    concat('&nbsp;&nbsp;&nbsp;&nbsp;![weather_icon](', prep_forecast_hour.condition_icon,'?width=35)') as condition_icon_md,
    prep_forecast_hour.condition_code,
    prep_forecast_hour.temp_c,
    prep_forecast_hour.wind_kph,
    prep_forecast_hour.wind_degree,
    prep_forecast_hour.wind_dir,
    prep_forecast_hour.pressure_mb,
    prep_forecast_hour.precip_mm,
    prep_forecast_hour.snow_cm,
    prep_forecast_hour.humidity,
    prep_forecast_hour.cloud,
    prep_forecast_hour.feelslike_c,
    prep_forecast_hour.vis_km,
    prep_forecast_hour.gust_kph,
    prep_forecast_hour.uv,
    prep_forecast_hour.time,
    prep_forecast_hour.hour
from {{ref('staging_location')}} 
right join {{ref('prep_forecast_hour')}} 
	on staging_location.city = prep_forecast_hour.city
