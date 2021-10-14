import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_library/pages/home_page.dart';
import 'package:simple_library/services/auth_services.dart';
import 'package:simple_library/templates/app_size.dart';
import 'package:simple_library/templates/custom_button.dart';
import 'package:simple_library/templates/custom_show_dialog.dart';

class LoginPage extends StatelessWidget {
  String nis;
  final nisController = TextEditingController();

  LoginPage({Key key}) : super(key: key);

  // @override
  // void dispose() {
  //   nisController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSize.globalMargin),
        child: Column(
          children: [
            SizedBox(height: 50),
            Image(image: AssetImage('assets/images/stars.png')),
            SizedBox(height: 40),
            Text(
              'Welcome back',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 35),
            TextField(
              controller: nisController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: 'NIS',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 50),
            CustomButton(
              buttonText: "Masuk",
              onTap: () => showDialogLogin(context),
              // onTap: () => Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomePage()),
              // ),
            )
          ],
        ),
      ),
    );
  }

  showDialogLogin(BuildContext context) async {
    customShowDialog(context);
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      var response = await AuthServices.login(nisController.text);
      print('Response : $response');

      if (response['status_code'] == 200) {
        await sp.setString('isSession', '1');
        await sp.setString('id', response['data']['id'].toString());
        await sp.setString('nama', response['data']['nama'].toString());
        await sp.setString('nis', response['data']['nis'].toString());

        Flushbar(
          title: ("Cie berhasil masuk"),
          message: ("Yaudah yuk gas baca aja"),
          duration: Duration(seconds: 3),
        )..show(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        Duration(seconds: 1);
        Navigator.pop(context);
        Flushbar(
          title: ("Cie gagal masuk"),
          message: ("Yaudah sih jangan sedih, coba lagi aja dulu"),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } catch (e) {
      print(e);
    }
  }
}
