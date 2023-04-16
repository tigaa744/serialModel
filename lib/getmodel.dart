
import 'package:flutter/material.dart';
import 'dart:io';

class GModel extends StatefulWidget {

  @override
  State<GModel> createState() => _GModelState();
}

class _GModelState extends State<GModel> {

  String? _modelNumber;

  void _getModelNumber() {
    setState(() {
      _modelNumber = getMacModelNumber();
    });
  }

  String? getMacModelNumber() {
      String? modelNumber;
      try {
        var processResult = Process.runSync('sysctl', ['-n', 'hw.model']);
        var output = processResult.stdout.toString().trim();
        modelNumber = output.replaceAll(' ', '');
      } catch (e) {

        print("Failed to get Mac model number: ${e.toString()}");
      }
      return modelNumber;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              _modelNumber != null ? '$_modelNumber' :'Click Button To Get Model',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _getModelNumber,
              child: Text('Get Model Number'),
            ),

          ],
        ),
      ),
    );
  }
}