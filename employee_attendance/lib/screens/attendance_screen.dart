import 'package:flutter/material.dart';


class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child:  Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top : 32),
              child: const Text("Welcome", style: TextStyle(
                color: Colors.black54,
                fontSize: 30
              ),
              ),

            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const  Text("Employee Name",style: TextStyle(
                fontSize: 25
              ),),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: const  Text(
                "Today's Status"
              ,style: TextStyle(
                fontSize: 20
              ),),
            ),
            Container(
              margin: const EdgeInsets.only(32),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2)
                    )
                ]
              ),
            ).
          ]),
      )

    );
  }
}