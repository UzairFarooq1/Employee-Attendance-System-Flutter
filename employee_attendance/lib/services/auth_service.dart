import 'dart:async';
import 'package:employee_attendance/services/db_service.dart';
import 'package:employee_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  final DbService _dbService = DbService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

 late StreamController<User?> _authStateController;

  AuthService() {
    _authStateController = StreamController<User?>();
    _supabase.auth.onAuthStateChange.listen((authState) {
      // Access the user information through the session property
      final user = authState.session?.user;
      _authStateController.add(user);
    });
  }

  Stream<User?> authStateChanges() {
    return _authStateController.stream;
  }

  Future<void> registerEmployee(
      String email, String password, BuildContext context) async {
    try {
      setIsLoading = true;
      if (email == "" || password == "") {
        throw Exception("All Fields are required");
      }
      final AuthResponse response =
          await _supabase.auth.signUp(email: email, password: password);
      if (response != null) {
        await _dbService.insertNewUser(email, response.user!.id);

        Utils.ShowSnackbar("Successfully registered !", context,
            color: Colors.green);
        await loginEmployee(email, password, context);
        Navigator.pop(context);
      }
    } catch (e) {
      setIsLoading = false;
      Utils.ShowSnackbar(e.toString(), context, color: Colors.red);
    }
  }

  Future<void> loginEmployee(
      String email, String password, BuildContext context) async {
    try {
      setIsLoading = true;
      if (email == "" || password == "") {
        throw Exception("All fields are required");
      }
      final AuthResponse response = await _supabase.auth
          .signInWithPassword(email: email, password: password);

      setIsLoading = false;
    } catch (e) {
      setIsLoading = false;
      Utils.ShowSnackbar(e.toString(), context, color: Colors.red);
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    notifyListeners();
  }

  User? get currentUser => _supabase.auth.currentUser;

  void dispose() {
    _authStateController.close();
    super.dispose();
  }
}
