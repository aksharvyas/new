import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kremot/models/PlacesWithOwnerPermissionsModel.dart';
import 'package:kremot/view/widgets/CustomAlertDialog.dart';
import 'package:kremot/view/widgets/widget.dart';
import 'package:kremot/view_model/ChangeMultipleHomesOwnershipVM.dart';
import 'package:kremot/view_model/PlacesWithOwnerPermissionsVM.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../data/remote/response/ApiStatus.dart';
import '../../../models/ChangeMultipleHomesOwnershipModel.dart';
import '../../../models/GetUserByMobileNoModel.dart';
import '../../../res/AppColors.dart';
import '../../../res/AppDimensions.dart';
import '../../../res/AppStyles.dart';
import '../../../utils/Constants.dart';
import '../../../utils/Utils.dart';
import '../../../view_model/GetUserByMobileNoVM.dart';
import '../DialogAlertText.dart';
import '../DialogNote.dart';
import '../Loading.dart';
import '../CustomDialog.dart';
import '../DialogButton.dart';
import '../DialogCheckBox.dart';
import '../DialogCloseButton.dart';
import '../DialogListButton.dart';
import '../DialogCenterButton.dart';
import '../DialogTitle.dart';
import 'ContactListDialog.dart';

void createOwnerShipDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Center(
          child: CustomDialog(
              263.66,
              356.99,
              Stack(
                children: [
                  DialogTitle(20.57, 31.85, "CHANGE OWNER", 12.0, "Roboto"),
                  DialogCloseButton(15, 27, () {
                    Navigator.pop(context);
                  }),
                  Positioned(
                    left: getX(width, optionsNextButtonLeftMargin),
                    top: getY(height, optionsListTopMargin1),
                    child: DialogCenterButton(
                        "CHANGE\nOWNER", 83.28, 36.17, optionsButtonTextSize, (selected) async {
                      PermissionStatus permissionStatus = await Permission.contacts.status;
                      if (permissionStatus == PermissionStatus.granted) {
                        Navigator.pop(context);
                        changeOwnerShipDialog(context, height, width);
                      } else {
                        alertAccessDialog(context, height, width);
                      }
                    }),
                  )
                ],
              )),
        );
      },
    );
  });

}

