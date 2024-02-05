import 'package:employee_attendance/constants/constants.dart';
import 'package:employee_attendance/models/attendance_model.dart';
import 'package:employee_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  AttendanceModel? attendanceModel;

  String todayDate = DateFormat("dd MMMM yyyy").format(DateTime.now());

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future getTodayAttendance () async {
    final List result = await _supabase
    .from(Constants.attendanceTable)
    .select()
    .eq('employee_id', _supabase.auth.currentUser!.id)
    .eq('date', todayDate);
    if (result.isNotEmpty){
      attendanceModel = AttendanceModel.fromJson(result.first);

    }
    notifyListeners();
  }

Future markAttendance(BuildContext context) async {
  DateTime now = DateTime.now();
  DateTime checkInTimeLimit = DateTime(now.year, now.month, now.day, 9, 0);
  DateTime checkOutLimit = DateTime(now.year, now.month, now.day, 16, 30);




  if (attendanceModel?.checkIn == null) {
    if (now.isAfter(checkInTimeLimit)) {
    Utils.ShowSnackbar("It is past check-in time, better try tomorrow", context);
    return;
    }
    else{
    await _supabase.from(Constants.attendanceTable).insert({
      "employee_id": _supabase.auth.currentUser!.id,
      "date": todayDate,
      "check_in": DateFormat('HH:mm').format(DateTime.now()),
    });
    }
  }
  else if (attendanceModel?.checkOut == null) {
    if (now.isBefore(checkOutLimit)){
    Utils.ShowSnackbar("It is too early to check out, Try after 04:30 PM", context);
    return;
    }
    else{
    await _supabase
        .from(Constants.attendanceTable)
        .update({'check_out': DateFormat('HH:mm').format(DateTime.now())})
        .eq('employee_id', _supabase.auth.currentUser!.id)
        .eq('date', todayDate);
  }
  } else {
    Utils.ShowSnackbar("You have already checked out today!", context);
  }
  getTodayAttendance();
}


}