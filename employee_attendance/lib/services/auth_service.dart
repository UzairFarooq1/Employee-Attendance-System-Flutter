import 'package:employee_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends ChangeNotifier{
  final SupabaseClient _supabase = Supabase.instance.client;

  bool _isLoading = false;

  bool get isLoading  => _isLoading;

  set setIsLoading (bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future registerEmployee(
    String email, String password, BuildContext context) async{
    try{
      setIsLoading = true;
      if(email== "" || password == ""){
        throw Exception("All fields are required");
      }
      final AuthResponse response = 
          await _supabase.auth.signUp(email: email, password: password);
      Utils.ShowSnackbar("Successfull Signup! You can now login", context,
          color: Colors.green);
      Navigator.pop(context);
      setIsLoading  = false;

  } catch (e){
      Utils.ShowSnackbar(e.toString(), context, color: Colors.red);
      setIsLoading  = false;
  }
  }

  Future loginEmployee(String email, String password, BuildContext context) async{
        try{
      setIsLoading = true;
      if(email== "" || password == ""){
        throw Exception("All fields are required");
      }
      final AuthResponse response = 
          await _supabase.auth.signInWithPassword(email: email, password: password);

      setIsLoading  = false;

  } catch (e){
      Utils.ShowSnackbar(e.toString(), context, color: Colors.red);
      setIsLoading  = false;
  }

  }

  Future signOut() async{
    await _supabase.auth.signOut();
    notifyListeners();
  }

  User? get currentUser => _supabase.auth.currentUser; 

}