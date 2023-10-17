import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kremot/models/GetUserByMobileNoModel.dart';
import 'package:kremot/models/PlacesWithOwnerPermissionsModel.dart';
import 'package:kremot/models/ShareMultipleAdditionalAdminsModel.dart';
import 'package:kremot/models/ShareMultiplePlacesModel.dart';
import 'package:kremot/models/ShareMultipleRoomsModel.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/view/widgets/CustomAlertDialog.dart';
import 'package:kremot/view/widgets/DialogCenterButton.dart';
import 'package:kremot/view/widgets/dialogs/ContactListDialog.dart';
import 'package:kremot/view_model/GetUserByMobileNoVM.dart';
import 'package:kremot/view_model/PlacesWithOwnerPermissionsVM.dart';
import 'package:kremot/view_model/RoomsVM.dart';
import 'package:kremot/view_model/ShareMultipleAdditionalAdminsVM.dart';
import 'package:kremot/view_model/ShareMultiplePlacesVM.dart';
import 'package:kremot/view_model/ShareMultipleRoomsVM.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../data/remote/response/ApiResponse.dart';
import '../../../data/remote/response/ApiStatus.dart';
import '../../../models/RoomsModel.dart';
import '../../../res/AppDimensions.dart';
import '../../../res/AppStyles.dart';
import '../../../utils/Constants.dart';
import '../../../utils/Utils.dart';
import '../DialogAlertText.dart';
import '../DialogNote.dart';
import '../Loading.dart';
import '../CustomDialog.dart';
import '../DialogButton.dart';
import '../DialogCheckBox.dart';
import '../DialogCloseButton.dart';
import '../DialogListButton.dart';
import '../DialogTextfield.dart';
import '../DialogTitle.dart';
import '../widget.dart';

void createSharingDialog(BuildContext context, double height, double width) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    List<String> listOptions = [
      "PLACE",
      "ROOM",
      "ADDITIONAL ADMIN",
    ];

    List<Map<String, dynamic>> listMapOptions = [];
    for (var optionName in listOptions) {
      Map<String, dynamic> mapOption = {};
      mapOption['name'] = optionName;
      mapOption['selected'] = false;
      listMapOptions.add(mapOption);
    }

    int selectedPosition = -1;

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
          263.66,
          356.99,
          Stack(
            children: [
              DialogTitle(20.57, 31.85, "SHARING", 12.0, "Roboto"),
              DialogCloseButton(15, 27, () {
                Navigator.pop(context);
              }),
              Positioned.fill(
                top: getY(height, optionsListTopMargin),
                child: ListView.builder(
                    itemCount: listMapOptions.length,
                    itemBuilder: (context, position) {
                      return Column(
                        children: [
                          DialogCenterButton(
                              listMapOptions[position]['name'],
                              optionsButtonWidth,
                              optionsButtonHeight,
                              optionsButtonTextSize, (selected) {
                            setState(() {
                              for (int i = 0;
                              i < listMapOptions.length;
                              i++) {
                                listMapOptions[i]['selected'] = false;
                              }

                              if (selected) {
                                selectedPosition = position;
                                listMapOptions[position]['selected'] = true;
                              } else {
                                selectedPosition = -1;
                              }
                            });
                          },
                              tapped: true,
                              selected: listMapOptions[position]
                              ['selected']),
                          SizedBox(
                            height: getHeight(height, optionsButtonTopMargin),
                          ),
                        ],
                      );
                    }),
              ),
              if (selectedPosition != -1)
                DialogButton("NEXT", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth,
                    optionsNextButtonHeight, optionsNextButtonTextSize, () async {
                      String type = "";
                      switch (selectedPosition) {
                        case 0:
                          type = "PLACE";
                          break;
                        case 1:
                          type = "ROOM";
                          break;
                        case 2:
                          type = "ADDITIONAL ADMIN";
                          break;
                      }

                      PermissionStatus permissionStatus =
                      await Permission.contacts.status;
                      if (permissionStatus == PermissionStatus.granted) {
                        Navigator.pop(context);
                        createSharingPersonDialog(context, height, width, type);
                      } else {
                        alertAccessDialog(context, height, width, type);
                      }
                    })
            ],
          ),
        ),
      );
    });
  });
}

