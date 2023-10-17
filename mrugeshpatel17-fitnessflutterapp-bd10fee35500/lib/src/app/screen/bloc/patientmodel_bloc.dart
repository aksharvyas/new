





import 'dart:async';

import 'package:fitness_ble_app/src/app/screen/model/list_patients_model.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';


class PatientModelBloc implements BlocBase {


  /// Sinks
  Sink<ListPatientsData> get onChangePatientSink => patientModelItemController.sink;
  Stream<ListPatientsData> get patientModelStream => patientModelItemController.stream.asBroadcastStream();
  StreamController<ListPatientsData> patientModelItemController = new BehaviorSubject<ListPatientsData>();



  void onChangePatientModel(ListPatientsData listPatientsData) {
      onChangePatientSink.add(listPatientsData);
      print("ppppa ${patientModelStream.first}");
      print("ppppa listPatientsData $listPatientsData");
  }

  PatientModelBloc(){
    //patientModelItemController.stream.listen(onChangePatientModel);
  }
  @override
  void dispose() {
    patientModelItemController.close();
  }

}