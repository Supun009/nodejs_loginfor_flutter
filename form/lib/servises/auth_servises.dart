import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form/models/user.dart';
import 'package:form/pages/home_page.dart';
import 'package:form/providers/user_prvider.dart';
import 'package:form/utills/constants.dart';
import 'package:form/utills/utills.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServises {
  void signUpUsers(
      {required BuildContext context,
      required String username,
      required String password}) async {
    try {
      User user = User(
        username: username,
        password: password,
        id: '',
        token: '',
      );

      http.Response res = await http.post(
          Uri.parse('${Constants.uri}/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      httpErrohandle(
        // ignore: use_build_context_synchronously
        context: context,
        response: res,
        onSuccess: () {
          showSnacbar(
            context,
            "Account created Login with the same credintials1",
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnacbar(context, e.toString());
    }
  }

  void signinuser(
      {required BuildContext context,
      required String username,
      required String password}) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res =
          await http.post(Uri.parse('${Constants.uri}/api/signin'),
              body: jsonEncode({
                "username": username,
                "password": password,
              }),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      // print(res.body);
      httpErrohandle(
        response: res,
        // ignore: use_build_context_synchronously
        context: context,
        onSuccess: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await pref.setString("x-auth-token", jsonDecode(res.body)['token']);
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Homepage(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnacbar(context, e.toString());
    }
  }

  //get user data
  void getUserData(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString("x-auth-token", '');
      }

      var tokenRes = await http.post(Uri.parse('${Constants.uri}/tokenIsValid'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http
            .get(Uri.parse('${Constants.uri}/'), headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": token,
        });

        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnacbar(context, e.toString());
    } finally {
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false).setLoading(false);
    }
  }
}
