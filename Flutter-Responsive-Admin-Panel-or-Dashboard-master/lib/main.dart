import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/company_details.dart';
import 'package:admin/screens/main/components/addSwitch.dart';
import 'package:admin/screens/main/components/add_company.dart';
import 'package:admin/screens/main/components/switcheas.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'controllers/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: secondaryColor),
              borderRadius:
                  BorderRadius.circular(100).copyWith(bottomRight: const Radius.circular(0))),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: secondaryColor),
              borderRadius:
                  BorderRadius.circular(100).copyWith(bottomRight: const Radius.circular(0))),
        ),
      ),
      routes: {
        MyRoutes.companyScreen: (context) => CompanyScreen(),
        MyRoutes.addCompany: (context) => AddCompany(),
        MyRoutes.switches:(context)=> Switches(),
        MyRoutes.dashboard:(context) => DashboardScreen()
        // MyRoutes.addSwitch:(context)=>AddSwitch(5)
      },
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}