void alertAccessDialog(
    BuildContext context, double height, double width, String type) {

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
                      _askPermissions(context, height, width, type);
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

Future<void> _askPermissions(
    BuildContext context, double height, double width, String type) async {
  PermissionStatus permissionStatus = await _getContactPermission();
  if (permissionStatus == PermissionStatus.granted) {
    Navigator.pop(context);
    createSharingPersonDialog(context, height, width, type);
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
    const snackBar =
        SnackBar(content: Text('Contact data not available on device'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void createSharingPersonDialog(
    BuildContext context, double height, double width, String type) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    TextEditingController mobileController = TextEditingController();
    PhoneNumber number = PhoneNumber(isoCode: 'IN');
    String numberWithoutDialCode = "";
    String getDialCode = "+91";
    String getCountryCode = "IN";

    Contact? currentSelectedContact;
    List<String> listSelectedMobileNos = [];
    List<String> listSelectedAppUserIds = [];

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
          263.66,
          356.99,
          Stack(
            children: [
              DialogTitle(
                  20.57,
                  31.85,
                  type == "ADDITIONAL ADMIN" ? type : "ADD SHARING PERSON",
                  12.0,
                  "Roboto"),
              DialogCloseButton(15, 27, () {
                Navigator.pop(context);
              }),
              Positioned.fill(
                top: getY(height, 100.36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (listSelectedMobileNos.length < 3)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(width, 40)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: getWidth(width, 10)),
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
                                    autoValidateMode:
                                    AutovalidateMode.disabled,
                                    selectorTextStyle:
                                    hintTextStyle(context),
                                    initialValue: number,
                                    formatInput: false,
                                    spaceBetweenSelectorAndTextField: 0,
                                    selectorButtonOnErrorPadding: 0,
                                    maxLength: 10,
                                    textStyle: hintTextStyle(context),
                                    validator: validatePhoneNumber,
                                    textFieldController: mobileController,
                                    keyboardType: const TextInputType
                                        .numberWithOptions(
                                        signed: true, decimal: true),
                                    //inputBorder:  const OutlineInputBorder(borderSide: BorderSide(color: Color(0x80eceded), width: 1),),
                                    inputDecoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        // fillColor: const Color(0xb81b1918),
                                        contentPadding:
                                        const EdgeInsets.only(
                                            left: 0, top: 0, bottom: 0),
                                        isDense: true,
                                        filled: true,
                                        hintText: "MOBILE NO",
                                        hintStyle: TextStyle(color: highLightColor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Roboto",
                                            fontStyle: FontStyle.normal,
                                            fontSize: getAdaptiveTextSize(context, 12.0)),
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
                                    return ContactListDialog(
                                        width, height, (contact) {
                                      setState(() {
                                        currentSelectedContact =
                                            contact;

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
                                            mobileController.text =
                                                phone;
                                            numberWithoutDialCode =
                                                phone;
                                            getDialCode = dialCode;
                                            getCountryCode =
                                                countryCode;
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
                    if (listSelectedMobileNos.length < 3)
                      SizedBox(
                        height: getHeight(height, 10),
                      ),
                    if (listSelectedMobileNos.length < 3)
                      Container(
                        margin: EdgeInsets.only(left: getWidth(width, 40)),
                        child: DialogCenterButton(
                            "Add", 65.74, 30.52, optionsNextButtonTextSize,
                                (selected) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              numberWithoutDialCode = mobileController.text;
                              print("NUMBER:" + numberWithoutDialCode);
                              print("DIALCODE: " + getDialCode);
                              print("COUNTRYCODE: " + getCountryCode);
                              String? validMobile =
                              validatePhoneNumber(numberWithoutDialCode);
                              if (validMobile != null) {
                                showToastFun(context, validMobile);
                              } else {
                                if (!listSelectedMobileNos.contains(
                                    getDialCode + numberWithoutDialCode)) {
                                  if (getDialCode != "") {
                                    getUserByMobileNo(context, getDialCode,
                                        numberWithoutDialCode, getCountryCode,
                                            (responseGetUserByMobileNo) {
                                          String appUserId =
                                              responseGetUserByMobileNo.value!.vm!.id;
                                          listSelectedAppUserIds.add(appUserId);
                                          setState(() {
                                            listSelectedMobileNos.add(
                                                getDialCode + numberWithoutDialCode);
                                          });
                                          mobileController.clear();
                                        });
                                  } else {
                                    showToastFun(
                                        context, "Please select dial code!");
                                  }
                                } else {
                                  showToastFun(
                                      context, "Mobile no is already added!");
                                }
                              }
                            }),
                      ),
                    SizedBox(
                      height: getHeight(height, 10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: getHeight(height, 125),
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: listSelectedMobileNos.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: getWidth(width, 40)),
                                      width: getWidth(width, 115),
                                      height: getHeight(height, 35),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: getWidth(width, 5)),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                              const Color(0x80eceded),
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
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: DefaultTextStyle(
                                              style: const TextStyle(),
                                              child: Text(
                                                  listSelectedMobileNos[
                                                  index],
                                                  style: hintTextStyle(
                                                      context)))),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(height, 10),
                    ),
                  ],
                ),
              ),
              if (listSelectedMobileNos.isNotEmpty)
                DialogButton("Next", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, 65.74, 30.52,
                    optionsNextButtonTextSize, () {
                      if (type == "ADDITIONAL ADMIN") {
                        alertSharingDialog(context, height, width, type,
                            listSelectedAppUserIds, []);
                      } else {
                        Navigator.pop(context);
                        selectPlaceDialog(context, height, width, type,
                            listSelectedAppUserIds);
                      }
                    }),
            ],
          ),
        ),
      );
    });
  });
}

