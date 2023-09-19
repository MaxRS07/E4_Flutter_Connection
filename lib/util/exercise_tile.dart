import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  String StudentName = "";
  String DeviceID = "";
  
  ExerciseTile(String studentname, String deviceid, {super.key}) {
    StudentName = studentname;
    DeviceID = deviceid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      ),
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
                    
                  );
  }
}