import 'package:flutter/material.dart';
import 'package:form/authpage/login_page.dart';
import 'package:form/authpage/register_page.dart';

class LoginRegisterpage extends StatefulWidget {
  const LoginRegisterpage({super.key});

  @override
  State<LoginRegisterpage> createState() => _LoginRegisterpageState();
}

class _LoginRegisterpageState extends State<LoginRegisterpage> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [LoginPage(), RegisterPage()],
      ),
    );
  }
}
