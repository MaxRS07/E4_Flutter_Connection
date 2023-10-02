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



class ChildDisplay extends StatelessWidget {
    String StudentName = "";
    SubType Type = SubType.gsr;
    int ideal_number = 10;
    String data = "data";
    ChildDisplay(String studentName, SubType type, {super.key}) {
      this.StudentName = studentName;
      Type = type;
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
    final e4 = await E4Socket.connect('192.168.7.200', 12345);
    final stream = e4.subscribeToMeasure(Type.getString(), E4Device('A03051'));
    stream.listen((measure) {
      print(utf8.decode(measure.packet.data).split(" "));
      data = utf8.decode(measure.packet.data);
    });
    }
    @override
    Widget build(BuildContext context) {
      listenToStream();
            return Column(
            children: [ 
            Text(
            StudentName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              ),
          ),
          SizedBox(
            height: 15,
          ),
          CircularProgressIndicator(
              value: 5/ideal_number, //change to variables input/ideal
          ),
          SizedBox(
            height: 15,
          ),
          Text(data),
          SizedBox(
            height: 15,
          ),
          ]);
}
}