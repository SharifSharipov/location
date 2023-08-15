import 'package:flutter/material.dart';
import 'package:my_locatiion/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../provider/mapadresscall_provider.dart';
class AdrressKindSelector extends StatefulWidget {
  const AdrressKindSelector({super.key});

  @override
  State<AdrressKindSelector> createState() => _AdrressKindSelectorState();
}

class _AdrressKindSelectorState extends State<AdrressKindSelector> {
  String dropdovnvalue = langList.first;
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
        context.read<AdressCallprovider>().updateLang(dropdovnvalue);
      },
      items: langList.map<DropdownMenuItem<String>>((String value) {
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
