import 'package:flutter/material.dart';

import 'api_services.dart';
import 'models/api_model_class.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  late List<ApiModel>? _apiModel = [];

  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _apiModel = (await ApiServices().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
      ),
      body: _apiModel == null || _apiModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _apiModel!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_apiModel![index].homeId),
                          Text(_apiModel![index].roomId),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_apiModel![index].mobileNo),
                          Text(_apiModel![index].command),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
