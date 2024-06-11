import 'package:flutter/material.dart';
import 'datamodel.dart';
// this is the app that uses callback function to receive
// data from second to first
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String datafromSecondScreen = '';

  void navigateToSecondScreen() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>SecondScreen(
            data : 'I am data from First Screen',
            // this is the call back function to retrieve data from second
            onDataReceived: (data) {
              setState(() {
                datafromSecondScreen = data;
              });
            }
        ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Data from Second Screen : $datafromSecondScreen'),
            ElevatedButton(
                onPressed: navigateToSecondScreen,
                child: Text('Go'))

          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {

  final String data;
  final Function(String) onDataReceived;
  SecondScreen({required this.data, required this.onDataReceived});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Data From FirstScreen : $data '),
            ElevatedButton(
                onPressed: () {
                  String datatoSendBack = 'hey this data from second';
                  onDataReceived(datatoSendBack);
                  Navigator.pop(context, datatoSendBack);
                },
                child: Text('Send back'))
          ],
        ),
      ),
    );
  }
}