import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/BleSocket.dart';
import 'Names.dart';

class ExerciseTile extends StatefulWidget {
    
    late String id;

    ExerciseTile(String _id) {
      id = _id;
    }
    @override
    // ignore: no_logic_in_create_state
    State<ExerciseTile> createState() => ExerciseState(id);
    }
  
  class ExerciseState extends State<ExerciseTile> {
  late String studentName = "Unnamed";
  ExerciseState(String _id){
    studentName = names[_id.toLowerCase()] ?? studentName;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [ Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      
                      ),
                    height: 72,
                    width: 225,
                    child: Row(children: [
                      const Icon(Icons.favorite),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                          studentName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),),
                          const SizedBox(
                          height: 5,
                          ),
                        Text(widget.id,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 14,
                          )),
                    ],
                    ),
                    ]
                  ),
    )
    ]
    );
  }
}