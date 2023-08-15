import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/location_provider.dart';
import '../tabox/tabox_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return TaboxScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context,);
    if (locationProvider.latLong != null) {
      _init();
    }
    return Scaffold(
      body: Center(
        child: Consumer<LocationProvider>(builder: (context,locationProvider,child){
              if(locationProvider!=null) {
                return const Text("EMPTY YOUR LOCATION");
              }
              else {
                return Text( "Splash Screen:${locationProvider.latLong!.longitude}  and ${locationProvider.latLong!.latitude}");
              }
              }
        ,)
      ),
    );
  }
}