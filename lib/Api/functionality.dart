import 'dart:convert';
import 'dart:io';

import 'package:bwcverification/Screens/DetailScreen/detail_screen.dart';
import 'package:bwcverification/Screens/LockScreen/lock_screen.dart';
import 'package:bwcverification/utils/app_routes.dart';
import 'package:bwcverification/utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/user_data_provider.dart';
import '../Widgets/widget.dart';

class Functionality {
  static Future<String?> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
    return null;
  }

  static Future<String?> getDevice() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.model; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;

      return androidDeviceInfo.model; // unique ID on Android
    }
    return null;
  }

  static checkLoginStatus(
    context,
  ) async {
    SharedPreferences user = await SharedPreferences.getInstance();
    String? getUser = user.getString("loggedInUser");
    if (getUser != null) {
      var res = jsonDecode(getUser);
      Provider.of<UserDataProvider>(context, listen: false).updateUserData(res);
      KRoutes.pushAndRemoveUntil(context, const LockScreen());
    } else {
      Provider.of<LoginInfoProvider>(context, listen: false)
          .changeLoginStatus(false);
    }
  }

  static openDialogue(BuildContext context, TextEditingController? controller) {
    String? societyId =
        Provider.of<SelectedSoceityProvider>(context, listen: false).id;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LottieBuilder.asset(
                  "assets/write.json",
                  width: 200,
                  repeat: false,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(text: "Enter Registration Number")),
                ),
                const SizedBox(
                  height: 10,
                ),
                FormTextField(
                  controller: controller,
                  suffixIcon: const Icon(Icons.edit),
                  function: (value) {
                    if (value!.isEmpty) {
                      return "Field can't be Empty";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: "Get results",
                  textColor: kWhite,
                  function: () async {
                    if (controller!.text.isEmpty) {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          text: "Field can't be empty",
                          backgroundColor: kblack,
                          lottieAsset: "assets/error.json");
                    } else {
                      KRoutes.push(
                          context,
                          DetailScreen(
                            code: "reg_no=${controller.text}",
                            id: societyId,
                            isScan: false,
                          ));
                      controller.clear();
                    }
                  },
                  buttonColor: primaryColor,
                )
              ],
            ),
          );
        });
  }
}