void alertAccessDialog(
    BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    return Center(
      child: CustomAlertDialog(
        188.45,
        129.17,
        Stack(
          children: [
            DialogCloseButton(7.0, 8.0, () {
              Navigator.pop(context);
            }),
            DialogAlertText(5, 44.24, "PERMISSION TO ACCESS CONTACT LIST"),
            Positioned.fill(
                top: getY(height, optionsAlertButtonsTopMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogListButton("ALLOW", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                      Navigator.pop(context);
                      _askPermissions(context, height, width);
                    }),
                    DialogListButton("DENY", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
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

Future<void> _askPermissions(BuildContext context, double height, double width) async {
  PermissionStatus permissionStatus = await _getContactPermission();
  if (permissionStatus == PermissionStatus.granted) {
    Navigator.pop(context);
    changeOwnerShipDialog(context, height, width);
  } else {
    _handleInvalidPermissions(permissionStatus, context);
  }
}

Future<PermissionStatus> _getContactPermission() async {
  PermissionStatus permission = await Permission.contacts.status;
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.permanentlyDenied) {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    return permissionStatus;
  } else {
    return permission;
  }
}

void _handleInvalidPermissions(
    PermissionStatus permissionStatus, BuildContext context) {
  if (permissionStatus == PermissionStatus.denied) {
    const snackBar = SnackBar(content: Text('Access to contact data denied'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
    const snackBar = SnackBar(content: Text('Contact data not available on device'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void changeOwnerShipDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    TextEditingController mobileController = TextEditingController();
    PhoneNumber number = PhoneNumber(isoCode: 'IN');
    String numberWithoutDialCode = "";
    String getDialCode = "+91";
    String getCountryCode = "IN";
    Contact? currentSelectedContact;

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
            263.66,
            356.99,
            Stack(
              children: [
                DialogTitle(
                    20.57, 31.85, "CHANGE OWNERSHIP", 12.0, "Roboto"),
                DialogCloseButton(15, 24, () {
                  Navigator.pop(context);
                }),
                Positioned.fill(
                  top: getY(height, 130.39),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: getWidth(width, 40)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  height: getHeight(height, 35),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0x80eceded),
                                          width: 1),
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(0.0, 3),
                                            blurRadius: 2,
                                            spreadRadius: 0)
                                      ],
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            textFieldUnSelectedImage),
                                        fit: BoxFit.fill,
                                      )),
                                  child: InternationalPhoneNumberInput(
                                    onInputChanged: (PhoneNumber number) {
                                      setState(() {
                                        numberWithoutDialCode =
                                            mobileController.text;
                                        getDialCode = number.dialCode!;
                                        getCountryCode = number.isoCode!;
                                      });
                                    },
                                    onInputValidated: (bool value) {},

                                    selectorConfig: const SelectorConfig(
                                      selectorType:
                                      PhoneInputSelectorType.DIALOG,
                                      showFlags: false,
                                      leadingPadding: 0,
                                      setSelectorButtonAsPrefixIcon: true,
                                    ),
                                    ignoreBlank: false,
                                    autoValidateMode: AutovalidateMode.disabled,
                                    selectorTextStyle: hintTextStyle(context),
                                    initialValue: number,
                                    formatInput: false,
                                    spaceBetweenSelectorAndTextField: 0,
                                    selectorButtonOnErrorPadding: 0,
                                    maxLength: 10,
                                    textStyle: hintTextStyle(context),
                                    validator: validatePhoneNumber,
                                    textFieldController: mobileController,
                                    keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                    //inputBorder:  const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80eceded), width: 1),),
                                    inputDecoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        // fillColor: const Color(0xb81b1918),
                                        contentPadding: const EdgeInsets.only(
                                            left: 0, top: 0, bottom: 0),
                                        isDense: true,
                                        filled: true,
                                        isCollapsed: false,
                                        hintText: "MOBILE NO",
                                        hintStyle: TextStyle(color: highLightColor,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Roboto",
                                          fontStyle: FontStyle.normal,
                                          fontSize: getAdaptiveTextSize(context, 12.0),),
                                        labelStyle: hintTextStyle(context)),
                                    onSaved: (PhoneNumber number) {},
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getWidth(width, 15),
                            ),
                            GestureDetector(
                                onTap: () {

                                  Utils.showDialog(context, (context, animation, secondaryAnimation) {
                                    return ContactListDialog(width, height,
                                            (contact) {
                                          setState(() {
                                            currentSelectedContact = contact;

                                            String? phoneWithDialCode =
                                                currentSelectedContact
                                                    ?.phones?[0].value
                                                    .toString() ??
                                                    "";

                                            if (phoneWithDialCode != "") {
                                              String? dialCode = Utils
                                                  .separatePhoneAndDialCode(
                                                  phoneWithDialCode)?[
                                              'dial_code'];

                                              String? phone = Utils
                                                  .separatePhoneAndDialCode(
                                                  phoneWithDialCode)?[
                                              'phone'];

                                              String? countryCode = Utils
                                                  .separatePhoneAndDialCode(
                                                  phoneWithDialCode)?['code'];

                                              if (phone != null &&
                                                  dialCode != null &&
                                                  countryCode != null) {
                                                mobileController.text = phone;
                                                numberWithoutDialCode = phone;
                                                getDialCode = dialCode;
                                                getCountryCode = countryCode;
                                              }
                                            }
                                          });
                                        });
                                  });

                                },
                                child: const Icon(
                                  Icons.contacts,
                                  size: 25,
                                  color: Color(0xb81b1918),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: getX(width, optionsNextButtonLeftMargin),
                  top: getY(height, optionsNextButtonTopMargin),
                  child: DialogCenterButton("NEXT", optionsNextButtonWidth, optionsNextButtonHeight, optionsNextButtonTextSize,
                          (selected) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        numberWithoutDialCode = mobileController.text;
                        print("NUMBER:" + numberWithoutDialCode);
                        print("DIALCODE: " + getDialCode);
                        String? validMobile =
                        validatePhoneNumber(numberWithoutDialCode);
                        if (validMobile != null) {
                          showToastFun(context, validMobile);
                        } else {
                          if (getDialCode != "") {
                            getUserByMobileNo(context, getDialCode, numberWithoutDialCode, getCountryCode,
                                    (responseGetUserByMobileNo) {
                                  String appUserId =
                                      responseGetUserByMobileNo.value!.vm!.id;
                                  Navigator.pop(context);
                                  selectPlaceChangeOwnerDialog(
                                      context, height, width, appUserId);
                                });
                          } else {
                            showToastFun(context, "Please select dial code!");
                          }
                        }
                      }),
                )
              ],
            )),
      );
    });
  });

}

