import 'package:bwcverification/Api/api.dart';
import 'package:bwcverification/Provider/user_data_provider.dart';
import 'package:bwcverification/Screens/QRScreen/qr_screen.dart';
import 'package:bwcverification/Widgets/custom_loader.dart';
import 'package:bwcverification/Widgets/widget.dart';
import 'package:bwcverification/utils/app_routes.dart';
import 'package:bwcverification/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final String? code, id;
  final bool isScan;

  const DetailScreen(
      {Key? key, required this.code, required this.id, required this.isScan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserDataProvider>(context).userData;
    var selectedSociety =
        Provider.of<SelectedSoceityProvider>(context).selectedSoceity;

    return Scaffold(
      appBar: BaseAppBar(
          title: "Verification Screen",
          appBar: AppBar(),
          automaticallyImplyLeading: true,
          widgets: const [],
          appBarHeight: 50),
      body: Center(
        child: FutureBuilder(
          future: Api.getSocietyInformation(
              code, id, userData["data"]["oauth"]["access_token"]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data[0] == "verified") {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Project name:",
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                              text: selectedSociety.toString().substring(
                                  0, selectedSociety.toString().indexOf('@')))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Registration number:",
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                              text: snapshot.data[1]["data"]["file"]["reg_no"])
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Plot type:",
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                              text: snapshot.data[1]["data"]["file"]
                                  ["plot_type"])
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Plot size:",
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                              text: snapshot.data[1]["data"]["file"]
                                  ["plot_size"])
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Security code :",
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                              text: snapshot.data[1]["data"]["file"]
                                  ["security_code"])
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LottieBuilder.asset(
                        "assets/verified.json",
                        repeat: false,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomText(
                        text: "Verified",
                        fontsize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                          buttonColor: primaryColor,
                          text: "Next",
                          textColor: kWhite,
                          function: () {
                            KRoutes.pop(context);
                            isScan
                                ? KRoutes.push(context, const QRScreen())
                                : null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          buttonColor: primaryColor,
                          text: "Go back Home",
                          textColor: kWhite,
                          function: () {
                            KRoutes.pop(context);
                            isScan ? null : KRoutes.pop(context);
                          }),
                    ],
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      "assets/notVerified.json",
                      repeat: false,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomText(
                      text: "Not Verified",
                      fontsize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                        buttonColor: primaryColor,
                        text: "Try Again",
                        textColor: kWhite,
                        function: () {
                          KRoutes.pop(context);
                        })
                  ],
                );
              }
            } else {
              return const CustomLoader();
            }
          },
        ),
      ),
    );
  }
}
