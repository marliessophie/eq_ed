import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/dashboard/components/navigate.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(EQDashboard());
}

class EQDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'EQ\'ed Dashboard',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: kBgColor,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.white),
            canvasColor: kSecondaryColor,
          ),
          initialRoute: MainScreen.id,
          routes: Navigate.routes,
          // home: MainScreen(),
        ), //MainScreen(),
      ),
    );
  }
}
