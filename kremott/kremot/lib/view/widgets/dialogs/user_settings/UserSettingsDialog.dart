import 'package:flutter/material.dart';
import 'package:kremot/view/widgets/CustomDialog.dart';
import 'package:provider/provider.dart';

import '../../../../data/remote/response/ApiStatus.dart';
import '../../../../models/GetUserSettingsModel.dart';
import '../../../../res/AppStyles.dart';
import '../../../../utils/Constants.dart';
import '../../../../utils/Utils.dart';
import '../../../../view_model/GetUserSettingsVM.dart';
import '../../Loading.dart';
import '../../widget.dart';
import 'UserSettingsView.dart';

class UserSettingsDialog extends StatefulWidget {
  double width;
  double height;

  UserSettingsDialog(this.width, this.height, {Key? key}) : super(key: key);

  @override
  State<UserSettingsDialog> createState() => _UserSettingsDialogState();
}

class _UserSettingsDialogState extends State<UserSettingsDialog> {
  GetUserSettingsVM getUserSettingsVM = GetUserSettingsVM();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    RequestGetUserSettings requestGetUserSettingsModel =
        RequestGetUserSettings(applicationId: applicationId, id: 50);
    getUserSettingsVM.getUserSettings(requestGetUserSettingsModel);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomDialog(
        253,
        545,
        ChangeNotifierProvider<GetUserSettingsVM>(
          create: (BuildContext context) => getUserSettingsVM,
          child: Consumer<GetUserSettingsVM>(
            builder: (context, viewModel, view) {
              switch (viewModel.getUserSettingsData.status) {
                case ApiStatus.LOADING:
                  Utils.printMsg("GetUserSettings :: LOADING");
                  return const Loading();
                case ApiStatus.ERROR:
                  Utils.printMsg(
                      "GetUserSettings :: ERROR${viewModel.getUserSettingsData.message}");
                  return Center(
                      child: Text(
                    "No User Settings found!",
                    style: apiMessageTextStyle(context),
                    textAlign: TextAlign.center,
                  ));
                case ApiStatus.COMPLETED:
                  Utils.printMsg("GetUserSettings :: COMPLETED");

                  Vm? vm = viewModel.getUserSettingsData.data!.value!.vm;
                  if (vm == null || vm.appUserId == null) {
                    return Center(
                        child: Text(
                      "No User Settings found!",
                      style: apiMessageTextStyle(context),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    return UserSettingsView(widget.width, widget.height, vm);
                  }
                default:
              }
              return const Loading();
            },
          ),
        ),
      ),
    );
  }
}
