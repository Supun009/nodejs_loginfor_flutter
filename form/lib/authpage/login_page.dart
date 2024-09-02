import 'package:flutter/material.dart';
import 'package:form/servises/auth_servises.dart';
import 'package:form/textfild/formtextfild.dart'; // Make sure the path is correct based on your project structure.

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthServises authServises = AuthServises();

  void signIn() {
    authServises.signinuser(
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
            const SizedBox(height: 60),
            const Text(
              'Welcome',
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
                      onTap: signIn,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.00)),
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Text(
                            'Login',
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