Future<void> getUserByMobileNo(
    BuildContext context,
    String selectedDialCode,
    String selectedPhone,
    String selectedCountryCode,
    Function onSuccess) async {
  GetUserByMobileNoVM getUserByMobileNoVM = GetUserByMobileNoVM();

  RequestGetUserByMobileNo requestGetUserByMobileNo = RequestGetUserByMobileNo(
      mobileNo: selectedPhone,
      contryCode: selectedCountryCode,
      applicationId: applicationId);

  getUserByMobileNoVM.getUserByMobileNo(requestGetUserByMobileNo);

  ApiResponse<ResponseGetUserByMobileNo> getUserByMobileNoData =
      await getUserByMobileNoVM.getUserByMobileNo(requestGetUserByMobileNo);

  if (getUserByMobileNoData.status == ApiStatus.COMPLETED) {
    ResponseGetUserByMobileNo responseGetUserByMobileNo =
        getUserByMobileNoData.data!;
    if (responseGetUserByMobileNo.value!.meta!.code == 1) {
      if (responseGetUserByMobileNo.value!.vm!.mobileNo != null) {
        onSuccess(responseGetUserByMobileNo);
      } else {
        showToastFun(context, "Mobile no is not registered!");
      }
    } else {
      showToastFun(context, responseGetUserByMobileNo.value!.meta!.message);
    }
  }
}

