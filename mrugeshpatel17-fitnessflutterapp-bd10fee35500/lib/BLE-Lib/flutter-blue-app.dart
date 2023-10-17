import 'dart:developer';

import 'package:fitness_ble_app/BLE-Lib/device-screen.dart';
import 'package:fitness_ble_app/BLE-Lib/scan-result-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';



class FlutterBlueApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          //initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            log("Bluetooth status on or off :- ${snapshot.data}");
            if (state == BluetoothState.on) {
              return FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state!);
          }),
    );
  }
}


class FindDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Devices'),
        backgroundColor: Colors.blueAccent,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              /// connected Devices list data
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map((d) => ListTile(
                    title: Text(d.name),
                    subtitle: Text(d.id.toString()),
                    trailing: StreamBuilder<BluetoothDeviceState>(
                      stream: d.state,
                      initialData: BluetoothDeviceState.disconnected,
                      builder: (c, snapshot) {
                        if (snapshot.data ==
                            BluetoothDeviceState.connected) {
                          return RaisedButton(
                            child: Text('OPEN'),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DeviceScreen(device: d))),
                          );
                        }
                        return Text(snapshot.data.toString());
                      },
                    ),
                  ))
                      .toList(),
                ),
              ),

              /// scan result list data
              StreamBuilder<List<ScanResult>>(
                  stream: FlutterBlue.instance.scanResults,
                  initialData: [],
                  builder: (c, snapshot) {

                    return Column(
                        children: snapshot.data!
                            .map(
                              (r) => ScanResultTile(
                            result: r,
                            onTap: () => Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              r.device.connect();
                              return DeviceScreen(device: r.device);
                            })),
                          ),
                        )
                            .toList()
                    );
                  }
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  // const BluetoothOffScreen(BluetoothState? bluetoothState, {Key? key, required this.state}) : super(key: key);
  const BluetoothOffScreen({Key? key, required this.state}) : super(key: key);
  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subhead!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}