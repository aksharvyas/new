import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';

import '../../../../data/remote/response/ApiResponse.dart';
import '../../../../data/remote/response/ApiStatus.dart';
import '../../../../models/GetUserSettingsModel.dart';
import '../../../../models/UpdateUserSettingsModel.dart';
import '../../../../res/AppDimensions.dart';
import '../../../../utils/Constants.dart';
import '../../../../view_model/UpdateUserSettingsVM.dart';
import '../../DialogCloseButton.dart';
import '../../DialogTitle.dart';
import '../../widget.dart';

class UserSettingsView extends StatefulWidget {
  double width;
  double height;
  Vm? vm;

  UserSettingsView(this.width, this.height, this.vm, {Key? key}) : super(key: key);

  @override
  State<UserSettingsView> createState() => _UserSettingsViewState();
}

class _UserSettingsViewState extends State<UserSettingsView> {

  bool vibration = false;
  bool tapSound = false;
  bool notification = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.vm != null) {
      vibration = widget.vm?.vibration ?? false;
      tapSound = widget.vm?.tapSound ?? false;
      notification = widget.vm?.notification ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DialogTitle(20.57, 31.85, "SETTING", 12.0, "Roboto"),
        DialogCloseButton(15, 27, () {
          Navigator.pop(context);
        }),
        Positioned(
            left: getX(widget.width, 27),
            top: getY(widget.height, 110),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(unSelectedButtonImage,
                    height: getHeight(widget.height, optionsNextButtonHeight),
                    width: getWidth(widget.width, optionsNextButtonWidth),
                    fit: BoxFit.fill),
                Positioned.fill(
                  child: Align(
//alignment: Alignment.topCenter,
                      child: Text("THEME",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                              fontSize: getAdaptiveTextSize(context, 10.3)),
                          textAlign: TextAlign.center)),
                ),
              ],
            )),
        Positioned(
            left: getX(widget.width, 113),
            top: getY(widget.height, 82),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(unSelectedButtonImage,
                    height: getHeight(widget.height, optionsNextButtonHeight),
                    width: getWidth(widget.width, optionsNextButtonWidth),
                    fit: BoxFit.fill),
                Positioned.fill(
                  child: Align(
//alignment: Alignment.topCenter,
                      child: Text("3D",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                              fontSize: getAdaptiveTextSize(context, 10.3)),
                          textAlign: TextAlign.center)),
                ),
              ],
            )),
        Positioned(
            left: getX(widget.width, 205),
            top: getY(widget.height, 98),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset("assets/images/toggle.png",
                    height: getHeight(widget.height, 10),
                    width: getWidth(widget.width, 26),
                    fit: BoxFit.contain),
              ],
            )),
        Positioned(
            left: getX(widget.width, 114),
            top: getY(widget.height, 133),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(unSelectedButtonImage,
                    height: getHeight(widget.height, optionsNextButtonHeight),
                    width: getWidth(widget.width, optionsNextButtonWidth),
                    fit: BoxFit.fill),
                Positioned.fill(
                  child: Align(
//alignment: Alignment.topCenter,
                      child: Text("FLP",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                              fontSize: getAdaptiveTextSize(context, 10.3)),
                          textAlign: TextAlign.center)),
                ),
              ],
            )),
        Positioned(
            left: getX(widget.width, 205),
            top: getY(widget.height, 151),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset("assets/images/toggle.png",
                    height: getHeight(widget.height, 10),
                    width: getWidth(widget.width, 26),
                    fit: BoxFit.contain),
              ],
            )),
        Positioned(
            left: getX(widget.width, 27),
            top: getY(widget.height, 219),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(unSelectedButtonImage,
                    height: getHeight(widget.height, optionsNextButtonHeight),
                    width: getWidth(widget.width, optionsNextButtonWidth),
                    fit: BoxFit.fill),
                Positioned.fill(
                  child: Align(
//alignment: Alignment.topCenter,
                      child: Text("ROHAN OFFICE",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                              fontSize: getAdaptiveTextSize(context, 10.3)),
                          textAlign: TextAlign.center)),
                ),
              ],
            )),
        Positioned(
            left: getX(widget.width, 113),
            top: getY(widget.height, 196),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(unSelectedButtonImage,
                    height: getHeight(widget.height, optionsNextButtonHeight),
                    width: getWidth(widget.width, optionsNextButtonWidth),
                    fit: BoxFit.fill),
                Positioned.fill(
                  child: Align(
//alignment: Alignment.topCenter,
                      child: Text("BRUSHDSTEEL",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                              fontSize: getAdaptiveTextSize(context, 10.3)),
                          textAlign: TextAlign.center)),
                ),
              ],
            )),
        Positioned(
            left: getX(widget.width, 205),
            top: getY(widget.height, 209),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset("assets/images/toggle.png",
                    height: getHeight(widget.height, 10),
                    width: getWidth(widget.width, 26),
                    fit: BoxFit.contain),
              ],
            )),
        Positioned(
            left: getX(widget.width, 114),
            top: getY(widget.height, 247),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(unSelectedButtonImage,
                    height: getHeight(widget.height, optionsNextButtonHeight),
                    width: getWidth(widget.width, optionsNextButtonWidth),
                    fit: BoxFit.fill),
                Positioned.fill(
                  child: Align(
//alignment: Alignment.topCenter,
                      child: Text("BOUD BLUE",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                              fontStyle: FontStyle.normal,
                              decoration: TextDecoration.none,
                              fontSize: getAdaptiveTextSize(context, 10.3)),
                          textAlign: TextAlign.center)),
                ),
              ],
            )),
        Positioned(
            left: getX(widget.width, 205),
            top: getY(widget.height, 262),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset("assets/images/toggle.png",
                    height: getHeight(widget.height, 10),
                    width: getWidth(widget.width, 26),
                    fit: BoxFit.contain),
              ],
            )),
        Positioned(
            left: getX(widget.width, 27),
            top: getY(widget.height, 308),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  vibration = !vibration;
                });
              },
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                      vibration
                          ? selectedButtonImage
                          : unSelectedButtonImage,
                      height: getHeight(widget.height, optionsNextButtonHeight),
                      width: getWidth(widget.width, optionsNextButtonWidth),
                      fit: BoxFit.fill),
                  Positioned.fill(
                    child: Align(
//alignment: Alignment.topCenter,
                        child: Text("VIBRATION",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                                fontSize: getAdaptiveTextSize(context, 10.3)),
                            textAlign: TextAlign.center)),
                  ),
                ],
              ),
            )),
        Positioned(
            left: getX(widget.width, 27),
            top: getY(widget.height, 366),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  tapSound = !tapSound;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                      tapSound
                          ? selectedButtonImage
                          : unSelectedButtonImage,
                      height: getHeight(widget.height, optionsNextButtonHeight),
                      width: getWidth(widget.width, optionsNextButtonWidth),
                      fit: BoxFit.fill),
                  Positioned.fill(
                    child: Align(
//alignment: Alignment.topCenter,
                        child: Text("TAP SOUND",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                                fontSize: getAdaptiveTextSize(context, 9)),
                            textAlign: TextAlign.center)),
                  ),
                ],
              ),
            )),
        Positioned(
            left: getX(widget.width, 27),
            top: getY(widget.height, 423),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  notification = !notification;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                      notification
                          ? selectedButtonImage
                          : unSelectedButtonImage,
                      height: getHeight(widget.height, optionsNextButtonHeight),
                      width: getWidth(widget.width, optionsNextButtonWidth),
                      fit: BoxFit.fill),
                  Text("NOTIFICATION",
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: getAdaptiveTextSize(context, 8)),
                      textAlign: TextAlign.center),
                ],
              ),
            )),
        Positioned(
            left: getX(widget.width, 97),
            top: getY(widget.height, 488),
            child: GestureDetector(
              onTap: () {
                updateUserSettings(
                    context, vibration, notification, tapSound);
              },
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(unSelectedButtonImage,
                      height: getHeight(widget.height, optionsNextButtonHeight),
                      width: getWidth(widget.width, optionsNextButtonWidth),
                      fit: BoxFit.fill),
                  Positioned.fill(
                    child: Align(
//alignment: Alignment.topCenter,
                        child: Text("DONE",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                                fontSize: getAdaptiveTextSize(context, 10.3)),
                            textAlign: TextAlign.center)),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Future<void> updateUserSettings(BuildContext context, bool vibration,
      bool notification, bool tapSound) async {
    UpdateUserSettingsVM updateUserSettingsVM = UpdateUserSettingsVM();

    RequestUpdateUserSettings requestUpdateUserSettingsModel =
    RequestUpdateUserSettings(
        applicationId: applicationId,
        id: userSettingsId,
        appUserId: appUserId,
        themeId: 0,
        vibration: vibration,
        notification: notification,
        tapSound: tapSound,
        updatedDateTime:
        DateTime.now().toUtc().toString().replaceFirst(RegExp(' '), 'T'),
        updatedBy: appUserId);

    ApiResponse<ResponseUpdateUserSettings> updateUserSettingsData =
    await updateUserSettingsVM
        .updateUserSettings(requestUpdateUserSettingsModel);

    if (updateUserSettingsData.status == ApiStatus.COMPLETED) {
      ResponseUpdateUserSettings responseUpdateUserSettings =
      updateUserSettingsData.data!;
      showToastFun(context, responseUpdateUserSettings.value!.meta!.message);
      if (responseUpdateUserSettings.value!.meta!.code == 1) {
        Navigator.of(context).pop();
      }
    }
  }

}
