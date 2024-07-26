import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/location_provider.dart';
import 'package:weather_app/services/weather_provider.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    locationProvider.fetchPosition().then((_) {
      if (locationProvider.currentLocationName != null) {
        var city = locationProvider.currentLocationName!.locality;
        if (city != null) {
          Provider.of<WeatherServiceProvider>(context, listen: false).fetchWeatherDataByCity(city.toString());
        }
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    final locationProvider = Provider.of<LocationProvider>(context);
    final weatherProvider = Provider.of<WeatherServiceProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black ,
      body: Column(
        children: [
          Container(
            height: height/2.5,
            width: width,
            color: const Color.fromRGBO(238, 169, 78, 1),
            child:   Padding(
              padding:  const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.topRight ,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
                      child: SizedBox(
                        width: 200,
                        height: 40,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'Search',  
                            hintStyle: TextStyle(
                              color: Colors.white
                            ),
                            suffixIcon: Icon(Icons.search,
                            color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                   Text("${weatherProvider.weather?.main?.temp?.toStringAsFixed(0)} \u00B0C",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Consumer<LocationProvider>(
                    builder: (context, locationProvider, child){
                    
                    if (locationProvider.currentLocationName != null) {
                      locationProvider.currentLocationName!.locality;
                    } else {
                       // ignore: avoid_print
                       print("Unknown Location");
                    }
                    return  Text(locationProvider.currentLocation!.name.toString(),
                     style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                    );  
                    }
                  ),
                  Text(DateTime.now().toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: width,
            height: height/1.67,
            decoration: const BoxDecoration(
             image: DecorationImage(
              opacity: 0.7,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/background.JPG"))
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("${weatherProvider.weather?.name} \u00B0C",
                      style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50, 
                      fontWeight: FontWeight.bold
                      ),
                      ),
                    ),

                  ],
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Temp max",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      ),
                      ),
                      const SizedBox(width: 20,),
                      Text("${weatherProvider.weather?.main?.temp?.toStringAsFixed(0)} \u00B0C",
                      style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      ),
                      ),
                      const Icon(WeatherIcons.thermometer,
                      color: Colors.pinkAccent,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Temp min",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      ),
                      ),
                      const SizedBox(width: 20,),
                      Text("${weatherProvider.weather?.main!.tempMin!.toStringAsFixed(0)} \u00B0C",
                      style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      ),
                      ),
                      const Icon(WeatherIcons.thermometer,
                      color: Colors.blueAccent,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Humidity",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      ),
                      ),
                      const SizedBox(width: 20,),
                      Text("${weatherProvider.weather?.main?.humidity!.toStringAsFixed(0)} \u00B0C",
                      style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      ),
                      ),
                      const Icon(WeatherIcons.raindrop,
                      color: Colors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Cloudy",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      ),
                      ),
                      const SizedBox(width: 20,),
                      Text("${weatherProvider.weather?.clouds!.all!.toStringAsFixed(0)} \u00B0C",
                      style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      ),
                      ),
                      const Icon(WeatherIcons.cloud,
                      color: Colors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Wind",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      ),
                      ),
                      const SizedBox(width: 20,),
                      Text("${weatherProvider.weather?.wind!.speed!.toStringAsFixed(0)} \u00B0C",
                      style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      ),
                      ),
                      const Icon(WeatherIcons.wind_beaufort_0,
                      color: Colors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  child: Divider(
                    thickness: 2  ,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      
    );
  }
}