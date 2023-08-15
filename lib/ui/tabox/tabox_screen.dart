import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_locatiion/provider/tabox_provider.dart';
import 'package:my_locatiion/ui/map/map_screen.dart';
import 'package:my_locatiion/ui/user_location/user_location_screen.dart';
import 'package:provider/provider.dart';

import '../../service/location_service.dart';

class TaboxScreen extends StatefulWidget {
  const TaboxScreen({super.key, });

  @override
  State<TaboxScreen> createState() => _TaboxScreenState();
}

class _TaboxScreenState extends State<TaboxScreen> {
  List<Widget> screens = [];
  @override
  void initState() {
    screens.add(MapScrcreen());
    screens.add(UserLocationScreen());
    initLocationService(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IndexedStack(
        index: context.watch<TabboxProvider>().activeindex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {

          setState(() {
            context.read<TabboxProvider>().checkIndex(index);

          });
        },
        fixedColor: Colors.amberAccent,
        items:  const [

          BottomNavigationBarItem(icon: Icon(Icons.map,color: Colors.black,), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit_location_alt), label: ""),
        ],
      ),
    );
  }
}
