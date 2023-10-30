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



class ChildDisplay extends StatefulWidget {
    
    late SubType type;
    late String name;
    ChildDisplay(String _name, SubType _type, {super.key}) {
      name = _name;
      type = _type;
    }
    @override
    // ignore: no_logic_in_create_state
    State<ChildDisplay> createState() => DisplayState(name, type, E4Socket.connect('192.168.7.200', 12345));
    }
class DisplayState extends State<ChildDisplay> {
    String StudentName = "";
    late SubType Type;
    int ideal_number = 10;
    late Future<E4Socket> socket;
    String data = "data";
    DisplayState(String studentName, SubType type, Future<E4Socket> _socket) {
      this.StudentName = studentName;
      Type = type;
      socket = _socket;
    }
    String getType() {
      switch (Type) {
        case SubType.ibi:
          return "Heart Rate";
        case SubType.bvp:
          return "Pulse Rate";
        case SubType.tmp:
          return "Skin Temperature";
        default:
          return "other";
      }
    }
    Future<void> listenToStream() async {
    var _socket = await socket;
    final stream = _socket.subscribeToMeasure(Type.getString(), E4Device('A03051'));
    stream.listen((measure) {
      print(utf8.decode(measure.packet.data));
      setState(() => data = utf8.decode(measure.packet.data));
    });
    }
    @override
    Widget build(BuildContext context) {
      listenToStream();
      if (double.tryParse(data.split(" ").last) == null) {
        data = "waiting...";
      } else {
        data = data;
      }
            return Column(
            children: [ 
            Text(
            StudentName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              ),
          ),
          const SizedBox(
            height: 15,
          ),
          const CircularProgressIndicator(
              value: 5/10, //change to variables input/ideal
          ),
          const SizedBox(
            height: 15,
          ),
          Text("${data.split(", ").last}°C"),
          const SizedBox(
            height: 15,
          ),
          ]);
    }
}