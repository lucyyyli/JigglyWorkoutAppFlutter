import 'package:jiggly/ui/home.dart';
import 'package:jiggly/ui/splash.dart';
import 'package:flutter/material.dart';
import '../../ui/chooseWorkout.dart';
import '../../ui/createWorkout.dart';
import '../../ui/doWorkout.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String home = '/home';
  static const String createWorkout = '/createWorkout';
  static const String chooseWorkout = '/chooseWorkout';
  static const String doWorkout = '/doWorkout';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    home: (BuildContext context) => HomeScreen(),
    createWorkout: (BuildContext context) => CreateWorkoutScreen(),
    chooseWorkout: (BuildContext context) => ChooseWorkoutScreen(),
    doWorkout: (BuildContext context) => DoWorkoutScreen(),
  };
}
