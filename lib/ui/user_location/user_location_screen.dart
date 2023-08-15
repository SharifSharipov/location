import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_locatiion/data/model/my_location.dart';
import 'package:my_locatiion/provider/mapadresscall_provider.dart';
import 'package:my_locatiion/provider/tabox_provider.dart';
import 'package:my_locatiion/provider/user_location_provider.dart';
import 'package:provider/provider.dart';

import '../../provider/location_provider.dart';

class UserLocationScreen extends StatefulWidget {
  const UserLocationScreen({Key? key}) : super(key: key);

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();


  Future<void> _followMeUserLocations(
      {required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<UserLocation> userLocations =
        Provider.of<UserLocationProvider>(context).adresses;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location screen"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          if (userLocations.isEmpty) const Text("Empty"),
          ...List.generate(userLocations.length, (index) {
            UserLocation individualLocation = userLocations[index];
            return Slidable(
              startActionPane: ActionPane(
                motion: BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      context
                          .read<UserLocationProvider>()
                          .deletetUserAdrees(individualLocation.Id!);
                    },
                    icon: Icons.delete,
                    label: "delete",
                    backgroundColor: Colors.red,
                  ),
                  SlidableAction(onPressed: (context) {
                    CameraPosition camerapostion = CameraPosition(
                        target: LatLng(
                            individualLocation.lat, individualLocation.long));
                    _followMeUserLocations(cameraPosition: camerapostion);
                    context.read<LocationProvider>().updateLatLong(LatLng(
                        individualLocation.lat, individualLocation.long));
                  },
                    icon: Icons.update,
                    label: "Update",
                    backgroundColor: Colors.green,

                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ListTile(
                  onTap: () {
                    context.read<TabboxProvider>().checkIndex(0);
                    context.read<AdressCallprovider>().getAddressbyLatLong(
                        latLng: LatLng(
                            individualLocation.lat, individualLocation.long));

                    context.read<LocationProvider>().updateLatLong(
                        LatLng(individualLocation.lat, individualLocation.long));
                  },
                  shape: Border.all(width: 2,color: Colors.blue),
                   trailing: IconButton(onPressed: () { context.read<UserLocationProvider>().deletetUserAdrees(index); }, icon: const Icon(Icons.delete, color: Colors.red,),),
                  title: Text(individualLocation.address),
                  subtitle: Text(
                      "Lat: ${individualLocation.lat} and Longt:${individualLocation.long}"),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
