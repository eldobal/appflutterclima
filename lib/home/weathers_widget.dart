import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practicaflutter/home/weathers_details_widget.dart';
import 'package:practicaflutter/model/city.dart';
import 'package:practicaflutter/ui_constants.dart';
import 'package:practicaflutter/widgets/alertDialogSimple.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

DateFormat format = DateFormat('E, dd MMM yyyy');

class WeathersWidget extends StatefulWidget {

 final List<City> cities ;


 final VoidCallback onTap;


 const WeathersWidget({Key key, this.cities, this.onTap}) : super(key: key);


  @override
  _WeathersWidgetState createState() => _WeathersWidgetState();
}



class _WeathersWidgetState extends State<WeathersWidget> {

  double page = 0.0;
  PageController controller = PageController();

  void onListener(){


    setState(() {
      page = controller.page;
    });
  }

  @override
  void initState() {
    controller.addListener(onListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(onListener);
    controller.dispose();
    super.dispose();
  }

  void handleArrowPressed(City city){
    showBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0)
          )
        ),
        builder: (_){
          return Container(
           child: WeatherDetailsWidget(city: city,),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        PageView.builder(
        physics: const ClampingScrollPhysics(),
        controller: controller,
        itemCount: widget.cities.length,
        itemBuilder: (context, index){
          final city =widget.cities[index];
          double opacity =(index - page).abs();
          if (opacity >1) opacity = 1;
          return Opacity(
              opacity: 1,
              child: WeatherItem(city: city,
              onTap:() => handleArrowPressed(city),
              ),
          );
        },
      ),
        Positioned(
        left: 20,
        top: 30,
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showMyDialog(),
          ),
        ),
      ]
    );




  }



  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          //redondeo de esquinas alert dialog
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          title: Center(child: Text('Desea Agregar otra ciudad',)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Le Pedimos que agregue .'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
           SmoothStarRating(
             allowHalfRating: true,
             onRated: (value){
               print('el valor seleccionado es ->$value');
             },
             starCount: 5,
             size: 50,
             isReadOnly: false,
             color: Colors.pink,
             spacing: 0.0,
           )
          ],
        );
      },
    );
  }


  Future<void> _showMyDialogRate() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          //redondeo de esquinas alert dialog
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          title: Center(child: Text('Desea Agregar otra ciudad',)),
          content: Container(
            width: 400,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Calificar'),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SmoothStarRating(

                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          height: 5,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Dejar un Comentario',
                              border: InputBorder.none
                            ),
                            maxLines: 10,
                          ),
                        ),
                      ],

                    )
                  ],
                )
              ],
            ),
          ),


        );
      },
    );
  }




}





class WeatherItem extends StatelessWidget {

  final City city;
  final VoidCallback onTap;

  const WeatherItem({Key key, this.city, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weathers = city.weathers.first;
    return  Stack(
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
                height: 70,
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
              Align(
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
                    ),

                  ],
                ),
              ),
              Center(
                child: Text(
                  weathers.weatherStateName.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    shadows: shadows,
                    fontSize: 22,
                  ),
                ),
              ),
             const SizedBox(
               height: 70,
             ),
             Center(
                 child: IconButton(
                   icon: Icon(
                     Icons.keyboard_arrow_up,
                     color: Colors.white,
                     size: 40,
                   ),
                   onPressed: onTap,
                 ),
             ),
            ],
          ),
        )],
    );
  }
}

