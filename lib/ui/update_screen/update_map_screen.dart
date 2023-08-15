import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_locatiion/data/model/my_location.dart';
import 'package:my_locatiion/provider/location_provider.dart';
import 'package:my_locatiion/provider/mapadresscall_provider.dart';
import 'package:my_locatiion/provider/user_location_provider.dart';
import 'package:my_locatiion/ui/map/widgets/save_button.dart';
import 'package:provider/provider.dart';

final Completer<GoogleMapController> _controller =
    Completer<GoogleMapController>();

class UpdateMapScreen extends StatefulWidget {
  const UpdateMapScreen({super.key});

  @override
  State<UpdateMapScreen> createState() => _UpdateMapScreenState();
}

class _UpdateMapScreenState extends State<UpdateMapScreen> {
  late CameraPosition initialCamerapostion;
  late CameraPosition currentcamerapostion;
  bool onCameraMoveStarted = false;
  @override
  void initState() {
    LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    initialCamerapostion =
        CameraPosition(target: locationProvider.latLong!, zoom: 13);
    currentcamerapostion =
        CameraPosition(target: locationProvider.latLong!, zoom: 13);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location update"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCamerapostion,
            onCameraMove: (CameraPosition caamerapostion) {
              currentcamerapostion = caamerapostion;
            },
            onCameraIdle: () {
              debugPrint(
                  "CURRENT CAMERA POSITION${currentcamerapostion.target.longitude} and ${currentcamerapostion.target.longitude}");
              context
                  .read<AdressCallprovider>()
                  .getAddressbyLatLong(latLng: currentcamerapostion.target);

              setState(() {
                onCameraMoveStarted = false;
              });

              debugPrint("MOVE FINISHED");
            },
            liteModeEnabled: false,
            myLocationEnabled: false,
            padding: const EdgeInsets.all(16),
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            onCameraMoveStarted: () {
              setState(() {
                onCameraMoveStarted = true;
              });
              debugPrint("MOVE STARTED");
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Align(
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: onCameraMoveStarted ? 50 : 32,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
              child: Text(
                context.watch<AdressCallprovider>().scrollAdressText,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(child: SaveButton(
            onTap: () {
              AdressCallprovider adp =
                  Provider.of<AdressCallprovider>(context, listen: false);
              context.read<UserLocationProvider>().updateUserAddress(
                  UserLocation(
                      lat: currentcamerapostion.target.latitude,
                      long: currentcamerapostion.target.longitude,
                      address: adp.scrollAdressText,
                      created: DateTime.now().toString()));
              Navigator.pop(context);
              const snackBar = SnackBar(
                duration: Duration(seconds: 1),
                content: Text('Location Update!'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _followMe(cameraPosition: initialCamerapostion);
        },
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }

  Future<void> _followMe({required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }
}
