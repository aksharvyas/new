




import 'package:fitness_ble_app/src/app/screen/bloc/bloc_provider.dart';
import 'package:fitness_ble_app/src/app/screen/bloc/patientmodel_bloc.dart';
import 'package:fitness_ble_app/src/app/screen/resources/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GlobalBloc implements BlocBase {


  static Repository? repository;
 late PatientModelBloc patientModelBloc;
  GlobalBloc() {
    patientModelBloc = PatientModelBloc();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    patientModelBloc.dispose();
  }

  }
