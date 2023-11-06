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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<E4Socket> socket;
  @override
  void initState() {
    super.initState();
    updateData();
  }
  void updateData() { 
    socket = E4Socket.connect(serverAdress, port);
    socket.then((a) 
    {
        a.getDevices().listen((value) {
        setState(() => device_IDs = utf8.decode(value.packet.data).getDeviceList()); 
        a.close();
        });
      }
    );
  }
  int _selectedIndex = 0;
  int ideal_number = 10;
  int ideal_number_2 = 15;

  String serverAdress = '192.168.7.200';
  int port = 12345;
  String temp = '';
  String temp2 = '';

  List<String> device_IDs = ["71e1cc"];

  PageController pageController = PageController();

  String setValues() {
    if (temp == "" && temp2 == "") {
      return "";
    }
    if (temp2.checkWith('^[1-9][0-9]{4}\$') && temp.checkWith('^([0-9]{1,3}[.]){3}([0-9]{1,3})\$')) {
      port = int.parse(temp2);
      serverAdress = temp;
      return "$serverAdress:$port";
    } else if (!temp2.checkWith('^[1-9][0-9]{4}\$')) {
      return "Invalid Port";
    } else {
      return "Invalid Address";
    }
  }
  List<Widget> listChildDisplays(SubType type) {
    List<Widget> lidget = List.empty(growable: true);
    for (String a in device_IDs) {
      lidget.add(ChildDisplay(a, type, serverAdress, port));
    }
    print(lidget);
    return lidget;
  }
  List<Widget> listExerciseTiles() {
    List<Widget> lidget = List.empty(growable: true);
    for (String a in device_IDs) {
      lidget.add(ExerciseTile(a));
    }
    print(lidget);
    return lidget;
  }
  void onTapped(int index){
    setState(() => _selectedIndex = index);
    pageController.animateToPage(index, duration: const Duration(milliseconds: 10),curve: Curves.bounceInOut);
  }
  @override
  Widget build(BuildContext context) {
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
                  Expanded(child:
                    GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: listExerciseTiles()
                  ),
                    )
                ]),
              ),
            ),
          ),
          Container(
            color: Colors.grey[400],
                    alignment: Alignment.bottomRight,
                    child:
                    Padding(
                      padding: EdgeInsets.all(10), 
                      child:
                      FloatingActionButton(
                    onPressed: (){updateData();},
                    tooltip: 'Refresh',
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: const Icon(Icons.refresh)),
                  ),
          )
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
          Expanded(child:
          GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: listChildDisplays(SubType.ibi)
        ),
          )
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
          Expanded(child:
          GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: listChildDisplays(SubType.tmp)
        ),
          )
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
          Expanded(child:
          GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: listChildDisplays(SubType.bvp)
        ),
          )
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
        onChanged: (value) {temp = value;},
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Server Adress',
          hintText: serverAdress == "" ? "IPV4" : serverAdress,
          
        ),
        ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 200,
            child:
          TextField(
        onChanged: (value) {temp2 = value;},
        obscureText: false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Server Port',
          hintText: port.toString(),
          
        ),
        ),
          ),
          const SizedBox(height: 15),
        ElevatedButton(
    style: TextButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.blue,
  ),
  onPressed: (){setValues(); setState(() {
    
  });},
  child: const Text('Apply Changes'),
),
Text(setValues())
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
