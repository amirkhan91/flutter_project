import 'dart:async';

import 'package:location/location.dart';
import 'package:test_proj/location_di/location_model.dart';
class LocationService{
  Location location = Location();
  LocationModel? currentLocation;
StreamController<LocationModel>  locationModel = StreamController<LocationModel>.broadcast();
Stream<LocationModel> get getData => locationModel.stream;
LocationAccuracy(){
  location.requestPermission().then((permissionStatus){
    if(permissionStatus == PermissionStatus.granted){
      location.onLocationChanged.listen((locationData){
        currentLocation = LocationModel(latitude: locationData.latitude, longitude: locationData.longitude);
      });
    }
  });
}
}