import 'package:flutter/material.dart';
import 'package:my_locatiion/data/localdata_base/local_database.dart';
import 'package:my_locatiion/data/model/my_location.dart';
class UserLocationProvider with ChangeNotifier{
  List <UserLocation>adresses=[];
  UserLocationProvider(){
    getAlladresesses();
  }
  getAlladresesses()async{
   adresses= await LocalDataBase.getLocation();
   print("CURRENT ADRESS:${adresses.length}");
    notifyListeners();
  }
  insertUserAdrees(UserLocation userLocation)async{
    await LocalDataBase.inserLocation(userLocation);
    getAlladresesses();
  }
  deletetUserAdrees(int id)async{
    await LocalDataBase.deleteLocation(id);
    getAlladresesses();
  }
  updateUserAddress(UserLocation userAddress) async {
    await LocalDataBase.updateAddresses(userAddress);
    getAlladresesses();
  }
}