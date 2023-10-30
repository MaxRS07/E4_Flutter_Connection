import 'dart:async';
import 'dart:ffi';
import 'package:flutter_application_1/util/BleSocket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/emoticon_face.dart';
import 'package:flutter_application_1/util/exercise_tile.dart';
import 'package:flutter_application_1/util/DisplayUI.dart';
import 'package:empatica_e4link/empatica.dart';
import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'dart:typed_data';
import 'package:async/async.dart';
import 'package:quiver/async.dart';

// ignore_for_file: avoid_print
// create a device manager that will handle method calls

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
extension RegMatch on String {
  bool checkWith(String regex) {
    var reg = RegExp(regex);
    return reg.hasMatch(this);
  }
}
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex =0;
  int ideal_number = 10;
  int ideal_number_2 = 15;
  
  String serverAdress = '';
  String port = '';
  String temp = '';
  String temp2 = '';

  String data = "";
  
  var names = <String> ["Student1"];
  int numStudents = 1;
  PageController pageController = PageController();


  void onTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index, duration: const Duration(milliseconds: 10),curve: Curves.bounceInOut);
  }
  @override
  Widget build(BuildContext context) {
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
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            //Hi Jared
            Text("Heart Rate Details",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ]),
          const SizedBox(
            height: 20,
          ),
                    Column (mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (int i = 0; i < (numStudents/3).ceil(); i++)
                  Wrap(children : [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      for (int j = i*3; j < i*3+3; j++)
                        if (j < names.length)
                          Wrap( children: [
                            ChildDisplay("Student", SubType.bvp),
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
          const Row(
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
          const SizedBox(
            height: 20,
          ),
                    Column (mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (int i = 0; i < (numStudents/3).ceil(); i++)
                  Wrap(children : [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      for (int j = i*3; j < i*3+3; j++)
                        if (j < names.length)
                          Wrap( children: [
                            ChildDisplay("Student", SubType.tmp),
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
          const Row(
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
          const SizedBox(
            height: 20,
          ),
          Column (mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (int i = 0; i < (numStudents/3).ceil(); i++)
                  Wrap(children : [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      for (int j = i*3; j < i*3+3; j++)
                        if (j < names.length)
                          Wrap( children: [
                            ChildDisplay("Student", SubType.ibi),
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
      Container(
          color:Colors.blue[100],
          child: SafeArea(
        child: Column(children: [
          const Padding(padding: EdgeInsets.all(15), child:
          Text('Settings',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
          SizedBox(
            width: 200,
            child:
          TextField(
        obscureText: false,
        onChanged: (value) {value.checkWith('^(?:[0-9]{1,3}\.){3}[0-9]{1,3}\$') ? temp = value : null;},
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Server Adress',
          hintText: serverAdress,
          
        ),
        ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 200,
            child:
          TextField(
        onChanged: (value) {value.checkWith('^(?:[0-9]{1,3}\.){3}[0-9]{1,3}\$') ? temp2 = value : null;},
        obscureText: false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Server Port',
          hintText: port,
          
        ),
        ),
          ),
          const SizedBox(height: 15),
        ElevatedButton(
    style: TextButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.blue
  ),
  onPressed: () { serverAdress = temp; port = temp2;},
  child: const Text('Apply Changes'),
)
        ])
          )
      )
          ]),
      bottomNavigationBar: BottomNavigationBar(items: const<BottomNavigationBarItem>[ 
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_outline),label: 'Heart Rate'),
        BottomNavigationBarItem(icon: Icon(Icons.health_and_safety),label: 'Skin Temperature'),
        BottomNavigationBarItem(icon: Icon(Icons.medical_information),label: 'Pulses'),
        BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings')
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[900],
      unselectedItemColor: Colors.grey[400],
      onTap: onTapped),
    );
  }
}
