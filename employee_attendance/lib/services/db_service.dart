import 'dart:math';

import 'package:employee_attendance/constants/constants.dart';
import 'package:employee_attendance/models/department_model.dart';
import 'package:employee_attendance/models/user_model.dart';
import 'package:employee_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  UserModel? userModel;
  List<DepartmentModel> allDepartments = [];
  int? employeeDepartment;

  String generateRandomEmployeeId() {
    final random = Random();
    const allChars = "EmpAtt0123456789";
    final randomString =
        List.generate(8, (index) => allChars[random.nextInt(allChars.length)])
            .join();
    return randomString;
  }

  Future insertNewUser(String email, var id) async {
    await _supabase.from(Constants.employeeTable).insert({
      'id': id,
      'name': '',
      'email': email,
      'employee_id': generateRandomEmployeeId(),
      'department': null,
    });
  }

  Future<UserModel> getUserData() async {
    final userData = await _supabase
        .from(Constants.employeeTable)
        .select()
        .eq('id', _supabase.auth.currentUser!.id)
        .single();
    userModel = UserModel.fromJson(userData);
    // Since this function can be called multiple times, then it will reset the department value
    // That is why we are using condition to assign only at the first time
    employeeDepartment == null
        ? employeeDepartment = userModel?.department
        : null;
    return userModel!;
  }

  Future<void> getAllDepartments() async {
    final List result =
        await _supabase.from(Constants.departmentTable).select();
    allDepartments = [
      DepartmentModel(id: 1, title: 'Sales'),
      DepartmentModel(id: 2, title: 'HR'),
      DepartmentModel(id: 3, title: 'IT'),
      DepartmentModel(id: 4, title: 'Marketing'),
      DepartmentModel(id: 5, title: 'Finance'),
      DepartmentModel(id: 6, title: 'Operation'),
    ];
    notifyListeners();
  }

  Future updateProfile(String name, BuildContext context) async {
    await _supabase.from(Constants.employeeTable).update({
      'name': name,
      'department': employeeDepartment,
    }).eq('id', _supabase.auth.currentUser!.id);

    Utils.ShowSnackbar("Profile Updated Successfully", context,
        color: Colors.green);
    notifyListeners();
  }
}
