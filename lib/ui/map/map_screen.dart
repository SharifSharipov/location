import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_locatiion/network/api_service.dart';
import 'package:my_locatiion/ui/map/widgets/address_language_selector.dart';
import 'package:my_locatiion/ui/map/widgets/cart_type.dart';
import 'package:my_locatiion/ui/map/widgets/kindlist.dart';
import 'package:my_locatiion/ui/map/widgets/save_button.dart';
import 'package:provider/provider.dart';

import '../../data/model/my_location.dart';
import '../../provider/location_provider.dart';
import '../../provider/mapadresscall_provider.dart';
import '../../provider/user_location_provider.dart';

class MapScrcreen extends StatefulWidget {
  const MapScrcreen({
    super.key,
  });


  @override
  State<MapScrcreen> createState() => _MapScrcreenState();
}

class _MapScrcreenState extends State<MapScrcreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition initialCameraPostion;
  late CameraPosition currentLocation;
  MapType type=MapType.hybrid;
  bool oncamerraMove = false;
  Set<Marker> markers = {};
  @override
  void initState() {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context,listen: false);
    initialCameraPostion = CameraPosition(target: locationProvider.latLong!, zoom: 13);
    currentLocation = CameraPosition(target:locationProvider.latLong!, zoom: 13);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Map screen"),
        backgroundColor: Colors.amberAccent,
        actions: const [
          Align(
              alignment: Alignment.centerLeft,
              child: AddressKindeSelectorbutton()),
          Align(
              alignment: Alignment.centerRight,
              child: AdrressKindSelector()),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onTap: (latlong){
              context.read<AdressCallprovider>().claearMarker(latlong);
            },
            onLongPress: (event){

              context.read<AdressCallprovider>().addtwomarker(event);
            },
           markers: context.read<AdressCallprovider>().markers,
            onCameraMove: (CameraPosition cameraPosition) {
              currentLocation = cameraPosition;
            },
            onCameraMoveStarted: () {
              setState(() {
                oncamerraMove = true;
              });
              print("MOVE STARTED");
            },
            onCameraIdle: () {
              print(
                  "CURRENT CAMMERA POSITION:${currentLocation.target.longitude}");
              context.read<AdressCallprovider>().getAddressbyLatLong(
                  latLng: currentLocation.target,);
              setState(() {
                oncamerraMove = false;
              });
              debugPrint("MOVE FINSHED");
            },
            //liteModeEnabled: true,
            myLocationEnabled: false,
            padding: const EdgeInsets.all(16),
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            mapType: context.read<AdressCallprovider>().type,
            initialCameraPosition: initialCameraPostion,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Align(
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: oncamerraMove ? 64 : 44,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60,left: 40,right: 40),
            child: Text(
              context.watch<AdressCallprovider>().scrollAdressText,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.w800
              ),
              maxLines: 2,
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child:SaveButton(onTap: () async{
                AdressCallprovider adp= AdressCallprovider(apiService: ApiService());
               await  adp.getAddressbyLatLong(latLng: context.read<LocationProvider>().latLong!);
                print("==============="+adp.scrollAdressText);
                context.read<UserLocationProvider>().insertUserAdrees(
                  UserLocation(
                  lat:  currentLocation.target.latitude,
                  long:  currentLocation.target.longitude,
                  address: adp.scrollAdressText,
                  created: DateTime.now().toString(),
                ),
              ); },)
          ),
           const Positioned(
               bottom: 100,
               child: Cartype())

        ],


      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _followme(cameraPosition: initialCameraPostion);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }

  Future<void> _followme({required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }
}
