import 'dart:html';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'dart:typed_data';

import 'package:flutter/material.dart';

enum SubType {
  acc,
  bvp,
  gsr,
  ibi,
  tmp,
  bat,
  tag;

}
extension Stringing on SubType {
  String asString() {
    return this.toString().substring(8, 11);
  }
}

class E4Socket {
  String host = '';
  int port = 0;
  late Socket client;

  E4Socket(String host, int port) {
    this.host = host;
    this.port = port;
    startClient();
  }
  
  
  Future<void> startClient() async {
    client = await Socket.connect(host, port);
    print('connected to $host:$port');

    client.add(utf8.encode("device_list"));
    
    client.listen((List<int> event) {
      print(utf8.decode(event));
    });

    //client.add(utf8.encode("device_connect"));

    client.listen((List<int> event) {
    print(utf8.decode(event));
  });
  }
  String subToStream(SubType type) {
    return type.asString();
  }

}

void Main() {
  print(SubType.acc.toString());
}

