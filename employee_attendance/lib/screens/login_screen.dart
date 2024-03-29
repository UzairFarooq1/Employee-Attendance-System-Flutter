import 'package:employee_attendance/screens/register_screen.dart';
import 'package:employee_attendance/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    double  screenWidth = MediaQuery.of(context).size.width;
    double screenHeight =  MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Container(
          height: screenHeight /3,
          width: screenWidth,
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(70),
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.content_paste_sharp, color: Colors.white, size: 70, ),
              SizedBox(height: 10,),
              Text("EmpAtt", style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily:  "cursive"
              ),)
            ],
          ),
        ),
        
        const SizedBox(height: 50,),
        Padding(padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(
              label: Text ("Enter Employee Email"),
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(borderSide: BorderSide()),
            ),
            controller: _emailController,
          ),
          const SizedBox(
            height: 20,
          ),
          
            TextField(
            decoration: const InputDecoration(
              label: Text ("Enter Employee Password"),
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(borderSide: BorderSide()),
            ),
            controller: _passwordController,
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),


          Consumer<AuthService>(
            builder : (context, authServiceProvider, child){
              return 
              SizedBox(
              height: 60,
              width: double.infinity,
              child: authServiceProvider.isLoading 
              ? const Center(
                child : CircularProgressIndicator(),
              )
              
              : ElevatedButton(onPressed: () {
                authServiceProvider.loginEmployee(
                _emailController.text.trim(),
                _passwordController.text.trim(),
                context);
              }, 

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                )
              ) ,
              child: Text("Login", style: TextStyle(
              fontSize: 18,
              color: Colors.white
              ),),
            ),
            
            );
            },
          ),

          const SizedBox(
            height: 20,
          ),

          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterScreen()));
          }, child: const Text("Are you a new Employee? Register here"))

        ]),
        )




      ],)
    );
  }
}