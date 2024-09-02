import 'package:flutter/material.dart';
import 'package:form/authpage/login_registerpage.dart';
import 'package:form/pages/home_page.dart';
import 'package:form/providers/user_prvider.dart';
import 'package:form/servises/auth_servises.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServises authServises = AuthServises();

  @override
  void initState() {
    super.initState();
    authServises.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    Widget content;
    if (userProvider.isLoading) {
      content = const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      content = userProvider.user.token.isEmpty
          ? const LoginRegisterpage()
          : const Homepage();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: content,
    );
  }
}
