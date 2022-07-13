import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static String baseUrl = "http://server.blueworldcity.com/api/";
  static login(
      {required String cnic,
      required String password,
      required String? deviceId}) async {
    var response = await http.post(
        Uri.parse(
          "${baseUrl}scan/login",
        ),
        body: {
          "cnic": cnic,
          "password": password,
          "device_id": deviceId,
        });

    return response;
  }

  static signUp(
      {required String bussiness,
      required String username,
      required String cnic,
      required String phone,
      required String? cell,
      required String? macAddress,
      required String address,
      required String city,
      required String? deviceId}) async {
    // print(bussiness);
    // print(username);
    // print(cnic);
    // print(phone);
    // print(cell);
    // print(macAddress);
    // print(address);
    // print(city);
    // print(deviceId);

    var response = await http
        .post(Uri.parse("${baseUrl}scan/verification-contact"), headers: {
      "token": "uM@JG6s,x<zaN?*T"
    }, body: {
      "bussiness_name": bussiness,
      "username": username,
      "cnic": cnic,
      "phone": phone,
      "cell": cell,
      "mac_address": macAddress,
      "address": address,
      "city": city,
      "uuid": deviceId,
    });
    return response;
  }

  static getSocieties(token) async {
    var response = await http.get(Uri.parse("${baseUrl}scan/get-societies"),
        headers: {
          "last_login_token": token,
          "Content-Type": "application/json"
        });
    return response;
  }

  static getSocietyInformation(code, id, token) async {
    var response = await http.get(
        Uri.parse("${baseUrl}scan/scancode?$code&society_id=$id"),
        headers: {
          "last_login_token": token,
        });

    if (response.statusCode == 200) {
      return ["verified", jsonDecode(response.body)];
    } else {
      return "notVerified";
    }
  }
}
