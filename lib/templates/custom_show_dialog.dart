import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> customShowDialog(context) async {
  showDialog<dynamic>(
    context: context,
    builder: (BuildContext context) => SpinKitCircle(
      color: Colors.red,
    ),
  );
}
