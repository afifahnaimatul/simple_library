import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void nextPage(context, page) async {
  Navigator.push(context, routeTo(page));
}

// void nextScreenAuth(context, page) async {
//   Navigator.push(context, routeTo(AuthMenu(page: page)));
// }

Future nextScreenRet(context, page) async {
  return Navigator.push(context, routeTo(page));
}

void nextReplacementScreen(context, page) async {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
}

Future nextReplacementScreenRet(context, page) async {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => page));
}

void previousScreen(context, page) async {
  Navigator.pop(context, MaterialPageRoute(builder: (_) => page));
}

void backScreen(context) async {
  Navigator.of(context).pop();
}

void backtwoscreen(context) {
  int count = 0;
  Navigator.of(context).popUntil((_) => count++ >= 2);
}

void backthreescreen(context) {
  int count = 0;
  Navigator.of(context).popUntil((_) => count++ >= 3);
}

void popUntil(context, page) async {
  Navigator.of(context).popUntil((_) => page);
}

void resetAndOpenPage(context) {
  Navigator.of(context)
      .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
}

void redirectnoconnection(context) {
  Navigator.of(context).pushNamedAndRemoveUntil(
      '/noconnection', (Route<dynamic> route) => false);
}

Route routeTo(data) {
  return MaterialPageRoute(builder: (context) => data);
}
