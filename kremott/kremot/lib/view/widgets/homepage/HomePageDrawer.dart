import 'package:flutter/material.dart';
import 'package:kremot/view/widgets/dialogs/ChangeAdminDialogs.dart';

import '../../../global/storage.dart';
import '../../../res/AppColors.dart';
import '../../../res/AppDimensions.dart';
import '../../../utils/Constants.dart';
import '../../../utils/Utils.dart';
import '../../LoginPage.dart';
import '../CustomAlertDialog.dart';
import '../DialogAlertText.dart';
import '../DialogCloseButton.dart';
import '../DialogListButton.dart';
import '../dialogs/DeleteDialogs.dart';
import '../dialogs/EditDialogs.dart';
import '../dialogs/LogsDialogs.dart';
import '../dialogs/OwnershipDialogs.dart';
import '../dialogs/RoutineDialogs.dart';
import '../dialogs/SceneDialogs.dart';
import '../dialogs/ScheduleDialogs.dart';
import '../dialogs/SharingDialogs.dart';
import '../dialogs/VoiceCommandDialogs.dart';
import '../dialogs/place/PlaceDialog.dart';
import '../dialogs/user_settings/UserSettings.dart';
import '../widget.dart';

class HomePageDrawer extends StatefulWidget {
  double screenWidth;
  double screenHeight;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  HomePageDrawer(this.screenWidth, this.screenHeight, this._scaffoldKey,
      {Key? key})
      : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        const Icon(
          Icons.arrow_drop_up,
          size: 20,
          color: textColor,
        ),
        const SizedBox(height: 10,),
        Expanded(
          //height: getHeight(widget.screenHeight, widget.screenHeight - 108),
          child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerButton(widget.screenWidth, widget.screenHeight, "MANAGE\nLOGIN", (){

                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "PLACE", (){
                  createDialog(context, widget.screenHeight, widget.screenWidth);
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "SETTING", (){
                  createSettingDialog(context, widget.screenHeight, widget.screenWidth);
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "EDIT", (){
                  createEditDialog(context, widget.screenHeight, widget.screenWidth);
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "SHARING", (){
                  createSharingDialog(context, widget.screenHeight, widget.screenWidth);
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "CHANGE\nADMIN", (){
                  createChangeAdminDialog(context, widget.screenHeight, widget.screenWidth);
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "CHANGE\nOWNER", (){
                  createOwnerShipDialog(context, widget.screenHeight, widget.screenWidth);
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "CHANGE\nSSID", (){

                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "DELETE", (){
                  createDeleteDialog(context, widget.screenHeight, widget.screenWidth);
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "SCENE", (){
                  createSceneDialog(context, widget.screenHeight, widget.screenWidth);
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "VOICE\nCOMMAND", (){
                  createVoiceCommandDialog(context, widget.screenHeight, widget.screenWidth);
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "SCHEDULE", (){
                  createScheduleDialog(context, widget.screenHeight, widget.screenWidth);
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "ROUTINE", (){
                  createRoutineDialog(context, widget.screenHeight, widget.screenWidth);
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "LOGS", (){
                  createLogsDialog(context, widget.screenHeight, widget.screenWidth);
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "POWER\nMETER", (){

                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "SERVICE\nTICKET", (){

                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "HELP", (){
                   var data=new AboutListTile();
                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "FAQ", (){

                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "ABOUT US", (){

                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "CONTACT US", (){

                }),
                DrawerButton(widget.screenWidth, widget.screenHeight, "LOG OUT", (){
                  alertLogOutDialog(context, widget.screenHeight, widget.screenWidth);
                })
              ]),
        ),
        const SizedBox(height: 10,),
        const Icon(
          Icons.arrow_drop_down,
          size: 20,
          color: textColor,
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}

void alertLogOutDialog(BuildContext context, double height, double width) {
  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: CustomAlertDialog(
            188.45,
            129.17,
            Stack(
              children: [
                DialogCloseButton(7.0, 8.0, () {
                  Navigator.pop(context);
                }),
                DialogAlertText(5, 44.24, "ARE YOU SURE YOU WANT\nTO LOG OUT?"),
                Positioned.fill(
                    top: getY(height, optionsAlertButtonsTopMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DialogListButton("YES", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () async {
                          await LocalStorageService.onLogout();

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                                  (Route<dynamic> route) => false);
                        }),
                        DialogListButton("NO", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                          Navigator.pop(context);
                        }),
                      ],
                    )),
              ],
            ),
          ),
        );
      });
}

class DrawerButton extends StatelessWidget {
  double screenWidth;
  double screenHeight;
  String buttonText;
  Function onTap;

  DrawerButton(this.screenWidth, this.screenHeight, this.buttonText, this.onTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Utils.vibrateSound();
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(
            top: buttonText != "MANAGE\nLOGIN" ? getHeight(screenHeight, drawerMenuVerticalMargin) : 0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(drawerButtonImage,
                height: getHeight(screenHeight, drawerMenuHeight),
                width: getWidth(screenWidth, drawerMenuWidth),
                fit: BoxFit.fill),
            Positioned.fill(
              child: Align(
                child: Text(buttonText,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        //fontFamily: "Inter",
                        fontStyle: FontStyle.normal,
                        fontSize:
                            getAdaptiveTextSize(context, drawerMenuTextSize)),
                    textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
