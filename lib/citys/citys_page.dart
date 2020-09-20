import 'package:flutter/material.dart';
import 'package:practicaflutter/citys/add_city_page.dart';
import 'package:practicaflutter/citys/cities_bloc.dart';
import 'package:practicaflutter/common/header_widget.dart';
import 'package:practicaflutter/model/city.dart';
import 'package:practicaflutter/ui_constants.dart';


class CitysPage extends StatefulWidget {

  //metodo para cambiar hacia la pantalla de lista de ciudades
  @override
  _CitysPageState createState() => _CitysPageState();
}

class _CitysPageState extends State<CitysPage> {

  final bloc = CitiesBloc();

  //ejecuta el codiggo al inicar esta pantalla
  @override
  void initState() {
    // TODO: implement initState
    bloc.loadCities();
    super.initState();
  }


  void handleNavigateTap(BuildContext context) async{
 //espera a que retorne la respuesta de la vista
   await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => AddCityPage()
      ),
   );
   //recarga las ciudades y refresca la pantalla
   bloc.loadCities();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            elevation:0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black
            ),
          ),

          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: primaryColor,
            onPressed: () => handleNavigateTap(context),
          ),

          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxPageWidth
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget> [
                  SizedBox(
                    height: 30,
                  ),
                  //widget personalizado
                  HeaderWidget(tittle: 'Mis ciudades',),
                  Expanded(
                    child:
                    bloc.cities.isEmpty?
                    Center(
                      child: Text('No Tienes Ciudades :C'),
                    ): ListView.builder(
                      itemCount: bloc.cities.length,
                        itemBuilder: (context,index){
                      final city = bloc.cities[index];
                      return CityItem(city: city,);
                    }),
                  ),
                ],
              ),
            ),
          ),

        );
      }
    );

  }
}

class CityItem extends StatelessWidget {
  final City city;

  const CityItem({Key key, this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget>[
            Text(
              city.title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            InkWell(
              onTap: (){},
              child: Icon(
                  Icons.close
              ),
            ),
          ],
        ),
      ),
    );
  }
}

