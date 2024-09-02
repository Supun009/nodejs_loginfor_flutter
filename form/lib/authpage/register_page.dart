import 'package:flutter/material.dart';
import 'package:form/servises/auth_servises.dart';
import 'package:form/textfild/formtextfild.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthServises authServises = AuthServises();

  void signUpuser() {
    authServises.signUpUsers(
        context: context,
        username: usernameController.text,
        password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
                height:
                    60), // Or adjust this for appropriate spacing from the top or AppBar
            const Text(
              'Register',
              style: TextStyle(
                fontSize: 50.00,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormTextfild(
                      obscureText: false,
                      hintText: "Username",
                      controller: usernameController,
                    ),
                    const SizedBox(height: 25.00),
                    FormTextfild(
                      hintText: "Password",
                      controller: passwordController,
                      obscureText: true, // Ensure password is obscured.
                    ),
                    const SizedBox(
                      height: 25.00,
                    ),
                    GestureDetector(
                      onTap: signUpuser,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.00)),
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
