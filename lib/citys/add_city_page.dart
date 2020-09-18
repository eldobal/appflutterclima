import 'package:flutter/material.dart';
import 'package:practicaflutter/citys/add_city_bloc.dart';
import 'package:practicaflutter/common/header_widget.dart';
import 'package:practicaflutter/common/loader_widget.dart';
import 'package:practicaflutter/model/city.dart';
import '../ui_constants.dart';
class AddCityPage extends StatefulWidget {

  @override
  _AddCityPageState createState() => _AddCityPageState();
}

class _AddCityPageState extends State<AddCityPage> {

  final bloc = AddCityBloc();

  void handleAddTap(City city) async{
    final result = await bloc.addCity(city);
    if(result){
      Navigator.of(context).pop();
    }
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context,child){
        return Scaffold(
          appBar: AppBar(
            elevation:0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
                color: Colors.black
            ),
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
                  HeaderWidget(tittle: 'Agregar Ciudad',),
                  SizedBox(
                    height: 15,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: TextField(
                      onChanged: bloc.onChangedText,
                      decoration: InputDecoration(
                          hintText: "Buscar Ciudad ",
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[250],
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          )
                      ),
                    ),
                  ),
                  if(bloc.errorMessage!= null)
                    Text(
                      bloc.errorMessage,
                      style: TextStyle(
                        color: Colors.red
                      ),
                    ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: bloc.cities.length,
                        itemBuilder: (context, index){
                          final city = bloc.cities[index];
                          return ListTile(
                            title: Text(city.title,style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                            ),
                            trailing: IconButton(
                              onPressed: (){
                                handleAddTap(city);
                              },
                              icon: Icon(
                                Icons.add,
                                color: primaryColor,
                              ),

                            ),
                          );
                        }
                    ),
                  ),
                  if(bloc.loading)
                    Center(
                      child: LoaderWidget(),
                    ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
