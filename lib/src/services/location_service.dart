import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> _checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) return Future.error('Location services are disabled.');

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return true;
  }

  Future<Position> getCurrentLocation() async {
    bool hasPermissions = await _checkPermissions().catchError((_) {});

    if (hasPermissions) {
      return await Geolocator.getCurrentPosition();
    } else {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<Placemark> getCurrentAddress({Position? position}) async {
    try {
      Position currentLocation = position ?? await getCurrentLocation();

      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentLocation.latitude, currentLocation.longitude);

      return placemarks.first;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserPosition> getUserPosition({Position? position}) async {
    Position currentLocation = position ?? await getCurrentLocation();

    GeoFirePoint _geopoint =
        GeoFirePoint(currentLocation.latitude, currentLocation.longitude);

    return UserPosition(geohash: _geopoint.hash, geopoint: _geopoint.geoPoint);
  }
}
