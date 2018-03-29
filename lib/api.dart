import 'dart:async';
import 'dart:convert';

import 'package:google_maps_webservice/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as gps;

Future<String> getZipCode() async {
  final Map<String, double> currentLocation = await gps.Location().getLocation;
  final GeocodingResponse geocodingResponse =
      await GoogleMapsGeocoding(null).searchByLocation(
        Location(currentLocation['latitude'], currentLocation['longitude'])
      );
  if (geocodingResponse.status == GoogleResponseStatus.okay) {
    return geocodingResponse.results[0].addressComponents.singleWhere(
      (AddressComponent component) {
        return component.types.contains('postal_code');
      }
    ).shortName;
  } else {
    return null;
  }
}

Future<List<Map<String, dynamic>>> getProduce(String zipCode) async {
  final http.Response response = await http.get(
    'https://harvestsignal.com/api/v1/public/whatsfresh/$zipCode'
  );

  if (response.statusCode != 200) {
    return null;
  }

  final Map<String, List<dynamic>> rootJson = json.decode(response.body);
  return rootJson['data'];
}
