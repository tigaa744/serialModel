import 'dart:ffi';
import 'package:serial/getmodel.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mac Serial Number',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var eCatcSerialError;
String t ='';
  String? _serialNumber;
//Text? isMac ;
  void _getSerialNumber() {
    setState(() {
      _serialNumber = getMacSerialNumber();
    });
  }


  String? getMacSerialNumber() {
    //if (Platform.isMacOS) {
      String? serialNumber;
      try {
        var processResult = Process.runSync(
            'system_profiler', ['SPHardwareDataType']);
        var output = processResult.stdout.toString();
        var lines = output.split('\n');
        for (var line in lines) {
          if (line.contains('Serial Number')) {
            serialNumber = line.split(':')[1].trim();
            break;
          }
        }
      } catch (e) {
       eCatcSerialError = e ;
        print("Failed to get Mac serial number: ${e.toString()}");
      }
      return serialNumber;
    //} else
      //isMac = Text('This Not Mac');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mac Serial Number'),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _serialNumber != null ? 'Serial Number: $_serialNumber' : 'Click Button To Get Serial Number : ',
              style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 25,

              child: ElevatedButton(

                onPressed: _getSerialNumber,
                child: Text('Get Serial Number'),
              ),
            ),
SizedBox(height: 20,),
            Container(
              width: 200,
              height: 25,

              child: ElevatedButton(onPressed: (){
  setState(() {
    eCatcSerialError = t;

  });

  }, child: Text('Reset')),
            ),

            SizedBox(height: 16,),
Text("The Status Of Serial Number:" , style: TextStyle(fontSize:20 , fontWeight: FontWeight.bold ),),
Text('${eCatcSerialError.toString()}'),


    MaterialButton(
    color: Colors.blue,
  child:   Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NEXT BAGE'),
      SizedBox(width: 5,),
      Icon(Icons.navigate_next),
    ],
  ),
         onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder:(context) => GModel(), ));
  }),

//Text('$isMac'),
SizedBox(height: 20,)
          ],


        ),
      ),
    );
  }

  }

