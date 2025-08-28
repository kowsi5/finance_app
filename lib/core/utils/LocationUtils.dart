import 'dart:convert';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/AppLatLng.dart';
import 'Support.dart';

class LocationUtils {
  LocationUtils._();
}

Future<bool> checkLocationPermission() async {
  Location location = Location();
  PermissionStatus permission = await location.hasPermission();
  if (permission == PermissionStatus.granted) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}

Future<bool> checkGPSEnabled() async {
  Location location = Location();
  return Future.value(await location.serviceEnabled());
}

Future<String> requestLocationPermission() async {
  Location location = Location();
  PermissionStatus permission = await location.hasPermission();
  if (permission == PermissionStatus.granted) {
    bool serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled) {
      return Future.value("Enabled");
    } else {
      bool isTurnedOn = await location.requestService();
      if (isTurnedOn) {
        return Future.value("Enabled");
      } else {
        return Future.value("GPSNotEnabled");
      }
    }
  } else if (permission == PermissionStatus.denied) {
    permission = await location.requestPermission();
    if (permission == PermissionStatus.granted) {
      bool serviceEnabled = await location.serviceEnabled();
      if (serviceEnabled) {
        return Future.value("Enabled");
      } else {
        bool isTurnedOn = await location.requestService();
        if (isTurnedOn) {
          return Future.value("Enabled");
        } else {
          return Future.value("GPSNotEnabled");
        }
      }
    } else {
      return Future.value("Denied");
    }
  } else if (permission == PermissionStatus.deniedForever) {
    return Future.value("AlwaysDenied");
  } else {
    return Future.error(false);
  }
}

Future<String> requestGPSEnable() async {
  Location location = Location();
  bool serviceEnabled = await location.serviceEnabled();
  if (serviceEnabled) {
    return Future.value("Enabled");
  } else {
    bool isTurnedOn = await location.requestService();
    if (isTurnedOn) {
      return Future.value("Enabled");
    } else {
      return Future.value("GPSNotEnabled");
    }
  }
}

Future<AppLatLng> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  Position locationData = await Geolocator.getCurrentPosition();

  return Future<AppLatLng>.value(AppLatLng(
      latitude: locationData.latitude.toString(),
      longitude: locationData.longitude.toString()));
}

Future<String> requestImagePermission() async {
  Location location = Location();
  PermissionStatus permission = await location.hasPermission();
  if (permission == PermissionStatus.granted) {
    bool serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled) {
      return Future.value("Enabled");
    } else {
      bool isTurnedOn = await location.requestService();
      if (isTurnedOn) {
        return Future.value("Enabled");
      } else {
        return Future.value("GPSNotEnabled");
      }
    }
  } else if (permission == PermissionStatus.denied) {
    permission = await location.requestPermission();
    if (permission == PermissionStatus.granted) {
      bool serviceEnabled = await location.serviceEnabled();
      if (serviceEnabled) {
        return Future.value("Enabled");
      } else {
        bool isTurnedOn = await location.requestService();
        if (isTurnedOn) {
          return Future.value("Enabled");
        } else {
          return Future.value("GPSNotEnabled");
        }
      }
    } else {
      return Future.value("Denied");
    }
  } else if (permission == PermissionStatus.deniedForever) {
    return Future.value("AlwaysDenied");
  } else {
    return Future.error(false);
  }
}

List<LatLng> fetchPointsFromPolyline(String response) {
  print(response);
  final json = jsonDecode(response);
  final points = json['routes'][0]['overview_polyline']['points'];
  return decodePolyline(points);
}

List<LatLng> decodePolyline(String polyline) {
  List<LatLng> points = [];
  int index = 0, len = polyline.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = polyline.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = polyline.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lng += dlng;

    points.add(LatLng(lat / 1E5, lng / 1E5));
  }
  return points;
}

String convertLatLngToString(LatLng latlng) {
  return "${latlng.latitude},${latlng.longitude}";
}

LatLng convertStringToLatLng(String location) {
  double latitude = convertToDouble(location.split(",")[0]);
  double longitude = convertToDouble(location.split(",")[1]);
  return LatLng(latitude, longitude);
}
