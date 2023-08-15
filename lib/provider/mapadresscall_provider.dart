import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_locatiion/data/model/universal_data.dart';
import 'package:my_locatiion/network/api_service.dart';

import '../utils/utility_functions.dart';

class AdressCallprovider with ChangeNotifier {
  AdressCallprovider({required this.apiService});

  final ApiService apiService;
  MapType type=MapType.hybrid;
  Set<Marker> markers = {};
  String scrollAdressText = "";
  String kind = "house";
  String lang = "tg_TG";
  getAddressbyLatLong({
    required LatLng latLng,
  }) async {
    UniversalData universalData =
    await apiService.getAddress(latLng: latLng,kind: kind, lang: lang);

    if (universalData.error.isEmpty) {
      print("--------------+++++++"+universalData.data);
      scrollAdressText = universalData.data as String;
    } else {
      debugPrint("ERROR: ${universalData.error}");
    }

    notifyListeners();
  }
  void updateKind(String newKind){
    kind=newKind;
  }
  void updateLang(String newLang){
    lang=newLang;
  }
  void updateMapTaype(MapType newMaptype){
    type=newMaptype;
    notifyListeners();
  }
  addStreamMarker(LocationData locationData)async{
    Uint8List unint8list= await getBytesFromAsset("assets/images/location.png",200);
    markers.add(
        Marker(markerId: MarkerId(locationData.time!.toString()),
        icon: BitmapDescriptor.fromBytes(unint8list),
        position: LatLng(locationData.latitude!,locationData.longitude!),
        infoWindow: InfoWindow(title: locationData.satelliteNumber.toString()),
        ),
    );
    notifyListeners();
  }
  addtwomarker(LatLng locationData)async{
    Uint8List unint8list= await getBytesFromAsset("assets/images/location.png",200);
    markers.add(
      Marker(markerId: MarkerId(DateTime.now().toString()),
        icon: BitmapDescriptor.fromBytes(unint8list),
        position: LatLng(locationData.latitude!,locationData.longitude!),
        infoWindow: const InfoWindow(title: "niamdir"),
      ),
    );
    notifyListeners();
  }
  claearMarker(LatLng latLng)async{
    markers.clear();
  }


}
