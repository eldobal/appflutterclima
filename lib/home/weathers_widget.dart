import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practicaflutter/model/city.dart';
import 'package:practicaflutter/ui_constants.dart';

DateFormat format = DateFormat('E, dd MMM yyyy');

class WeathersWidget extends StatelessWidget {

 final List<City> cities ;

  const WeathersWidget({Key key, this.cities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemBuilder: (context, index){
          final city= cities[index];
          final weathers = city.weathers.first;
          return Stack(
            fit: StackFit.expand,
            children: [
              //busca el jpg con respecto al estado abreviado de la city
              Image.asset('assets/background_states/${weathers.weatherStateAbbr}.jpg',
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    city.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                        shadows: shadows
                    ),
                  ),
                  Text(
                    format.format(weathers.applicableDate),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                      shadows: shadows),
                  ),
                 const SizedBox(
                    height: 50,
                  ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        weathers.theTemp.toInt().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          shadows: shadows,
                          fontSize: 70,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'C',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              shadows: shadows
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )

                  ],),
              )
            ],
          );
        }
    );
  }
}
