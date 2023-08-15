import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/constants.dart';

class Ordertracingpage extends StatefulWidget {
  const Ordertracingpage({super.key});

  @override
  State<Ordertracingpage> createState() => _OrdertracingpageState();
}

class _OrdertracingpageState extends State<Ordertracingpage> {
  final Completer<GoogleMapController> _completer = Completer();
  final LatLng sourcelocation = LatLng(41.311081, 69.240562);
  final LatLng destantination = LatLng(41.300001, 69.200062);
  List<LatLng> polylineCoordinats = [];
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getPolyPoints();
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        goooglekey,
        PointLatLng(sourcelocation.latitude, sourcelocation.longitude),
        PointLatLng(destantination.latitude, destantination.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinats.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        Polyline polyline = Polyline(
          polylineId: PolylineId("route"),
          color: Colors.blue,
          points: polylineCoordinats,
        );
        polylines.add(polyline);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track order ",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: sourcelocation,
            zoom: 13.5,
          ),
          polylines: {
            Polyline(polylineId: PolylineId("Source"),
              points: polylineCoordinats,
              color: Colors.red,
              width: 6,
              
            )
          },
          markers: {
            Marker(markerId: MarkerId("Source"), position: sourcelocation),
            Marker(
                markerId: MarkerId("Destantination"), position: destantination)
          }),
    );
  }
}