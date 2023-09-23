import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/emoticon_face.dart';
import 'package:flutter_application_1/util/exercise_tile.dart';
import 'package:flutter_application_1/util/DisplayUI.dart';
import 'package:empatica_e4link/empatica.dart';

// create a device manager that will handle method calls

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex =0;
  int ideal_number = 10;
  int ideal_number_2 = 15;
  
  var names = <String> ["Patrick", "Fred", "David", "Max", "Aidan", "Eli", "Magnus"];
  int numStudents = 7;
  PageController pageController = PageController();

  void onTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index, duration: Duration(milliseconds: 10),curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    EmpaticaPlugin deviceManager = EmpaticaPlugin();

  deviceManager.authenticateWithAPIKey('your api key goes ');

// first listen to status events before trying to connect
  deviceManager.statusEventSink?.listen((event) async {
      switch (event.runtimeType) {
        case UpdateStatus:
          //the status of the device manager
          print((event as UpdateStatus).status);
          break;
        case DiscoverDevice:
          await deviceManager.connectDevice((event as DiscoverDevice).device);
          break;
      }
    });

// when status is READY we can start scanning for devices
    deviceManager.startScanning();
    numStudents = names.length;
    return Scaffold(
      
      body: PageView(
        controller: pageController,
        children: [
          Container(
          color:Colors.blue[900],
          child: SafeArea(
        child: Column(children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            //Hi Jared
            
            Padding(padding: EdgeInsets.all(16), child: Text('Teacher Mode',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ))
          ),
          ]),
          /*SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'How is the student feeling?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.more_horiz,
              color: Colors.white,
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          //emoticons
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            //bad
            EmoticonFace(emoticonFace: '☹️',
            ),
            //cry
            EmoticonFace(emoticonFace: '😢',
            ),
            //confused
            EmoticonFace(emoticonFace: '🫤',
            ),
            //excellent
            EmoticonFace(emoticonFace: '😊',
            )
          ],
          ),*/
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(25),
              color: Colors.grey[400],
              child: Center(
                child: Column(
                  children:[
                  const Row(
                    children: [
                      Text('Students',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ],
                  ),
                  const SizedBox(
                  height: 15,
                  ),
                  //student list
                  Column (children: [
                  for (int i = 0; i < (numStudents/3).ceil(); i++)
                  Wrap(children : [
                    Row(children: [
                      const SizedBox(width: 8),
                      for (int j = i*3; j < i*3+3; j++)
                        if (j < names.length)
                          Wrap( children: [
                            ExerciseTile(names[j], i.toString()),
                            if (j != i*3+2)
                              const SizedBox(width: 30),
                          ]),
                      ]),
                      const SizedBox(height: 90)
                    ]),
          ])
                ]),
              ),
            ),
          ),
        ],
        ),
      ),
                ),
          Container(
          color:Colors.blue[100],
          child: SafeArea(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            //Hi Jared
            Text('Heart Rate Details',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ]),
          SizedBox(
            height: 20,
          ),
                    Column (mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (int i = 0; i < (numStudents/3).ceil(); i++)
                  Wrap(children : [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      for (int j = i*3; j < i*3+3; j++)
                        if (j < names.length)
                          Wrap( children: [
                            ChildDisplay(names[j], DisplayType.HeartRate),
                            if (j != i*3+2 || j < names.length)
                              const SizedBox(width: 40),
                          ]),
                      ]),
                      const SizedBox(height: 150)
                    ]),
          ])
        ],
        ),
      ),
                ),
      Container(
          color:Colors.blue[100],
          child: SafeArea(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            //Hi Jared
            Text('Skin Temperature Details',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ]),
          SizedBox(
            height: 20,
          ),
                    Column (mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (int i = 0; i < (numStudents/3).ceil(); i++)
                  Wrap(children : [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      for (int j = i*3; j < i*3+3; j++)
                        if (j < names.length)
                          Wrap( children: [
                            ChildDisplay(names[j], DisplayType.SkinTemp),
                            if (j != i*3+2)
                              const SizedBox(width: 40),
                          ]),
                      ]),
                      const SizedBox(height: 150)
                    ]),
          ])
        ],
        ),
      ),
                ), 
          /*Container(
            color: Colors.blue[100],
            child: Column(
              children: <Widget> [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('/Users/apple/Desktop/EP4/flutter_application_1/download.jpeg'),
                ),
                Text("Sam Smith"),
                 SizedBox(
                  height: 15,
                ),
                Text("Contact Number: 852 12345678"),
                 SizedBox(
                  height: 15,
                ),
                Text("Address: United College"),
                
              ],)
            )*/
            Container(
          color:Colors.blue[100],
          child: SafeArea(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            //Hi Jared
            Text('Pulse Rate Details',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ]),
          SizedBox(
            height: 20,
          ),
          Column (mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (int i = 0; i < (numStudents/3).ceil(); i++)
                  Wrap(children : [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      for (int j = i*3; j < i*3+3; j++)
                        if (j < names.length)
                          Wrap( children: [
                            ChildDisplay(names[j], DisplayType.Pulse),
                            if (j != i*3+2)
                              const SizedBox(width: 40),
                          ]),
                      ]),
                      const SizedBox(height: 150)
                    ]),
          ])
        ],
        ),
      ),
      )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: const<BottomNavigationBarItem>[ 
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_outline),label: 'Heart Rate'),
        BottomNavigationBarItem(icon: Icon(Icons.health_and_safety),label: 'Skin Temperature'),
        BottomNavigationBarItem(icon: Icon(Icons.medical_information),label: 'Pulses')
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[900],
      unselectedItemColor: Colors.grey[400],
      onTap: onTapped),
    );
  }
}
