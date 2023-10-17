import 'dart:convert';

import 'package:kremot/models/PairingModel.dart';


  String? nonPairedDevicesConnect() {
    CommunicationCommand communicationCommand = CommunicationCommand(
        key: "AUTOMATIC (APP OPENED OR LAUNCHED OR REGISTRATION COMPLETE)",
        commandCode:
            '550DAAAAFDBCCDDEFDFDABABABABABABABABABABABABABABABABABABFDFDFDAA');
    return jsonEncode(communicationCommand);
  }

   String pairingKey() {
    CommunicationCommandPairing communicationCommand = CommunicationCommandPairing(
        CMID:"PAIRING",
        commandCode: '55 0D BB BB FD BC CD DE FD FD AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB FD FD FD AA');

    return jsonEncode(communicationCommand);
  }

  String? slowBlinking() {
    CommunicationCommandDevice communicationCommandDevice =
        CommunicationCommandDevice(
            key: "ANY KEY TOUCHED IN THE DEVICE",
            commandCode:
                '44 0D BB BB FD BC CD DE FD FD AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB FD FD FD BB',
            companyId: "DEVICE TYPE",
            deviceId: "COMPANY NAME",
            cmacId: "COMBINATION OF 4 MACIDs");

    return jsonEncode(communicationCommandDevice);
  }

  String? sendAndConfirmDataFromDataBaseRecivedFromDevice() {
    CommunicationCommandDevice communicationCommandDevice =
        CommunicationCommandDevice(
            key: "NO KEY",
            commandCode:
                '330DWWWWFDBCCDDEFDFDABABABABABABABABABABABABABABABABABABFDFDFDCC',
            companyId: "DEVICE TYPE (VALUE)",
            deviceId: "COMPANY NAME (VALUE)",
            cmacId: "COMBINATION OF 4 MACIDs (VALUE)");

    return jsonEncode(communicationCommandDevice);
  }



  // String ledStopBlink() {
  //   LedStopBlinking ledStopBlinking = LedStopBlinking(
  //       key: "NO KEY",
  //       commandCode: "55 0D CC CC FD BC CD DE FD FD AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB AB FD FD FD AA", homeId: "VALUE", roomId: "VALUE", mobileNumber: "VALUE", appId: "VALUE");
  //
  //   return jsonEncode(ledStopBlinking);
  // }

  String? ledStopBlinkResponse() {
    CommunicationCommandDevice communicationCommandDevice =
        CommunicationCommandDevice(
            key: "NO KEY",
            commandCode:
                '440DDDDDFDBCCD(COMPANY ID)DEFDFDABABABABABABABABABABABABABABABABABABFDFDFDBB',
            companyId: "DEVICE TYPE (VALUE)",
            deviceId: "COMPANY NAME (VALUE)",
            cmacId: "COMBINATION OF 4 MACIDs (VALUE)");

    return jsonEncode(communicationCommandDevice);
  }

  String? deviceUserDataRequest() {
    DataSave dataSave = DataSave(
        key: "NO KEY",
        commandCode:
            "330DUUUUFDBCFDFDABABABABABABABABABABABABABABABABABABFDFDFDCC",
        deviceId: "DEVICE TYPE (VALUE)",
        companyId: "COMPANY NAME (VALUE)",
        cmacId: "COMBINATION OF 4 MACIDs (VALUE)",
        ssidOfWifiRouter: "(VALUE)",
        homeId: "(VALUE)",
        roomId: "(VALUE)",
        mobileNumber: "(VALUE)",
        appId: "(VALUE)",
        gpsLocation: "(VALUE)");

    return jsonEncode(dataSave);
  }

  String? deviceUserDataResponse() {
    DataSave dataSave = DataSave(
        key: "NO KEY",
        commandCode:
            "220DUUUUFDBCCDDEFDFDABABABABABABABABABABABABABABABABABABFDFDFDDD",
        deviceId: "DEVICE TYPE (VALUE)",
        companyId: "COMPANY NAME (VALUE)",
        cmacId: "COMBINATION OF 4 MACIDs (VALUE)",
        ssidOfWifiRouter: "(VALUE)",
        homeId: "(VALUE)",
        roomId: "(VALUE)",
        mobileNumber: "(VALUE)",
        appId: "(VALUE)",
        gpsLocation: "(VALUE)");

    return jsonEncode(dataSave);
  }



  String? cmacIdStatus() {
    CommunicationCommandDevice communicationCommandDevice =
        CommunicationCommandDevice(
            key: "NO KEY",
            commandCode:
                '440D0000FDBCCDDEFDFDABABABABABABABABABABABABABABABABABABFDFDFDBB',
            companyId: "DEVICE TYPE (VALUE)",
            deviceId: "COMPANY NAME (VALUE)",
            cmacId: "COMBINATION OF 4 MACIDs (VALUE)");

    return jsonEncode(communicationCommandDevice);
  }

  String? deviceLogSaveRequest() {
    LogSave logSave = LogSave(
        key: "AUTOMATIC",
        commandCode:
            '330DSSSSFDBCDEFDFDABABABABABABABABABABABABABABABABABABFDFDFDCC',
        cmacId: "(VALUE)");

    return jsonEncode(logSave);
  }

  String? deviceLogSaveResponse() {
    LogSave logSave = LogSave(
        key: "NO KEY",
        commandCode:
            '220DSSSSFDBCCDDEFDFDABABABABABABABABABABABABABABABABABABFDFDFDDD',
        cmacId: "(VALUE)");

    return jsonEncode(logSave);
  }

