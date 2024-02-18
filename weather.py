# DM Jan 2024
# 
# This script will fetch live weather data from open weather API and return temperature data

import requests

API_KEY = " " # You'll need to provide an API key and zipcode for weather data 
ZIP_CODE = " "
UNITS = "imperial"

def get_curr_temp():

    import requests
    api_url = "https://api.openweathermap.org/data/2.5/weather?zip=" + ZIP_CODE + "&appid=" + API_KEY + "&units=" + UNITS
    
    try:
        response = requests.get(api_url)

        if (response.status_code == 200):

            wdata = response.json()
            temp = wdata['main']['temp']
            temp_min = wdata['main']['temp_min']
            temp_max = wdata['main']['temp_max']
            
            err = 0
            
        else:

            # Able to reach open weather, but unsucessful response code
            err = 1
            print("Unable to get weather info - invalid API key?")

            temp = 0
            temp_min = 0
            temp_max = 0

    except:

        # Unable to reach URL
        err = 2
        print("Unable to reach URL - no network?")

        temp = 0
        temp_min = 0
        temp_max = 0

    return [temp, temp_min, temp_max, err]

get_curr_temp()