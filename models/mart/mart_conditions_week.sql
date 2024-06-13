with weekly_forecast_weather as (
	select 
		staging_location.*,
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
		prep_forecast_day.condition_text 
	from {{ref('staging_location')}} 
	right join {{ref('prep_forecast_day')}} 
		on staging_location.city = prep_forecast_day.city
)

select 
	week_of_year,
    year_and_week,
    city,
    region,
    country,
    lat                                                         as latitude,
    lon                                                         as longitude,
	max(max_temp_c)                                             as weekly_max_temp_c,
	min(min_temp_c)                                             as weekly_min_temp_c,
	avg(avg_temp_c)                                             as weekly_avg_temp_c,
	max(max_wind_kph)                                           as weekly_max_wind_kph,
	sum(total_precip_mm)                                        as weekly_total_precip_mm,
	sum(total_snow_cm)                                          as weekly_total_snow_cm,
	avg(avg_vis_km)                                             as weekly_avg_vis_km,
	avg(avg_humidity)                                           as weekly_avg_humidity,
	count(
	case 
		when condition_text = 'Sunny' 
		then 1
        else 0
	end
	)                                                           as sunny_days,
	count(	
	case 
		when condition_text in 
			('Patchy rain possible', 
			'Light rain shower',
			'Light rain',
			'Moderate rain',
			'Patchy light rain with thunder',
			'Moderate rain at times',
			'Patchy rain possible',
			'Light drizzle',
			'Light rain shower',
			'Moderate or heavy rain shower',
			'Thundery outbreaks possible',
			'Moderate or heavy rain with thunder') 
		then 1 else 0
	end 
	)                                                           as rainy_days,
	count(
	case 
		when condition_text = 'Snowy'
		then 1 else 0
	end
	)                                                           as snowy_days,
	count(
	case 
		when condition_text not in
			('Snowy',
			'Sunny',
			'Patchy rain possible', 
			'Light rain shower',
			'Light rain',
			'Moderate rain',
			'Patchy light rain with thunder',
			'Moderate rain at times',
			'Patchy rain possible',
			'Light drizzle',
			'Light rain shower',
			'Moderate or heavy rain shower',
			'Thundery outbreaks possible',
			'Moderate or heavy rain with thunder')
		then 1
	end
	)                                                           as other_days
from weekly_forecast_weather
group by week_of_year, year_and_week, city, region, country, lat, lon
order by city, week_of_year asc
