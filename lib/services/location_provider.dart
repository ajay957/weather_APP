// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/location_service.dart';

class LocationProvider with ChangeNotifier{

  Position? _current;
  Position? get current=> _current;

  final LocationService _locationService = LocationService();

  Placemark? _currentLocation;

  Placemark? get currentLocation=> _currentLocation;

  get currentLocationName => null;

  Future<void> fetchPosition() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      _current = null;
      notifyListeners();
      return;
    }
    permission = await Geolocator.checkPermission();

    if(permission==LocationPermission.denied){
      permission= await Geolocator.requestPermission();

      if(permission==LocationPermission.denied){
        _current =null;
        notifyListeners();
        return;
      }
    }
    if(permission == LocationPermission.deniedForever){
       _current =null;
        notifyListeners();
        return;
    }
    _current = await Geolocator.getCurrentPosition();
    print(_current);

    _currentLocation = await _locationService.getLocationName(_current);

    print(_currentLocation); 
    notifyListeners();
  }
}