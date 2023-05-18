// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:dtvideo/pages/bottonnavigation.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/utils.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../utils/sharedpre.dart';
import '../widget/mytext.dart';

// ignore: must_be_immutable
class Otp extends StatefulWidget {
  String number;
  Otp({Key? key, required this.number}) : super(key: key);

  @override
  State<Otp> createState() => OtpState();
}

class OtpState extends State<Otp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPre sharePref = SharedPre();
  ScrollController scollController = ScrollController();
  final pinPutController = TextEditingController();
  bool isLoading = false;

  String? verificationId;

  @override
  void initState() {
    super.initState();
    codeSend();
  }

  codeSend() async {
    isLoading = true;
    setState(() {});
    await phoneSignIn(phoneNumber: widget.number);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      const CircularProgressIndicator();
    }
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        controller: scollController,
        child: Column(
          children: [
            mobileLogin(),
          ],
        ),
      ),
    );
  }

  Widget mobileLogin() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: logintopBg,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                  color: loginbgLight,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(118.0),
                  )),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 210,
                margin: const EdgeInsets.only(bottom: 20),
                // color: white,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    LanguageText(
                        color: white,
                        text: "otp",
                        fontsize: 18,
                        fontwaight: FontWeight.w600,
                        textalign: TextAlign.center,
                        fontstyle: FontStyle.normal),
                    MyImage(
                        width: 200,
                        height: 170,
                        imagePath: "assets/images/ic_icon.png"),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: logintopBg,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  LanguageText(
                      color: white,
                      text: "verificationcode",
                      fontsize: 16,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w600,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                  const SizedBox(
                    height: 15,
                  ),
                  LanguageText(
                      color: white,
                      text:
                          "sendmobilenumber",
                      fontsize: 12,
                      maxline: 2,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w500,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                  const SizedBox(
                    height: 30,
                  ),
                  MyText(
                      color: white,
                      text: widget.number,
                      fontsize: 16,
                      maxline: 2,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w500,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                  const SizedBox(
                    height: 40,
                  ),
                  Pinput(
                    length: 6,
                    keyboardType: TextInputType.number,
                    controller: pinPutController,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    defaultPinTheme: PinTheme(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          // border: Border.all(color: white, width: 1),
                          shape: BoxShape.rectangle,
                          color: otpBg,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        textStyle: GoogleFonts.inter(
                          color: white,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  submit(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget submit() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () async {
          if (pinPutController.text.isEmpty) {
            Utils().showToast("Otp is blanked");
          } else {
            String otp = pinPutController.text;
            _login(widget.number);
          }
        },
        child: Container(
          width: 120,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: primary,
            border: const GradientBoxBorder(
                width: 1,
                gradient: LinearGradient(
                    colors: [loginBtnBorderOne, loginBtnBorderTwo])),
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: LanguageText(
              color: white,
              text: "submit",
              textalign: TextAlign.center,
              fontsize: 14,
              fontwaight: FontWeight.w500,
              fontstyle: FontStyle.normal),
        ),
      ),
    );
  }

  Future<void> phoneSignIn({required String phoneNumber}) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      this.pinPutController.text = authCredential.smsCode!;
    });
    if (authCredential.smsCode != null) {
      try {
        UserCredential? credential =
            await user?.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
        }
      }
      setState(() {
        isLoading = false;
      });
      log("Firebase Verification Complated");
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Constants.homeNavigate, (route) => false);
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      log("The phone number entered is invalid!");
      showMessage("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    log(forceResendingToken.toString());
    log("code sent");
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  _login(String mobile) async {
    var loginprovider = Provider.of<ApiProvider>(context, listen: false);
    await loginprovider.loginwithotp(mobile);
    if (!loginprovider.loading) {
      const CircularProgressIndicator(value: 30);
    }

    for (var i = 0; i < loginprovider.loginmodel.result!.length; i++) {
      sharePref.save("userid", loginprovider.loginmodel.result![i].id);
      sharePref.save("roleid", loginprovider.loginmodel.result![i].roleId);
      sharePref.save("fullname", loginprovider.loginmodel.result![i].fullname);
      sharePref.save("image", loginprovider.loginmodel.result![i].image);
      sharePref.save(
          "bgimage", loginprovider.loginmodel.result![i].backgroundImage);
      sharePref.save("email", loginprovider.loginmodel.result![i].email);
      sharePref.save("password", loginprovider.loginmodel.result![i].password);
      sharePref.save(
          "authtoken", loginprovider.loginmodel.result![i].authToken);
      sharePref.save("mobile", loginprovider.loginmodel.result![i].mobile);
      sharePref.save("type", loginprovider.loginmodel.result![i].type);
      sharePref.save("status", loginprovider.loginmodel.result![i].status);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavigation()),
    );
  }
}
