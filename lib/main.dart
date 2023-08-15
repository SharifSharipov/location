
import 'package:flutter/material.dart';
import 'package:my_locatiion/network/api_service.dart';
import 'package:my_locatiion/provider/location_provider.dart';
import 'package:my_locatiion/provider/mapadresscall_provider.dart';
import 'package:my_locatiion/provider/tabox_provider.dart';
import 'package:my_locatiion/provider/user_location_provider.dart';
import 'package:my_locatiion/ui/map/map_creen_two/map_screen_two.dart';

import 'package:my_locatiion/ui/splash_screen/splash_screen.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>UserLocationProvider()),
    ChangeNotifierProvider(create: (context)=>TabboxProvider()),
    ChangeNotifierProvider(create: (context)=>AdressCallprovider(apiService: ApiService())),
    ChangeNotifierProvider(create: (context)=>LocationProvider())
  ],child:const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
