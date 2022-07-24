
import 'package:amval/src/core/screens/camera.dart';
import 'package:amval/src/core/screens/category/category.dart';
import 'package:amval/src/core/screens/dashboard.dart';
import 'package:amval/src/core/screens/instrument/assignment/assignment.dart';
import 'package:amval/src/core/screens/instrument/instrument.dart';
import 'package:amval/src/core/screens/instrument/instrument_add.dart';
import 'package:amval/src/core/screens/instrument/instrument_profile.dart';
import 'package:amval/src/core/screens/login.dart';
import 'package:amval/src/core/screens/splash.dart';
import 'package:amval/src/core/screens/staff/staff.dart';
import 'package:amval/src/core/screens/staff/staff_add.dart';
import 'package:amval/src/core/screens/unit/unit.dart';
import 'package:amval/src/data/model/instrument_response.dart';
import 'package:flutter/material.dart';

import 'storage/constants.dart';


class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const Splash(),);
      case '/login':
        return MaterialPageRoute(builder: (context) => const Login(),);
      case '/dashboard':
        return MaterialPageRoute(builder: (context) => const Dashboard(),);
      case '/category':
        return MaterialPageRoute(builder: (context) => const Category(),);
      case '/unit':
        return MaterialPageRoute(builder: (context) => const Unit(),);
      case '/staff':
        return MaterialPageRoute(builder: (context) => const Staff(),);
      case '/add_staff':
        return MaterialPageRoute(builder: (context) => const AddStaff(),);
      case '/instrument':
        return MaterialPageRoute(builder: (context) => const Instrument(),);
      case '/add_instrument':
        return MaterialPageRoute(builder: (context) => const AddInstrument(),);
      case '/camera':
        return MaterialPageRoute(builder: (context) => Camera(camera: camera),);
      case '/display_screen':
        return MaterialPageRoute(builder: (context) => const DisplayPictureScreen(),);
      case '/instrument_profile':
        return MaterialPageRoute(builder: (context) => InstrumentProfile(instrument: args as InstrumentResponse),);
      case '/assignment':
        return MaterialPageRoute(builder: (context) => Assignment(instrument: args as InstrumentResponse),);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text("Page Not Found"),
        ),
      );
    });
  }
}