select 
	staging_location.*,
	prep_forecast_day.date,
	prep_forecast_day.week_of_year,
	prep_forecast_day.year_and_week,
	prep_forecast_day.max_temp_c,
	prep_forecast_day.min_temp_c,
	prep_forecast_day.avg_temp_c,
	prep_forecast_day.max_wind_kph,
	prep_forecast_day.total_precip_mm,
	prep_forecast_day.total_snow_cm,
	prep_forecast_day.avg_vis_km,
	prep_forecast_day.avg_humidity,
	prep_forecast_day.condition_text,
	prep_forecast_day.condition_icon,
	concat('&nbsp;&nbsp;&nbsp;&nbsp;![weather_icon](', prep_forecast_day.condition_icon,'?width=35)') 						as condition_icon_md,
	(case 
		when prep_forecast_day.sunsrise = 'No sunrise' 
		then null 
		else prep_forecast_day.sunrise 
	end)::time 																												as sunrise,
	(case 
		when prep_forecast_day.sunset = 'No sunset' 
		then null 
		else prep_forecast_day.sunset 
	end)::time 																												as sunset,
	(case 
		when prep_forecast_day.moonrise = 'No moonrise' 
		then null 
		else prep_forecast_day.moonrise 
	end)::time 																												as moonrise,
	(case 
		when prep_forecast_day.moonset = 'No moonset' 
		then null 
		else prep_forecast_day.moonset 
	end)::time 																												as moonset,
	prep_forecast_day.moon_phase,
	prep_forecast_day.moon_illumination
from staging_location 
right join prep_forecast_day 
	on staging_location.city = prep_forecast_day.city		on staging_location.city = prep_forecast_day.city
