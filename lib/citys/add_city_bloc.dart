import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:practicaflutter/common/debouncer.dart';
import 'package:practicaflutter/data/data_constants.dart';
import 'package:practicaflutter/data/repository/store_impl.dart';
import 'package:practicaflutter/data/repository/store_repository.dart';
import 'package:practicaflutter/model/city.dart';
import 'package:http/http.dart' as http;
import 'package:practicaflutter/model/weather.dart';
import 'package:practicaflutter/ui_constants.dart';

class AddCityBloc extends ChangeNotifier{
  List<City> cities = [];
  bool loading =false;
  //se instancia la clase debounce
  final debouncer = Debouncer();
  final StoreRepository storage = StoreImpl();
  String errorMessage ;
  void requestSearch(String text) async{
    loading = true;
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 3));
    final url='${api}search/?query=$text' ;
    final response= await http.get(url);
    final data = jsonDecode(response.body) as List;
      loading =false;
      cities = //[City(title: 'Lima', id: 123 )];
      data.map((e) => City.fromJson(e)).toList();
      notifyListeners();
  }

  void onChangedText(String text){
    debouncer.run(() {
      if(text.isNotEmpty) requestSearch(text);
    });
  }

    Future<bool> addCity(City city) async {
    loading = true;
    notifyListeners();
    //consultar si la ciudad ya esta agregada
    final url='${api}${city.id}';
    final response= await http.get(url);
    final data = jsonDecode(response.body);
    final weatherData = data['consolidated_weather'] as List;
    final weathers = weatherData.map((e) => Weather.fromJson(e)).toList();
    final newCity = city.fromWeathers(weathers);

    try{
      await storage.saveCity(newCity);
      errorMessage=null;
      return true;
      } on Exception catch(ex){
      errorMessage = ex.toString();
      print(ex.toString());
      loading = false;
      notifyListeners();
      return false;
     }

  }

}