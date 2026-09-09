accidents = LOAD '/usaccidents/input/US_Accidents_1.5M.csv'
USING PigStorage(',')
AS (
    ID:chararray,
    Source:chararray,
    Severity:int,
    Start_Time:chararray,
    End_Time:chararray,
    Start_Lat:double,
    Start_Lng:double,
    End_Lat:double,
    End_Lng:double,
    Distance:double,
    Description:chararray,
    Street:chararray,
    City:chararray,
    County:chararray,
    State:chararray,
    Zipcode:chararray,
    Country:chararray,
    Timezone:chararray,
    Airport_Code:chararray,
    Weather_Timestamp:chararray,
    Temperature:double,
    Wind_Chill:double,
    Humidity:double,
    Pressure:double,
    Visibility:double,
    Wind_Direction:chararray,
    Wind_Speed:double,
    Precipitation:double,
    Weather_Condition:chararray,
    Amenity:chararray,
    Bump:chararray,
    Crossing:chararray,
    Give_Way:chararray,
    Junction:chararray,
    No_Exit:chararray,
    Railway:chararray,
    Roundabout:chararray,
    Station:chararray,
    Stop:chararray,
    Traffic_Calming:chararray,
    Traffic_Signal:chararray,
    Turning_Loop:chararray,
    Sunrise_Sunset:chararray,
    Civil_Twilight:chararray,
    Nautical_Twilight:chararray,
    Astronomical_Twilight:chararray
);

valid_weather = FILTER accidents BY
    Weather_Condition IS NOT NULL AND Weather_Condition != '';

grouped = GROUP valid_weather BY Weather_Condition;

weather_count = FOREACH grouped GENERATE
    group AS Weather_Condition,
    COUNT(valid_weather) AS Accident_Count;

ordered = ORDER weather_count BY Accident_Count DESC;

STORE ordered INTO '/usaccidents/pig/task4_weather_count'
USING PigStorage(',');