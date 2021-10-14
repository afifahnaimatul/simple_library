import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AuthServices {
  static Future login(String nis) async {
    var url =
        'https://e-library.yasariniangkasaabd.sch.id/api/mobile/loginMobile?nis=' +
            nis;

    var response = await http.post(url);

    if (response.statusCode == 200) {
      print('Response : $response');
      var jsonResponse = convert.jsonDecode(response.body);
      print('Json Response : $jsonResponse');
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
