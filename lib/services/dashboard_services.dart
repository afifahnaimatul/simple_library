import 'dart:convert' as convert;
import 'dart:developer';
import 'package:http/http.dart' as http;

class DashboardServices {
  static Future getDashboard() async {
    var url =
        'https://e-library.yasariniangkasaabd.sch.id/api/mobile/getDashboard';

    var response = await http.get(url);
    print('Response Category : $response');

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print('Json Response Category : $jsonResponse');
      print('Json Response Category Data : ');
      log(jsonResponse['data'].toString());
      return jsonResponse['data'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future getListBooks(var mode, {var id = '', var nama = ''}) async {
    print('Mode : $mode');
    print('Id : $id');
    print('Nama : $nama');

    var url =
        'https://e-library.yasariniangkasaabd.sch.id/api/mobile/getListBuku?nama=' +
            nama +
            '&mode=' +
            mode +
            '&id=' +
            id;
    // var url =
    //     'https://e-library.yasariniangkasaabd.sch.id/api/mobile/getListBuku?nama=' +
    //         'new' +
    //         '&mode=' +
    //         mode +
    //         '&id=' +
    //         id;
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['data'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
