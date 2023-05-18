// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dtvideo/pages/login.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/utils.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:dtvideo/widget/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final conformpasswordController = TextEditingController();
  ScrollController scollController = ScrollController();
  bool obscureTextPassword = true;
  bool obscureTextConformPass = true;
  var fullname, email, mobile, password, conformpassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: logintopBg,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          controller: scollController,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ragisterUI(),
            ],
          ),
        ),
      ),
    );
  }

  Widget ragisterUI() {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: loginbgLight,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(118.0),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: MyImage(
                      width: 200,
                      height: 200,
                      imagePath: "assets/images/appicon.png"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: LanguageText(
                color: white,
                text: "signup",
                textalign: TextAlign.center,
                fontsize: 16,
                fontwaight: FontWeight.w600,
                fontstyle: FontStyle.normal),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                fullnameTextField(),
                const SizedBox(
                  height: 0,
                ),
                emailTextField(),
                const SizedBox(
                  height: 0,
                ),
                mobileTextField(),
                const SizedBox(
                  height: 0,
                ),
                passwordTextField(),
                const SizedBox(
                  height: 0,
                ),
                conPassTextField(),
                const SizedBox(
                  height: 15,
                ),
                signupBtn(),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: LanguageText(
                      color: white,
                      text: "alreadylogin",
                      textalign: TextAlign.center,
                      fontsize: 14,
                      fontwaight: FontWeight.w500,
                      fontstyle: FontStyle.normal),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fullnameTextField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(5, 6, 5, 6),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: textfieldlogin,
            border: Border.all(
              color: textfieldlogin,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(13))),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 20,
                child: Image.asset("assets/images/username.png",
                    width: 10, height: 10),
              ),
            ),
            Flexible(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: MyTextField(
                    hinttext: "FullName",
                    size: 14,
                    controller: nameController,
                    color: white,
                    textInputAction: TextInputAction.next,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(5, 6, 5, 6),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: textfieldlogin,
            border: Border.all(
              color: textfieldlogin,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(13))),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 20,
                child: Image.asset("assets/images/emaillogin.png",
                    width: 10, height: 10),
              ),
            ),
            Flexible(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: MyTextField(
                  hinttext: "Email",
                  size: 14,
                  color: white,
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mobileTextField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(5, 6, 5, 6),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: textfieldlogin,
            border: Border.all(
              color: textfieldlogin,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(13))),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 20,
                child: Image.asset("assets/images/password.png",
                    width: 10, height: 10),
              ),
            ),
            Flexible(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: MyTextField(
                  hinttext: "Mobile",
                  size: 14,
                  color: white,
                  obscureText: false,
                  controller: mobileController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(5, 6, 5, 6),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: textfieldlogin,
            border: Border.all(
              color: textfieldlogin,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(13))),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 20,
                child: Image.asset("assets/images/password.png",
                    width: 10, height: 10),
              ),
            ),
            Flexible(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: MyTextField(
                  hinttext: "Password",
                  size: 14,
                  color: white,
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: obscureTextPassword,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: IconButton(
                    color: white,
                    onPressed: () {
                      setState(() {
                        obscureTextPassword = !obscureTextPassword;
                      });
                    },
                    icon: Icon(
                      obscureTextPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget conPassTextField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(5, 6, 5, 6),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: textfieldlogin,
            border: Border.all(
              color: textfieldlogin,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(13))),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 20,
                child: Image.asset("assets/images/password.png",
                    width: 10, height: 10),
              ),
            ),
            Flexible(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: MyTextField(
                  hinttext: "Conform Password",
                  size: 14,
                  color: white,
                  controller: conformpasswordController,
                  textInputAction: TextInputAction.done,
                  obscureText: obscureTextConformPass,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: IconButton(
                    color: white,
                    onPressed: () {
                      setState(() {
                        obscureTextConformPass = !obscureTextConformPass;
                      });
                    },
                    icon: Icon(
                      obscureTextConformPass
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget signupBtn() {
    return InkWell(
      onTap: () async {
        fullname = nameController.text;
        email = emailController.text;
        mobile = mobileController.text;
        password = passwordController.text;
        conformpassword = conformpasswordController.text;
        bool emailValidation = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);
        if (fullname.isEmpty) {
          Utils().showToast("please enter Fullname");
          return;
        } else if (email.isEmpty) {
          Utils().showToast("please enter Email");
          return;
        } else if (mobile.isEmpty) {
          Utils().showToast("please enter Mobile");
          return;
        } else if (password.isEmpty) {
          Utils().showToast("please enter password");
          return;
        } else if (conformpassword.isEmpty) {
          Utils().showToast("please ReEnter Plassword");
          return;
        } else if (!emailValidation) {
          Utils().showToast("Invalid Email");
          return;
        } else if (password != conformpassword) {
          Utils().showToast("Invalid confirm password");
          return;
        }

        // Call Register Api in Button Click
        var signupprovider = Provider.of<ApiProvider>(context, listen: false);

        await signupprovider.registration(fullname, email, mobile, password);

        if (signupprovider.loading) {
          if (signupprovider.registrationmodel.status == 200) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          } else {
            Utils.toastMessage(
                signupprovider.registrationmodel.message.toString());
          }
        }
      },
      child: Container(
        width: 110,
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
            text: "signup",
            textalign: TextAlign.center,
            fontsize: 16,
            fontwaight: FontWeight.w500,
            fontstyle: FontStyle.normal),
      ),
    );
  }
}
