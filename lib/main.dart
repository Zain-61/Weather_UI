import 'package:colorful_iconify_flutter/icons/twemoji.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> weatherData = {
    "city": "New York",
    "currentWeather": {
      "temperature": 22,
      "condition": "Sunny",
      "icon": "sunny"
    },
    "hourlyForecast": [
      {"time": "10:00 AM", "temperature": 22, "icon": "sunny"},
      {"time": "11:00 AM", "temperature": 23, "icon": "partly_cloudy"},
      {"time": "12:00 PM", "temperature": 25, "icon": "rainy"},
      {"time": "1:00 PM", "temperature": 26, "icon": "partly_cloudy"},
      {"time": "2:00 PM", "temperature": 27, "icon": "sunny"},
      {"time": "3:00 PM", "temperature": 28, "icon": "cloudy"},
      {"time": "4:00 PM", "temperature": 23, "icon": "sunny"},
      {"time": "5:00 PM", "temperature": 26, "icon": "partly_cloudy"},
    ],
    "weeklyForecast": [
      {"day": "Monday", "highTemp": 30, "lowTemp": 20, "icon": "sunny"},
      {"day": "Tuesday", "highTemp": 28, "lowTemp": 18, "icon": "cloudy"},
      {
        "day": "Wednesday",
        "highTemp": 26,
        "lowTemp": 19,
        "icon": "partly_cloudy"
      },
      {"day": "Thursday", "highTemp": 27, "lowTemp": 18, "icon": "rainy"},
      {"day": "Friday", "highTemp": 29, "lowTemp": 21, "icon": "sunny"},
      {"day": "Saturday", "highTemp": 30, "lowTemp": 22, "icon": "sunny"},
      {"day": "Sunday", "highTemp": 28, "lowTemp": 20, "icon": "cloudy"}
    ]
  };

  final Map<String, Iconify> iconMapping = {
    "sunny": Iconify(Twemoji.sun),
    "partly_cloudy": Iconify(Twemoji.sun_behind_cloud),
    "cloudy": Iconify(Twemoji.cloud),
    "rainy": Iconify(Twemoji.cloud_with_rain),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 26,
                      ),
                      SizedBox(width: 7,),
                      Text(
                        weatherData["city"],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.search,
                        color: Colors.blue,
                        size: 26,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Iconify(Twemoji.sun_behind_cloud, size: 80),
                          SizedBox(width: 8),
                          Text(
                            weatherData["currentWeather"]["condition"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${weatherData["currentWeather"]["temperature"]}',
                            style: TextStyle(
                              fontSize: 94,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '°c',
                            style: TextStyle(
                              fontSize: 84,
                              //fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weatherData["hourlyForecast"].length,
                    itemBuilder: (context, index) {
                      var hour = weatherData["hourlyForecast"][index];
                      String iconString = hour["icon"];
                      Iconify iconData = iconMapping[iconString] ??
                          Iconify(Twemoji.cross_mark);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Text(
                                hour["time"],
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${hour["temperature"]}°C',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                              ),
                              SizedBox(height: 8),
                              iconData,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children:
                          weatherData["weeklyForecast"].map<Widget>((day) {
                        String iconString = day["icon"];
                        Iconify iconData = iconMapping[iconString] ??
                            Iconify(Twemoji.cross_mark);

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: Text(
                              day["day"],
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                            ),
                            trailing: Text(
                              '${day["highTemp"]}° / ${day["lowTemp"]}°',
                              style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,),
                            ),
                            leading: iconData,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
