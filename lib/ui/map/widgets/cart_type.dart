import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_locatiion/provider/mapadresscall_provider.dart';
import 'package:provider/provider.dart';
class Cartype extends StatefulWidget {
  const Cartype({super.key});

  @override
  State<Cartype> createState() => _CartypeState();
}

class _CartypeState extends State<Cartype> {
  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton (
      icon: const Icon(Icons.clear_all,size: 60,color: Colors.black,),
        onSelected: (value) {
     context.read<AdressCallprovider>().updateMapTaype(value as MapType);
      },
      itemBuilder: (BuildContext context) {
        return const [
          PopupMenuItem (
            value: MapType.hybrid,
            child: Text('hybrid'),
          ),
          PopupMenuItem (
            value: MapType.normal,
            child: Text('normal'),
          ),
          PopupMenuItem (
            value: MapType.terrain,
            child: Text('terrain'),
          ),
          PopupMenuItem (
            value: MapType.none,
            child: Text('none'),
          ),
          PopupMenuItem (
            value: MapType.satellite,
            child: Text('satellite'),
          ),
        ];
      }
    );

  }
}
