import 'dart:async';

import 'package:flutter/material.dart';



//clase para hacer eficiente la llamada async
class Debouncer {
  Timer _timer;

  void run(VoidCallback callback){
      _timer?.cancel();
      _timer = Timer(
      const Duration( seconds: 1),
      callback,
    );
   }
}