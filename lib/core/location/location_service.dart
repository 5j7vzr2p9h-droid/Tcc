import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../errors/exceptions.dart';

abstract class LocationService {
  Future<bool> openSettings();
  Future<List<double>> getMyLocationCoordinates();
  Future<String?> getAddressName(double lat, double lng);
}

final class LocationServiceImpl implements LocationService{
  final Geocoding _geocoding;
  
  LocationServiceImpl(this._geocoding);

  @override
  Future<bool> openSettings() => Geolocator.openAppSettings();

  @override
  Future<List<double>> getMyLocationCoordinates() async{
    if (!await Geolocator.isLocationServiceEnabled()) throw const LocationDisabledException();

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever)
      throw const PermissionAccessDeniedException();

    else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied)
        throw const PermissionAccessDeniedException();
    }

    try{
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          timeLimit: Duration(seconds: 15)
        )
      );
      return <double>[position.latitude, position.longitude];
    }on TimeoutException{
      throw const LocationTimeOutException();
    }catch(e){
      throw const LocationUnknownException();
    }
    
  }
  
  @override
  Future<String?> getAddressName(double lat, double lng) async{
    try{
      final Placemark placemark = (await _geocoding.placemarkFromCoordinates(lat, lng))[0];
      return "${placemark.administrativeArea}, ${placemark.subAdministrativeArea}";
    }catch(e){ return null;}
  }
  
}