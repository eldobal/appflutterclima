import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {

  final String tittle;

  const HeaderWidget({Key key, this.tittle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(tittle,
            style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Divider()
    ],
    );
  }
}
