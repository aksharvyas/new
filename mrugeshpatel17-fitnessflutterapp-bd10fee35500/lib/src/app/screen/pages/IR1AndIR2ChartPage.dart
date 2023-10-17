


import 'package:fitness_ble_app/src/app/screen/model/IR1_and_IR2_model.dart';
import 'package:fitness_ble_app/src/app/screen/model/list_patients_model.dart';
import 'package:fitness_ble_app/src/app/screen/resources/provider.dart';
import 'package:flutter/material.dart';

import 'ble_listing_page.dart';

class IR1AndIR2ChartPage extends StatefulWidget {
  ListPatientsData addPatientModel;
  IR1AndIR2ChartPage(this.addPatientModel);
  @override
  _IR1AndIR2ChartPageState createState() => _IR1AndIR2ChartPageState(addPatientModel);
}

class _IR1AndIR2ChartPageState extends State<IR1AndIR2ChartPage> {
  ListPatientsData? addPatientModel;
  _IR1AndIR2ChartPageState(this.addPatientModel);
  ApiProvider apiProvider = ApiProvider();
  RequestIR1AndIR2? requestIR1AndIR2;

  IR1AndIR2Model? ir1andIR2Model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCalling();
  }
  apiCalling()async{
    requestIR1AndIR2 = RequestIR1AndIR2(patient_id: addPatientModel!.id.toString(),
            params:["ir1_value","ir2_value"]);
    ir1andIR2Model = await apiProvider.getpatientdata(requestIR1AndIR2!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IR1 And IR2 Chart Page"),),
      body: Column(
        children: [
          ir1andIR2Model != null ? barChartWidget() : CircularProgressIndicator()
        ],
      ),
    );
  }


  barChartWidget(){
    return ;
  }
}
