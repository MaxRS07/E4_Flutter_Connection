import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/emoticon_face.dart';
import 'package:flutter_application_1/util/exercise_tile.dart';


enum DisplayType {
  HeartRate,
  SkinTemp,
  Pulse,
}
class ChildDisplay extends StatelessWidget {
    String StudentName = "";
    DisplayType Type = DisplayType.HeartRate;
    int ideal_number = 10;
    ChildDisplay(String studentName, DisplayType type, {super.key}) {
      this.StudentName = studentName;
      Type = type;
    }
    String getType() {
      switch (Type) {
        case DisplayType.HeartRate:
          return "Heart Rate";
        case DisplayType.Pulse:
          return "Pulse Rate";
        case DisplayType.SkinTemp:
          return "Skin Temperature";
      }
    }
    @override
    Widget build(BuildContext context) {
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
          Text(getType()),
          SizedBox(
            height: 15,
          ),
          ]);
}
}