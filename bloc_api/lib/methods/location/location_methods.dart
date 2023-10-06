import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});
  //getter for latitude and longitude
  double? getLatitude() {
    return latitude;
  }

  double? getLongitude() {
    return longitude;
  }

  Future<String> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Location services are disabled.';
    }

    // Check if the app has permission to access location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return 'Location permissions are permanently denied, we cannot request permissions.';
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return 'Location permissions are denied (actual value: $permission).';
      }
    }
    return 'success';
  }

  Future<void> updateLocation() async {
    // Get the current location
    print(await checkPermission());
    Position location = await Geolocator.getCurrentPosition();
    latitude = location.latitude;
    longitude = location.longitude;
  }
}
