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
  late String id = "";

  bool _isEditingText = false;
  String initialText = "Initial Text";
  late TextEditingController _editingController = TextEditingController(text: initialText);

  ExerciseState(String _id){
    studentName = names[_id.toLowerCase()] ?? studentName;
    id = ids[_id.toLowerCase()] ?? _id;
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
                    width: 240,
                    child: Row(children: [
                      const Icon(Icons.favorite),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Row( children: [
                        EditableText(
                          controller: _editingController,
                          focusNode: FocusNode(),
                          cursorColor: Colors.black12,
                          backgroundCursorColor: Colors.black12,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          onEditingComplete: (){},
                          ),
                        ]
                        ),
                          const SizedBox(
                          height: 5,
                          ),
                        Text(id,
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