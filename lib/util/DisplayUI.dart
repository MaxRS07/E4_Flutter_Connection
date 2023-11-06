import 'dart:async';
import 'dart:ffi';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/util/BleSocket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/emoticon_face.dart';
import 'package:flutter_application_1/util/exercise_tile.dart';
import 'package:flutter_application_1/util/DisplayUI.dart';
import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'dart:typed_data';
import 'package:async/async.dart';
import 'package:quiver/async.dart';
import 'Names.dart';



class ChildDisplay extends StatefulWidget {
    late SubType type;
    late String id;
    late String host;
    late int port;
    late HomeScreen homePage;
    ChildDisplay(String _id, SubType _type, String _host, int _port, {super.key}) {
      id = _id;
      type = _type;
      port = _port;
      host = _host;
    }
    @override
    // ignore: no_logic_in_create_state
    State<ChildDisplay> createState() => DisplayState(id, type, host, port);
    }
    
class DisplayState extends State<ChildDisplay> {
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
    late String id;
    late SubType Type;
    int ideal_number = 10;
    late Future<E4Socket> socket;
    late String address;
    late int port;
    String unit = "";

    String name = "Unnamed";
    DisplayState(String _id, SubType type, String Address, int Port) {
      id = _id;
      Type = type;
      address = Address;
      port = Port;
      name = names[id.toLowerCase()] ?? name;
      switch (type) {
        case SubType.tmp:
          unit = "°C";
          break;
      }
    }

    String data = "Waiting...";
    @override
    void initState() {
      super.initState();
      socket = E4Socket.connect(address, port);
      socket.then(
        (a) {a.subscribeToMeasure(Type.getString(), E4Device(id)).listen(updateData); },
      );
    }

    void updateData(measure) {
        var a = utf8.decode(measure.packet.data);
        if (double.tryParse(a.split(' ').last) != null) {
        setState(() => data = utf8.decode(measure.packet.data).split(' ').last + unit);
        }
      }
    @override
    void dispose() {
      // close socket i guess
      socket.then((value) => value.close());
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child:
        Container(
          padding: EdgeInsets.only(left: 10, right: 75, top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),       
          ),
          child:
        Column(children: [ Text(name),
        const SizedBox(height: 15),
        const Icon(Icons.health_and_safety_rounded),
        Text(data),
        const SizedBox(height: 15),
        ]),
        )
        )
      ],
    );
    }
}