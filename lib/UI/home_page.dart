import 'package:flutter/material.dart';
import 'package:practicaflutter/citys/cities_bloc.dart';
import 'package:practicaflutter/citys/citys_page.dart';
import 'package:practicaflutter/home/empty_widget.dart';
import 'package:practicaflutter/home/weathers_widget.dart';

class Homepage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final bloc = CitiesBloc();

  void handleNavigateTap(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CitysPage()
        ),
    );
  }

  @override
  void initState() {
    bloc.loadCities();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, snapshot) {
        return Scaffold(
          body: bloc.cities.isEmpty? EmptyWidget(
              onTap: () => handleNavigateTap(context),
          )
              : WeathersWidget(cities: bloc.cities),

        );
      }
    );
  }
}