Future<void> getUserByMobileNo(BuildContext context, String selectedDialCode,
    String selectedPhone, String selectedCountryCode, Function onSuccess) async {
  GetUserByMobileNoVM getUserByMobileNoVM = GetUserByMobileNoVM();

  RequestGetUserByMobileNo requestGetUserByMobileNo = RequestGetUserByMobileNo(
      mobileNo: selectedPhone, contryCode: selectedCountryCode, applicationId: applicationId);

  getUserByMobileNoVM.getUserByMobileNo(requestGetUserByMobileNo);

  ApiResponse<ResponseGetUserByMobileNo> getUserByMobileNoData =
      await getUserByMobileNoVM.getUserByMobileNo(requestGetUserByMobileNo);

  if (getUserByMobileNoData.status == ApiStatus.COMPLETED) {
    ResponseGetUserByMobileNo responseGetUserByMobileNo =
        getUserByMobileNoData.data!;
    if (responseGetUserByMobileNo.value!.meta!.code == 1) {
      if(responseGetUserByMobileNo.value!.vm!.mobileNo != null){
        onSuccess(responseGetUserByMobileNo);
      } else{
        showToastFun(context, "Mobile no is not registered!");
      }
    } else {
      showToastFun(context, responseGetUserByMobileNo.value!.meta!.message);
    }
  }
}

void selectPlaceChangeOwnerDialog(BuildContext context, double height,
    double width, String selectedAppUserId) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    RequestPlacesWithOwnerPermissions requestPlacesWithOwnerPermissions =
    RequestPlacesWithOwnerPermissions(applicationId: applicationId, appuserId: appUserId);

    PlacesWithOwnerPermissionsVM placesWithOwnerPermissionsVM =
    PlacesWithOwnerPermissionsVM();
    placesWithOwnerPermissionsVM
        .getPlacesWithOwnerPermissions(requestPlacesWithOwnerPermissions);

    List<String> listSelectedPlaceIds = [];

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
          263.66,
          356.99,
          Stack(
            children: [
              DialogTitle(28.2, 24.88, "SELECT PLACE", 12.0, "Roboto"),
              DialogCloseButton(15, 18, () {
                Navigator.pop(context);
              }),
              Positioned(
                  left: getX(width, 45.45),
                  right: getX(width, 41.32),
                  top: getY(height, dialogListTopMargin),
                  child: SizedBox(
                    height: getHeight(height, dialogListHeight),
                    child: ChangeNotifierProvider<
                        PlacesWithOwnerPermissionsVM>(
                      create: (BuildContext context) =>
                      placesWithOwnerPermissionsVM,
                      child: Consumer<PlacesWithOwnerPermissionsVM>(
                        builder: (context, viewModel, view) {
                          switch (viewModel
                              .placesWithOwnerPermissionsData.status) {
                            case ApiStatus.LOADING:
                              Utils.printMsg(
                                  "PlacesWithAdminPermissionsList :: LOADING");
                              return const Loading();
                            case ApiStatus.ERROR:
                              Utils.printMsg(
                                  "PlacesWithAdminPermissionsList :: ERROR${viewModel.placesWithOwnerPermissionsData.message}");
                              return Center(
                                  child: Text(
                                    "No Places found!",
                                    style: apiMessageTextStyle(context),
                                    textAlign: TextAlign.center,
                                  ));
                            case ApiStatus.COMPLETED:
                              Utils.printMsg(
                                  "PlacesWithAdminPermissionsList :: COMPLETED");

                              List<AppUserAccessOwnerPermissions>?
                              listPlacesWithOwnerPermissions = viewModel
                                  .placesWithOwnerPermissionsData
                                  .data!
                                  .value!
                                  .appUserAccessPermissions;

                              if (listPlacesWithOwnerPermissions == null ||
                                  listPlacesWithOwnerPermissions.isEmpty) {
                                return Center(
                                    child: Text(
                                      "No Places found!",
                                      style: apiMessageTextStyle(context),
                                      textAlign: TextAlign.center,
                                    ));
                              } else {
                                Utils.printMsg(
                                    "PlacesWithOwnerPermissionsList${listPlacesWithOwnerPermissions.length}");

                                return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                    listPlacesWithOwnerPermissions
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              DialogListButton(
                                                  listPlacesWithOwnerPermissions[
                                                  index]
                                                      .homeName!,
                                                  optionsButtonWidth,
                                                  optionsButtonHeight,
                                                  optionsButtonTextSize,
                                                      () {}),
                                              DialogCheckBox(
                                                  31.85,
                                                  27.87,
                                                  listPlacesWithOwnerPermissions[
                                                  index]
                                                      .isSelected!,
                                                      (isChecked) {
                                                    String selectedPlaceId =
                                                    listPlacesWithOwnerPermissions[
                                                    index]
                                                        .homeId!;
                                                    if (isChecked) {
                                                      setState(() {
                                                        listSelectedPlaceIds.add(
                                                            selectedPlaceId);
                                                        for (int i = 0;
                                                        i <
                                                            listPlacesWithOwnerPermissions
                                                                .length;
                                                        i++) {
                                                          listPlacesWithOwnerPermissions[
                                                          i]
                                                              .isSelected =
                                                          false;
                                                        }
                                                        listPlacesWithOwnerPermissions[
                                                        index]
                                                            .isSelected = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        listSelectedPlaceIds
                                                            .remove(
                                                            selectedPlaceId);
                                                        listPlacesWithOwnerPermissions[
                                                        index]
                                                            .isSelected = false;
                                                      });
                                                    }
                                                  })
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                            getHeight(height, dialogListItemsVerticalMargin),
                                          ),
                                        ],
                                      );
                                    });
                              }
                            default:
                          }
                          return const Loading();
                        },
                      ),
                    ),
                  )),
              if(listSelectedPlaceIds.isNotEmpty) DialogButton("CONFIRM", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth, optionsNextButtonHeight, optionsNextButtonTextSize,
                      () {
                    if (listSelectedPlaceIds.isNotEmpty) {
                      alertChangeOwnerDialog(context, height, width,
                          selectedAppUserId, listSelectedPlaceIds);
                    } else {
                      showToastFun(context, "Please select place");
                    }
                  }),
              DialogNote(39.48, 324.18, "NOTE: SELECT 1 PLACE AT A TIME"),
            ],
          ),
        ),
      );
    });
  });

}

