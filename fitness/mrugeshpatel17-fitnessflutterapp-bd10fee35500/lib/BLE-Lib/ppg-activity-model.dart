


//class PpgActivityModel{

 //
 // var TimeValue;
 // var IR1Value;
 // var RED1Value;
 // var ACC1Value;
 // var IR2Value;
 // var  RED2Value;
 // var  ACC2Value;
 // var  AccXValue;
 // var  m/s2Value;
 // var  AccYValue;
 // var m/s2Value;
 // var AccZValue;
 // var m/s2Value;
 // var GyroXValue;
 // var  rad/sValue;
 // var  GyroYValue;
 // var rad/sValue;
 // var GyroZValue;
 // var rad/sValue;
 // var MagXValue;
 // var uTValue;
 // var  MagYValue;
 // var uTValue;
 // var MagZValue;
 // var uTValue;
 // var GSRValue;
 // var BattValue;
 // var TempValue;
 // var  HRValue;
 // var HRSValue;
 //

//}


import 'dart:typed_data';

// class PpgSettingModel{
//
//  var  sensType;
//  var ledBrightnessRed1;
//
//  var ledBrightnessIR1;
//  var  ledBrightnessGreen1;
//
//  var sampleAverage1;
//  var ledMode1;
//  var sampleRate1;
//  var pulseWidth1;
//  var adcRange1;
//
//  var  ledBrightnessRed2;
//  var ledBrightnessIR2;
//  var ledBrightnessGreen2;
//  var sampleAverage2;
//  var ledMode2;
//  var sampleRate2;
//  var pulseWidth2;
//  var adcRange2;
//
//  var accRange;
//  var gyroRange;
//  var dlpFrequency;
//  var dofSampleRate;
//
//  @override
//  String toString() {
//    return 'PpgSettingModel{sensType: $sensType, ledBrightnessRed1: $ledBrightnessRed1, ledBrightnessIR1: $ledBrightnessIR1, ledBrightnessGreen1: $ledBrightnessGreen1, sampleAverage1: $sampleAverage1, ledMode1: $ledMode1, sampleRate1: $sampleRate1, pulseWidth1: $pulseWidth1, adcRange1: $adcRange1, ledBrightnessRed2: $ledBrightnessRed2, ledBrightnessIR2: $ledBrightnessIR2, ledBrightnessGreen2: $ledBrightnessGreen2, sampleAverage2: $sampleAverage2, ledMode2: $ledMode2, sampleRate2: $sampleRate2, pulseWidth2: $pulseWidth2, adcRange2: $adcRange2, accRange: $accRange, gyroRange: $gyroRange, dlpFrequency: $dlpFrequency, dofSampleRate: $dofSampleRate}';
//  }
//
//
// }
//


class PpgActivityModel{
  var _timeStamp;


  ///Data from service "F0F0"
  var _IR1Value;
  var _BatterylevelValue;
  var _Red1Value;
  var _Heartratesensor1Value;
  var  _ACC1Value;
  var _IR2Value;
  var _Heartratesensor2Value;
  var _Red2Value;
  var  _ACC2Value;
  var  _GSR_ECGValue;
  var _Temp_integral_part; ///x
  var _Temp_fractional_part; ///y

  ///Sensor value #13 is calculated as ((x*100)+y)/100 and is a floating point number
  ///with the length of the fractional part limit to two digits, e.g. 25.43.
  var _sensorValue13;
  sensorValue13Cal(){
    if(_Temp_integral_part!=null && _Temp_fractional_part!=null){
      _sensorValue13 = ((_Temp_integral_part*100)+_Temp_fractional_part)/100;
  }}
  /// "F0D0"
  var  _ACCxValue;
  var _ACCyValue;
  var  _ACCzValue;
  var  _GYRxValue;
  var _GYRyValue;
  var  _GYRzValue;
  var  _MAGxValue;
  var  _MAGyValue;
  var  _MAGzValue;


   var _battVal;
   var _sensTemp;
   var _hrCalc;
   var _heartRate;

  // PpgActivityModel.setValueLive(
  //     this._timeStamp,
  //     this._IR1Value,
  //     this._BatterylevelValue,
  //     this._Red1Value,
  //     this._Heartratesensor1Value,
  //     this._ACC1Value,
  //     this._IR2Value,
  //     this._Heartratesensor2Value,
  //     this._Red2Value,
  //     this._ACC2Value,
  //     this._GSR_ECGValue,
  //     this._Temp_integral_part,
  //     this._Temp_fractional_part,
  //     this._sensorValue13,
  //     this._ACCxValue,
  //     this._ACCyValue,
  //     this._ACCzValue,
  //     this._GYRxValue,
  //     this._GYRyValue,
  //     this._GYRzValue,
  //     this._MAGxValue,
  //     this._MAGyValue,
  //     this._MAGzValue,
  //     this._battVal,
  //     this._sensTemp,
  //     this._hrCalc,
  //     this._heartRate);
  @override
  String toString() {
    return 'PpgActivityModel{IR1Value: $IR1Value, BatterylevelValue: $BatterylevelValue, Red1Value: $Red1Value, Heartratesensor1Value: $Heartratesensor1Value, ACC1Value: $ACC1Value, IR2Value: $IR2Value, Heartratesensor2Value: $Heartratesensor2Value, Red2Value: $Red2Value, ACC2Value: $ACC2Value, GSR_ECGValue: $GSR_ECGValue, Temp_integral_part: $Temp_integral_part, Temp_fractional_part: $Temp_fractional_part, sensorValue13: $sensorValue13, ACCxValue: $ACCxValue, ACCyValue: $ACCyValue, ACCzValue: $ACCzValue, GYRxValue: $GYRxValue, GYRyValue: $GYRyValue, GYRzValue: $GYRzValue, MAGxValue: $MAGxValue, MAGyValue: $MAGyValue, MAGzValue: $MAGzValue}';
  }
  get timeStamp => _timeStamp;

