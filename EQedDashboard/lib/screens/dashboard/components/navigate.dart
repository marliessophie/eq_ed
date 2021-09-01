import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/main/performance_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    MainScreen.id: (context) => MainScreen(),
    PerformanceScreen.id: (context) => PerformanceScreen(),
  };
}
