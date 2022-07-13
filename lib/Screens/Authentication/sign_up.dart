import 'package:bwcverification/Api/functionality.dart';
import 'package:bwcverification/utils/app_routes.dart';
import 'package:bwcverification/utils/utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../Api/api.dart';
import '../../Widgets/widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _business = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _cnic = TextEditingController();
  bool isCheck = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Registeration",
          appBar: AppBar(),
          automaticallyImplyLeading: true,
          widgets: const [],
          appBarHeight: 50),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: CustomText(text: "Business name"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormTextField(
                      controller: _business,
                      suffixIcon: const Icon(Icons.business_outlined),
                      function: (value) {
                        if (value!.isEmpty) {
                          return "Field cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: CustomText(text: "Username"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormTextField(
                        function: (value) {
                          if (value!.isEmpty) {
                            return "Field cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        controller: _username,
                        suffixIcon: const Icon(Icons.person_outline)),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: CustomText(text: "Cnic"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormTextField(
                      keyboardtype: TextInputType.number,
                      controller: _cnic,
                      suffixIcon:
                          const Icon(Icons.domain_verification_outlined),
                      function: (value) {
                        if (value!.isEmpty) {
                          return "Field cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: CustomText(text: "Phone"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormTextField(
                      keyboardtype: TextInputType.phone,
                      controller: _phoneNo,
                      maxLength: 11,
                      suffixIcon: const Icon(Icons.phone_outlined),
                      function: (value) {
                        if (value!.isEmpty) {
                          return "Field cannot be empty";
                        } else if (value.length < 11) {
                          return "Enter a valid number of 11 digits";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: CustomText(text: "Address"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormTextField(
                      keyboardtype: TextInputType.streetAddress,
                      controller: _address,
                      suffixIcon: const Icon(Icons.location_city),
                      function: (value) {
                        if (value!.isEmpty) {
                          return "Field cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: CustomText(text: "City"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormTextField(
                      controller: _city,
                      keyboardtype: TextInputType.streetAddress,
                      suffixIcon: const Icon(Icons.location_city_outlined),
                      function: (value) {
                        if (value!.isEmpty) {
                          return "Field cannot be empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: isCheck,
                            onChanged: (value) {
                              setState(() {
                                isCheck = !isCheck;
                              });
                            }),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree with ",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const TextSpan(
                                text: "terms ",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: "and ",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              const TextSpan(
                                text: "conditions",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          buttonColor: primaryColor,
                          textColor: Colors.white,
                          text: "Sign Up",
                          function: () async {
                            if (!_formKey.currentState!.validate()) {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "Fill all the fields");
                            } else if (isCheck == false) {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text:
                                      "First agree to our terms and conditions");
                            } else {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.loading,
                                  lottieAsset: "assets/loader.json");
                              Response response = await Api.signUp(
                                  bussiness: _business.text,
                                  username: _username.text,
                                  cnic: _cnic.text,
                                  phone: _phoneNo.text,
                                  cell: await Functionality.getDevice(),
                                  macAddress: await Functionality.getId(),
                                  address: _address.text,
                                  city: _city.text,
                                  deviceId: await Functionality.getId());

                              if (response.statusCode == 200) {
                                popPage();
                                CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.success,
                                    text:
                                        "Successfully registered we'll contact you in a while",
                                    onConfirmBtnTap: () {
                                      KRoutes.popUntil(context);
                                    });
                              } else {
                                popPage();
                                CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    text:
                                        "Something went wrong try again later");
                              }
                            }
                          },
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => KRoutes.pop(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Already have an Account? ",
                            color: Colors.black.withOpacity(0.6),
                          ),
                          const CustomText(
                            text: "Sign In",
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  popPage() {
    KRoutes.pop(context);
  }
}
