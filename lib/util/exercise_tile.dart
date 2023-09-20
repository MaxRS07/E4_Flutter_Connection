import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  String StudentName = "";
  String DeviceID = "";
  int nth = 0;
  
  ExerciseTile(String studentname, String deviceid, int Nth, {super.key}) {
    StudentName = studentname;
    DeviceID = deviceid;
    nth = Nth;
  }
  @override
  Widget build(BuildContext context) {
    int column = nth%3;
    Alignment alignment = Alignment.topLeft;
    switch (column) {
      case 0:
        alignment = Alignment.topLeft;
        break;
      case 1:
        alignment = Alignment.topCenter;
        break;
      case 2:
        alignment = Alignment.topRight;
        break;
    }
    return Container(alignment: alignment,
                    child:
              Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      
                      ),
                    height: 72,
                    width: 250,
                    child: Row(children: [
                      const Icon(Icons.favorite),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                          StudentName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),),
                          const SizedBox(
                          height: 5,
                          ),
                        Text(DeviceID,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 14,
                          )),
                      ],
                      ),
                    ],
                    ),
                  )
    );
  }
}