import 'package:flutter/material.dart';
import 'package:my_locatiion/provider/mapadresscall_provider.dart';
import 'package:my_locatiion/utils/constants.dart';
import 'package:provider/provider.dart';

class AddressKindeSelectorbutton extends StatefulWidget {
  const AddressKindeSelectorbutton({Key? key}) : super(key: key);

  @override
  State<AddressKindeSelectorbutton> createState() => _AddressKindeSelectorbuttonState();
}

class _AddressKindeSelectorbuttonState extends State<AddressKindeSelectorbutton> {
  String dropdovnvalue = kindList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.amberAccent,
      value: dropdovnvalue,
      elevation: 16,
      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
      onChanged: (String? value) {
        setState(() {
          dropdovnvalue = value!;
        });
        context.read<AdressCallprovider>().updateKind(dropdovnvalue);
      },
      items: kindList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.green,
            ),
            child: Text(value),
          ),
        );
      }).toList(),
    );
  }
}
