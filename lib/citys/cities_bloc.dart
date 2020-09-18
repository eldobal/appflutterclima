import 'package:flutter/cupertino.dart';
import 'package:practicaflutter/data/repository/store_impl.dart';
import 'package:practicaflutter/data/repository/store_repository.dart';
import 'package:practicaflutter/model/city.dart';

class CitiesBloc extends ChangeNotifier{

  List<City> cities = [];
  final StoreRepository storage = StoreImpl();

  void loadCities() async {
    cities = await storage.getCities();
    notifyListeners();
  }

}