void alertChangeOwnerDialog(BuildContext context, double height, double width,
    String selectedAppUserId, List<String> listSelectedPlaceIds) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    return Center(
      child: CustomAlertDialog(
        188.45,
        129.17,
        Stack(
          children: [
            DialogCloseButton(7.0, 8.0, () {
              Navigator.pop(context);
            }),
            DialogAlertText(5, 44.24, "ARE YOU SURE YOU WANT\nTO CHANGE OWNERSHIP?"),
            Positioned.fill(
                top: getY(height, optionsAlertButtonsTopMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogListButton("YES", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                      changeOwnership(
                          context, selectedAppUserId, listSelectedPlaceIds,
                              () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
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

Future<void> changeOwnership(BuildContext context, String selectedAppUserId,
    List<String> listSelectedPlaceIds, Function onSuccess) async {
  ChangeMultipleHomesOwnershipVM changeMultipleHomesOwnershipVM =
      ChangeMultipleHomesOwnershipVM();

  List<HomeIds> listHomeIds = [];
  for (var placeId in listSelectedPlaceIds) {
    listHomeIds.add(HomeIds(homeId: placeId));
  }

  RequestChangeMultipleHomesOwnership requestChangeMultipleHomesOwnership =
      RequestChangeMultipleHomesOwnership(
    newAppUserId: selectedAppUserId,
    appUserId: appUserId,
    currDateTime: currentDateTime,
    applicationId: applicationId,
    homeIds: listHomeIds,
  );

  changeMultipleHomesOwnershipVM
      .changeMultipleHomesOwnership(requestChangeMultipleHomesOwnership);

  ApiResponse<ResponseChangeMultipleHomesOwnership>
      changeMultipleHomesOwnershipData = await changeMultipleHomesOwnershipVM
          .changeMultipleHomesOwnership(requestChangeMultipleHomesOwnership);

  if (changeMultipleHomesOwnershipData.status == ApiStatus.COMPLETED) {
    ResponseChangeMultipleHomesOwnership responseChangeMultipleHomesOwnership =
        changeMultipleHomesOwnershipData.data!;
    if (responseChangeMultipleHomesOwnership.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(
        context, responseChangeMultipleHomesOwnership.value!.meta!.message);
  }
}
