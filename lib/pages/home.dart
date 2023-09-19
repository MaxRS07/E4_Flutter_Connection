import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/emoticon_face.dart';
import 'package:flutter_application_1/util/exercise_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex =0;
  int ideal_number = 10;
  int ideal_number_2 = 15;
  
  var names = <String> ["Patrick", "Fred", "David", "Max"];
  int numStudents = 0;
  PageController pageController = PageController();

  void onTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index, duration: Duration(milliseconds: 10),curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    numStudents = names.length;
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
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(25),
              color: Colors.grey[400],
              child: Center(
                child: Column(
                  children:[
                  Row(
                    children: [
                      Text('Students',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ],
                  ),
                  SizedBox(
                  height: 15,
                  ),
                  //student list
                  for (int i = 0; i < numStudents; i++)
                  Column( children: [
                    ExerciseTile(names[i], i.toString()),
                    SizedBox(
                    height: 15,
                    )
                  ]
                  )
                ]),
              ),
            ),
          ),
        ],
        ),
      ),
                ),
          Container(
          color:Colors.blue[100],
          child: SafeArea(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            //Hi Jared
            Text('Heart Rate Details',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ]),
          SizedBox(
            height: 20,
          ),
          for (int i = 0; i < numStudents; i++)
            ChildDisplay(names[i], DisplayType.HeartRate)
        ],
        ),
      ),
                ),
      Container(
          color:Colors.blue[100],
          child: SafeArea(
        child: Column(children: [
          Row(
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
          SizedBox(
            height: 20,
          ),
          for (int i = 0; i < numStudents; i++)
            ChildDisplay(names[i], DisplayType.SkinTemp)
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
          Row(
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
          SizedBox(
            height: 20,
          ),
          for (int i = 0; i < numStudents; i++)
            ChildDisplay(names[i], DisplayType.Pulse)
        ],
        ),
      ),
      )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: const<BottomNavigationBarItem>[ 
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_outline),label: 'Heart Rate'),
        BottomNavigationBarItem(icon: Icon(Icons.health_and_safety),label: 'Skin Temperature'),
        BottomNavigationBarItem(icon: Icon(Icons.medical_information),label: 'Pulses')
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[900],
      unselectedItemColor: Colors.grey[400],
      onTap: onTapped),
    );
  }
}
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