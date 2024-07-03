# DM Jan 2024
# 
# This script will fetch live weather data from open weather API and return temperature data

# If you want the app to automatically start upon boot, we can do so with a simple shell script. Then make the script an executable with `chmod +x startscript.sh`, set a crontab with `crontab -e`, and enter `@reboot ~/startscript.sh`. The clock should now launch upon startup. 

# ---- ERROR CODES ----
# 0 - no issue
# 1 - connected to open weather but incorrect response code
# 2 - unable to reach url
# 3 - unable to generate API request

import requests, os
from dotenv import load_dotenv, dotenv_values

load_dotenv()

def get_curr_temp():

    temp = 0
    temp_min = 0
    temp_max = 0

    # Block to catch missing or invalid .env file
    try:
        api_url = "https://api.openweathermap.org/data/2.5/weather?zip=" + os.getenv("ZIP_CODE") + "&appid=" + os.getenv("API_KEY") + "&units=" + os.getenv("UNITS")

        # Block to catch missing network connection
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

        except:

            # Unable to reach URL
            err = 2
            print("Unable to reach URL - no network?")

    except:
        # Unable to open .env file
        print("Unable to get generate API request - missing .env file?")
        err = 3

    return [temp, temp_min, temp_max, err]

get_curr_temp()