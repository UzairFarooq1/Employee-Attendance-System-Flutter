import 'package:employee_attendance/models/attendance_model.dart';
import 'package:employee_attendance/services/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';


class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  
  @override
  Widget build(BuildContext context) {
    final attendanceService = Provider.of<AttendanceService>(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 20, top: 60, bottom: 10),
          child: const Text("My Attendance", style: TextStyle(
            fontSize:25
            ), 
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(attendanceService.attendanceHistoryMonth,style: const TextStyle(fontSize: 25),
            ),
            OutlinedButton(onPressed: () async {
              final selectedDate = await SimpleMonthYearPicker.showMonthYearPickerDialog(
                context: context,disableFuture: true);

              String pickedMonth = 
                  DateFormat('MMMM yyyy').format(selectedDate);
              attendanceService.attendanceHistoryMonth = pickedMonth;
            }, 
            child: const Text("Pick a Month"))
          ],
        ),
        Expanded(child: FutureBuilder(
          future: attendanceService.getAttendanceHistory(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length>0) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    AttendanceModel attendanceData = snapshot.data[index];
                    return Container(
                      margin: const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 10),
                    );
                  });
              } else {
                return const Center(
                  child: Text("No data Available", style: TextStyle(
                    fontSize: 25
                  ),),
                );
              }
            }
              return const LinearProgressIndicator(
                backgroundColor: Colors.white,color: Colors.blueGrey,);
          })
        ),
      ],
    );
  }
}