  set timeStamp(value) {
    _timeStamp = value;
  }


  get IR1Value => _IR1Value;

  set IR1Value(value) {
    _IR1Value = value;
  }

  get BatterylevelValue => _BatterylevelValue;

  set BatterylevelValue(value) {
    _BatterylevelValue = value;
  }

  get Red1Value => _Red1Value;

  set Red1Value(value) {
    _Red1Value = value;
  }

  get Heartratesensor1Value => _Heartratesensor1Value;

  set Heartratesensor1Value(value) {
    _Heartratesensor1Value = value;
  }

  get ACC1Value => _ACC1Value;

  set ACC1Value(value) {
    _ACC1Value = value;
  }

  get IR2Value => _IR2Value;

  set IR2Value(value) {
    _IR2Value = value;
  }

  get Heartratesensor2Value => _Heartratesensor2Value;

  set Heartratesensor2Value(value) {
    _Heartratesensor2Value = value;
  }

  get Red2Value => _Red2Value;

  set Red2Value(value) {
    _Red2Value = value;
  }

  get ACC2Value => _ACC2Value;

  set ACC2Value(value) {
    _ACC2Value = value;
  }

  get GSR_ECGValue => _GSR_ECGValue;

  set GSR_ECGValue(value) {
    _GSR_ECGValue = value;
  }

  get Temp_integral_part => _Temp_integral_part;

  set Temp_integral_part(value) {
    _Temp_integral_part = value;
  }

  get Temp_fractional_part => _Temp_fractional_part;

  set Temp_fractional_part(value) {
    _Temp_fractional_part = value;
  }

  get sensorValue13 => _sensorValue13;

  set sensorValue13(value) {
    _sensorValue13 = value;
  }

  get ACCxValue => _ACCxValue;

  set ACCxValue(value) {
    _ACCxValue = value;
  }

  get ACCyValue => _ACCyValue;

  set ACCyValue(value) {
    _ACCyValue = value;
  }

  get ACCzValue => _ACCzValue;

  set ACCzValue(value) {
    _ACCzValue = value;
  }

  get GYRxValue => _GYRxValue;

  set GYRxValue(value) {
    _GYRxValue = value;
  }

  get GYRyValue => _GYRyValue;

  set GYRyValue(value) {
    _GYRyValue = value;
  }

  get GYRzValue => _GYRzValue;

  set GYRzValue(value) {
    _GYRzValue = value;
  }

  get MAGxValue => _MAGxValue;

  set MAGxValue(value) {
    _MAGxValue = value;
  }

  get MAGyValue => _MAGyValue;

  set MAGyValue(value) {
    _MAGyValue = value;
  }

  get MAGzValue => _MAGzValue;

  set MAGzValue(value) {
    _MAGzValue = value;
  }

  get sensTemp => _sensTemp;

  set sensTemp(value) {
    _sensTemp = value;
  }

  get hrCalc => _hrCalc;

  set hrCalc(value) {
    _hrCalc = value;
  }

  get heartRate => _heartRate;

  set heartRate(value) {
    _heartRate = value;
  }

  get battVal => _battVal;

  set battVal(value) {
    _battVal = value;
  }
}


class BleDataModel{
  var timeStamp;


  ///Data from service "F0F0"
  var IR1Value;
  var BatterylevelValue;
  var Red1Value;
  var Heartratesensor1Value;
  var ACC1Value;
  var IR2Value;
  var Heartratesensor2Value;
  var Red2Value;
  var  ACC2Value;
  var  GSR_ECGValue;
  var Temp_integral_part; ///x
  var Temp_fractional_part; ///y

  ///Sensor value #13 is calculated as ((x*100)+y)/100 and is a floating point number
  ///with the length of the fractional part limit to two digits, e.g. 25.43.
  var sensorValue13;
  // sensorValue13Cal(){
  //   if(_Temp_integral_part!=null && _Temp_fractional_part!=null){
  //     _sensorValue13 = ((_Temp_integral_part*100)+_Temp_fractional_part)/100;
  //   }}
  /// "F0D0"
  var  ACCxValue;
  var ACCyValue;
  var  ACCzValue;
  var  GYRxValue;
  var GYRyValue;
  var  GYRzValue;
  var  MAGxValue;
  var  MAGyValue;
  var  MAGzValue;


  var battVal;
  var sensTemp;
  var hrCalc;
  var heartRate;

  BleDataModel({
      this.timeStamp,
      this.IR1Value,
      this.BatterylevelValue,
      this.Red1Value,
      this.Heartratesensor1Value,
      this.ACC1Value,
      this.IR2Value,
      this.Heartratesensor2Value,
      this.Red2Value,
      this.ACC2Value,
      this.GSR_ECGValue,
      this.Temp_integral_part,
      this.Temp_fractional_part,
      this.sensorValue13,
      this.ACCxValue,
      this.ACCyValue,
      this.ACCzValue,
      this.GYRxValue,
      this.GYRyValue,
      this.GYRzValue,
      this.MAGxValue,
      this.MAGyValue,
      this.MAGzValue,
      this.battVal,
      this.sensTemp,
      this.hrCalc,
      this.heartRate});




}


