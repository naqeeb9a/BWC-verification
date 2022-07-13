import 'package:bwcverification/Api/functionality.dart';
import 'package:bwcverification/Provider/user_data_provider.dart';
import 'package:bwcverification/Screens/HomeScreen/verification.dart';
import 'package:bwcverification/Widgets/custom_app_bar.dart';
import 'package:bwcverification/utils/app_routes.dart';
import 'package:bwcverification/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Authentication/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  logout() {
    Provider.of<LoginInfoProvider>(context, listen: false)
        .changeLoginStatus(false);
    KRoutes.pushAndRemoveUntil(context, const Login());
  }

  @override
  Widget build(BuildContext context) {
    Functionality.getId();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: BaseAppBar(
          title: "BWC Verification",
          appBar: AppBar(),
          widgets: [
            IconButton(
                onPressed: () async {
                  SharedPreferences user =
                      await SharedPreferences.getInstance();
                  user.clear();
                  logout();
                },
                icon: const Icon(
                  Icons.logout,
                  color: primaryColor,
                ))
          ],
          appBarHeight: 50,
        ),
        body: const VerificationScreen());
  }
}
