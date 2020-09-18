import 'package:flutter/material.dart';
import 'package:practicaflutter/citys/citys_page.dart';
import 'package:practicaflutter/ui_constants.dart';

class Homepage extends StatelessWidget {

  //metodo para cambiar hacia la pantalla de lista de ciudades
  void handleNavigateTap(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CitysPage()
        ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        
       children: [
         Positioned.fill(child:
      Image.asset('assets/welcome.jpg'),
    ),
          SafeArea(
          child:Center (
            child: Container(
              constraints: BoxConstraints(
                maxWidth: maxPageWidth,
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 80,
                ),
                Image.asset(
                  'assets/logo.png',
                  height: 60,
                ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Hola,\nBienvenido',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text('Que te parece si agregamos\nuna nueva ciudad?',
                    textAlign: TextAlign.start ),
                SizedBox(
                  height: 150,
                ),
                RaisedButton(
                  child: Text('Agregar ciudad'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  onPressed:() => handleNavigateTap(context),

                )
              ],
            ),

           )
       )
          )
       ],
      ),
    );
  }
}
