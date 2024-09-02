import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

void showSnacbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}

void httpErrohandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
    case 400:
      showSnacbar(context, jsonDecode(response.body)["msg"]);
    case 500:
      showSnacbar(context, jsonDecode(response.body)["message"]);
      break;
    default:
      showSnacbar(context, response.body);
  }
}
