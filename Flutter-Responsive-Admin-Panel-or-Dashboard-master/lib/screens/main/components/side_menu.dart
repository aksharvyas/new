import 'package:admin/controllers/routes.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../company_details.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo_2.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              Navigator.pushReplacementNamed(context, MyRoutes.dashboard);
            },
          ),

          DrawerListTile(
            title: "Company",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              Navigator.pushReplacementNamed(context, MyRoutes.companyScreen);
            },
          ),
          DrawerListTile(
            title: "Switches",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Navigator.pushReplacementNamed(context, MyRoutes.switches);
            },
          ),

        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        //color: Colors.white54,
        colorBlendMode: BlendMode.srcIn,
        // colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