void selectPlaceDialog(BuildContext context, double height, double width,
    String type, List<String> listSelectedAppUserIds) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    RequestPlacesWithOwnerPermissions requestPlacesWithOwnerPermissions = RequestPlacesWithOwnerPermissions(applicationId: applicationId, appuserId: appUserId);

    PlacesWithOwnerPermissionsVM placesWithOwnerPermissionsVM = PlacesWithOwnerPermissionsVM();
    placesWithOwnerPermissionsVM.getPlacesWithOwnerPermissions(requestPlacesWithOwnerPermissions);

    List<String> listSelectedPlaceIds = [];
    String selectedPlaceId = "";
    String selectedPlaceName = "";

    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
          263.66,
          356.99,
          Stack(
            children: [
              DialogTitle(
                  28.2,
                  24.88,
                  "SELECT PLACE",
                  12.0,
                  "Roboto"),
              DialogCloseButton(15, 21, () {
                Navigator.pop(context);
              }),
              Positioned(
                  left: getX(width, 45.45),
                  right: getX(width, 51.32),
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
                                  "PlacesWithOwnerPermissionsList :: LOADING");
                              return const Loading();
                            case ApiStatus.ERROR:
                              Utils.printMsg(
                                  "PlacesWithOwnerPermissionsList :: ERROR${viewModel.placesWithOwnerPermissionsData.message}");
                              return Center(
                                  child: DefaultTextStyle(
                                      style: const TextStyle(),
                                      child: Text(
                                        "No Places found!",
                                        style: apiMessageTextStyle(context),
                                        textAlign: TextAlign.center,
                                      )));
                            case ApiStatus.COMPLETED:
                              Utils.printMsg(
                                  "PlacesWithOwnerPermissionsList :: COMPLETED");

                              List<AppUserAccessOwnerPermissions>?
                              listPlacesWithOwnerPermissions = viewModel
                                  .placesWithOwnerPermissionsData
                                  .data!
                                  .value!
                                  .appUserAccessPermissions;

                              if (listPlacesWithOwnerPermissions == null ||
                                  listPlacesWithOwnerPermissions.isEmpty) {
                                return Center(
                                    child: DefaultTextStyle(
                                        style: const TextStyle(),
                                        child: Text(
                                          "No Places found!",
                                          style:
                                          apiMessageTextStyle(context),
                                          textAlign: TextAlign.center,
                                        )));
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
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              DialogListButton(
                                                  listPlacesWithOwnerPermissions[
                                                  index]
                                                      .homeName!,
                                                  90,
                                                  35,
                                                  optionsButtonTextSize,
                                                      () {}),
                                              DialogCheckBox(
                                                  31.85,
                                                  27.87,
                                                  listPlacesWithOwnerPermissions[
                                                  index]
                                                      .isSelected!,
                                                      (isChecked) {
                                                    if (isChecked) {
                                                      selectedPlaceName =
                                                      listPlacesWithOwnerPermissions[
                                                      index]
                                                          .homeName!;
                                                      selectedPlaceId =
                                                      listPlacesWithOwnerPermissions[
                                                      index]
                                                          .homeId!;

                                                      listSelectedPlaceIds
                                                          .add(selectedPlaceId);

                                                      setState(() {
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
                                                      selectedPlaceName = "";
                                                      selectedPlaceId = "";

                                                      listSelectedPlaceIds.remove(
                                                          listPlacesWithOwnerPermissions[
                                                          index]
                                                              .homeId!);

                                                      setState(() {
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
              if (listSelectedPlaceIds.isNotEmpty)
                DialogButton("DONE", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth, optionsNextButtonHeight,
                    optionsNextButtonTextSize, () {
                      if (listSelectedPlaceIds.isNotEmpty) {
                        if (type == "ROOM") {
                          Navigator.pop(context);
                          selectRoomDialog(
                              context,
                              height,
                              width,
                              type,
                              selectedPlaceId,
                              selectedPlaceName,
                              listSelectedAppUserIds);
                        } else {
                          alertSharingDialog(context, height, width, type,
                              listSelectedAppUserIds, listSelectedPlaceIds);
                        }
                      } else {
                        showToastFun(context, "Please select place");
                      }
                    }),
              DialogNote(39.48, 324.18,
                  "NOTE: SELECT 1 PLACE & MULTIPLE ROOM AT A TIME")
            ],
          ),
        ),
      );
    });
  });
}

void selectRoomDialog(
    BuildContext context,
    double height,
    double width,
    String type,
    String placeId,
    String placeName,
    List<String> listSelectedAppUserIds) {

  Utils.showDialog(context, (context, animation, secondaryAnimation) {
    RequestRooms requestRooms = RequestRooms(
        applicationId: applicationId,
        appuserId: appUserId,
        homeId: placeId);

    RoomsVM roomsVM = RoomsVM();
    roomsVM.getAllRooms(requestRooms);

    List<String> listSelectedRoomIds = [];

    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
      return Center(
        child: CustomDialog(
          263.66,
          356.99,
          Stack(
            children: [
              DialogTitle(28.2, 24.88, "SELECT ROOM", 12.0, "Roboto"),
              DialogCloseButton(15, 21, () {
                Navigator.pop(context);
              }),
              DialogButton(
                  placeName, 102.67, 45.33, 90, 35, optionsButtonTextSize, () {}),
              Positioned(
                left: getX(width, 45.45),
                right: getX(width, 51.32),
                top: getY(height, dialogHeaderListTopMargin),
                child: SizedBox(
                  height: getHeight(height, dialogListHeight),
                  child: ChangeNotifierProvider<RoomsVM>(
                    create: (BuildContext context) => roomsVM,
                    child: Consumer<RoomsVM>(
                      builder: (context, viewModel, view) {
                        switch (viewModel.roomsData.status) {
                          case ApiStatus.LOADING:
                            Utils.printMsg("RoomsList :: LOADING");
                            return const Loading();
                          case ApiStatus.ERROR:
                            Utils.printMsg(
                                "RoomsList :: ERROR${viewModel.roomsData.message}");
                            return Center(
                                child: Text(
                                  "No Rooms found!",
                                  style: apiMessageTextStyle(context),
                                  textAlign: TextAlign.center,
                                ));
                          case ApiStatus.COMPLETED:
                            Utils.printMsg("RoomsList :: COMPLETED");
                            if (viewModel.roomsData.data!.value!
                                .appUserAccessPermissionsRoom ==
                                null) {
                              return Center(
                                  child: Text(
                                    "No Rooms found!",
                                    style: apiMessageTextStyle(context),
                                    textAlign: TextAlign.center,
                                  ));
                            } else {
                              Utils.printMsg(
                                  "RoomsList${viewModel.roomsData.data!.value!.appUserAccessPermissionsRoom!.length}");
                              List<dynamic> roomsList = viewModel
                                  .roomsData
                                  .data!
                                  .value!
                                  .appUserAccessPermissionsRoom!;
                              return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: roomsList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            DialogListButton(
                                                roomsList[index].roomName!,
                                                90,
                                                35,
                                                optionsButtonTextSize,
                                                    () {}),
                                            DialogCheckBox(
                                                31.85,
                                                27.87,
                                                roomsList[index]
                                                    .isSelected!,
                                                    (isChecked) {
                                                  String selectedRoomId =
                                                  roomsList[index].roomId!;
                                                  if (isChecked) {
                                                    listSelectedRoomIds
                                                        .add(selectedRoomId);

                                                    setState(() {
                                                      for (int i = 0;
                                                      i < roomsList.length;
                                                      i++) {
                                                        roomsList[i]
                                                            .isSelected = false;
                                                      }
                                                      roomsList[index]
                                                          .isSelected = true;
                                                    });
                                                  } else {
                                                    listSelectedRoomIds
                                                        .remove(selectedRoomId);

                                                    setState(() {
                                                      roomsList[index]
                                                          .isSelected = false;
                                                    });
                                                  }
                                                })
                                          ],
                                        ),
                                        SizedBox(
                                          height: getHeight(height, dialogListItemsVerticalMargin),
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
                ),
              ),
              if (listSelectedRoomIds.isNotEmpty)
                DialogButton("DONE", optionsNextButtonLeftMargin, optionsNextButtonTopMargin, optionsNextButtonWidth, optionsNextButtonHeight, optionsNextButtonTextSize,
                        () {
                      if (listSelectedRoomIds.isNotEmpty) {
                        alertSharingDialog(context, height, width, type,
                            listSelectedAppUserIds, listSelectedRoomIds);
                      } else {
                        showToastFun(context, "Please select room");
                      }
                    }),
              DialogNote(39.48, 324.18,
                  "NOTE: SELECT 1 PLACE & MULTIPLE ROOM AT A TIME"),
            ],
          ),
        ),
      );
    });
  });
}

void alertSharingDialog(
    BuildContext context,
    double height,
    double width,
    String type,
    List<String> listSelectedAppUserIds,
    List<String> listSelectedHomeRoomIds) {

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
            DialogAlertText(
                5, 44.24, "ARE YOU SURE YOU WANT\nTO SHARE $type?"),
            Positioned.fill(
                top: getY(height, optionsAlertButtonsTopMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DialogListButton("YES", optionsAlertButtonWidth, optionsAlertButtonHeight, optionsAlertButtonTextSize, () {
                      if (type == "PLACE") {
                        shareMultiplePlaces(context, listSelectedAppUserIds,
                            listSelectedHomeRoomIds, () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                      } else if (type == "ROOM") {
                        shareMultipleRooms(context, listSelectedAppUserIds,
                            listSelectedHomeRoomIds, () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                      } else {
                        shareMultipleAdditionalAdmins(
                            context, listSelectedAppUserIds, () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      }
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

Future<void> shareMultiplePlaces(
    BuildContext context,
    List<String> listSelectedAppUserIds,
    List<String> listSelectedPlaceIds,
    Function onSuccess) async {
  ShareMultiplePlacesVM shareMultiplePlacesVM = ShareMultiplePlacesVM();

  List<AppUserHome> listSelectedAppUsers = [];
  for (var selectedAppUserId in listSelectedAppUserIds) {
    listSelectedAppUsers.add(AppUserHome(appUserId: selectedAppUserId));
  }

  List<Home> listSelectedPlaces = [];
  for (var selectedHomeId in listSelectedPlaceIds) {
    listSelectedPlaces.add(Home(homeId: selectedHomeId));
  }

  RequestShareMultiplePlaces requestShareMultiplePlaces =
      RequestShareMultiplePlaces(
          applicationId: applicationId,
          isOwner: false,
          isAdditionalAdmin: false,
          isAdditionalUser: true,
          createdDateTime: currentDateTime,
          createdBy: appUserId,
          appUser: listSelectedAppUsers,
          home: listSelectedPlaces);

  ApiResponse<ResponseShareMultiplePlaces> shareMultiplePlacesData =
      await shareMultiplePlacesVM
          .shareMultiplePlaces(requestShareMultiplePlaces);

  if (shareMultiplePlacesData.status == ApiStatus.COMPLETED) {
    ResponseShareMultiplePlaces responseShareMultiplePlaces =
        shareMultiplePlacesData.data!;
    if (responseShareMultiplePlaces.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(context, responseShareMultiplePlaces.value!.meta!.message);
  }
}

Future<void> shareMultipleRooms(
    BuildContext context,
    List<String> listSelectedAppUserIds,
    List<String> listSelectedRoomIds,
    Function onSuccess) async {
  ShareMultipleRoomsVM shareMultipleRoomsVM = ShareMultipleRoomsVM();

  List<AppUserRoom> listSelectedAppUsers = [];
  for (var selectedAppUserId in listSelectedAppUserIds) {
    listSelectedAppUsers.add(AppUserRoom(appUserId: selectedAppUserId));
  }

  List<Room> listSelectedRooms = [];
  for (var selectedRoomId in listSelectedRoomIds) {
    listSelectedRooms.add(Room(roomId: selectedRoomId));
  }

  RequestShareMultipleRooms requestShareMultipleRooms =
      RequestShareMultipleRooms(
          applicationId: applicationId,
          isOwner: false,
          isAdditionalAdmin: false,
          isAdditionalUser: true,
          createdDateTime: currentDateTime,
          createdBy: appUserId,
          appUser: listSelectedAppUsers,
          room: listSelectedRooms);

  ApiResponse<ResponseShareMultipleRooms> shareMultipleRoomsData =
      await shareMultipleRoomsVM.shareMultipleRooms(requestShareMultipleRooms);

  if (shareMultipleRoomsData.status == ApiStatus.COMPLETED) {
    ResponseShareMultipleRooms responseShareMultipleRooms =
        shareMultipleRoomsData.data!;
    if (responseShareMultipleRooms.value!.meta!.code == 1) {
      onSuccess();
    } else {
      showToastFun(context, responseShareMultipleRooms.value!.meta!.message);
    }
  }
}

Future<void> shareMultipleAdditionalAdmins(BuildContext context,
    List<String> listSelectedAppUserIds, Function onSuccess) async {
  ShareMultipleAdditionalAdminsVM shareMultipleAdditionalAdminsVM =
      ShareMultipleAdditionalAdminsVM();

  List<AppUser> listSelectedAppUsers = [];
  for (var selectedAppUserId in listSelectedAppUserIds) {
    listSelectedAppUsers.add(AppUser(appUserId: selectedAppUserId));
  }

  RequestShareMultipleAdditionalAdmins requestShareMultipleAdditionalAdmins =
      RequestShareMultipleAdditionalAdmins(
    applicationId: applicationId,
    isOwner: false,
    isAdditionalAdmin: true,
    isAdditionalUser: false,
    createdDateTime: currentDateTime,
    createdBy: appUserId,
    appUser: listSelectedAppUsers,
  );

  ApiResponse<ResponseShareMultipleAdditionalAdmins>
      shareMultipleAdditionalAdminsData = await shareMultipleAdditionalAdminsVM
          .shareMultipleAdditionalAdmins(requestShareMultipleAdditionalAdmins);

  if (shareMultipleAdditionalAdminsData.status == ApiStatus.COMPLETED) {
    ResponseShareMultipleAdditionalAdmins
        responseShareMultipleAdditionalAdmins =
        shareMultipleAdditionalAdminsData.data!;
    if (responseShareMultipleAdditionalAdmins.value!.meta!.code == 1) {
      onSuccess();
    }
    showToastFun(
        context, responseShareMultipleAdditionalAdmins.value!.meta!.message);
  }
}
