import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dtvideo/pages/bottonnavigation.dart';
import 'package:dtvideo/pages/mobilelogin.dart';
import 'package:dtvideo/pages/signup.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/constant.dart';
import 'package:dtvideo/utils/sharedpre.dart';
import 'package:dtvideo/utils/utils.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:dtvideo/widget/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  SharedPre sharePref = SharedPre();
  final mobileController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  ScrollController scollController = ScrollController();
  bool obscureTextPassword = true;
  var email = "";
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scollController,
        child: Column(
          children: [
            loginUI(),
          ],
        ),
      ),
    );
  }

  Widget loginUI() {
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
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: loginbgLight,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(118.0),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: MyImage(
                        width: 200,
                        height: 200,
                        imagePath: "assets/images/appicon.png"),
                  ),
                  Flexible(
                    flex: 1,
                    child: LanguageText(
                        color: white,
                        text: "welcome",
                        fontsize: 20,
                        fontwaight: FontWeight.w600,
                        textalign: TextAlign.center,
                        fontstyle: FontStyle.normal),
                  )
                ],
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
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: LanguageText(
                          color: white,
                          text: "logincontinue",
                          textalign: TextAlign.center,
                          fontsize: 16,
                          fontwaight: FontWeight.w600,
                          fontstyle: FontStyle.normal),
                    ),
                  ),
                  Flexible(
                    flex: 9,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          nameTextField(),
                          const SizedBox(height: 10),
                          passwordTextField(),
                          const SizedBox(height: 10),
                          forgotpassword(),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                activeColor: white,
                                checkColor: black,
                                side: const BorderSide(color: white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                  side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                        width: 1.0, color: white),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyText(
                                    color: white,
                                    text:
                                        "By continuing,I UnderStand and agree with",
                                    fontsize: 12,
                                    fontwaight: FontWeight.w500,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textalign: TextAlign.center,
                                    fontstyle: FontStyle.normal,
                                  ),
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    textDirection: TextDirection.ltr,
                                    softWrap: true,
                                    maxLines: 1,
                                    textScaleFactor: 1,
                                    text: TextSpan(
                                      text: 'Privacy Police,',
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: fbBg,
                                          fontWeight: FontWeight.w500),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'User Agrement ',
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: fbBg,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: 'and ',
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: white,
                                                fontWeight: FontWeight.w500)),
                                        TextSpan(
                                            text: 'Terms of Use',
                                            style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: fbBg,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  MyText(
                                    color: white,
                                    text: "for '${Constant().appName}'",
                                    fontsize: 12,
                                    fontwaight: FontWeight.w500,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textalign: TextAlign.center,
                                    fontstyle: FontStyle.normal,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          loginBtn(),
                          const SizedBox(height: 10),
                          orText(),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (!isChecked) {
                                    Utils().showToast(
                                        "Read policy & accept to go ahead");
                                    return;
                                  } else {
                                    String password = "";
                                    String deviceToken = "12234";
                                    String type = "2";

                                    signInWithGoogle(email)
                                        .then((UserCredential user) async {
                                      log('${user.user?.displayName.toString()}');
                                      log('${user.user?.email}');
                                      log('${user.user?.photoURL}');
                                      log('${user.user?.uid}');
                                      if (user.user!.email
                                          .toString()
                                          .isNotEmpty) {
                                        var loginprovider =
                                            Provider.of<ApiProvider>(context,
                                                listen: false);

                                        await loginprovider.login(
                                            user.user?.email,
                                            password,
                                            deviceToken,
                                            type);

                                        log("====> loading ${loginprovider.loading}");
                                        if (loginprovider.loading) {
                                          for (var i = 0;
                                              i <
                                                  (loginprovider.loginmodel
                                                          .result?.length ??
                                                      0);
                                              i++) {
                                            log("====> ID ${loginprovider.loginmodel.result![i].id}");
                                            await sharePref.save(
                                                "userid",
                                                loginprovider
                                                    .loginmodel.result![i].id
                                                    .toString());
                                            await sharePref.save(
                                                "roleid",
                                                loginprovider.loginmodel
                                                    .result![i].roleId);
                                            await sharePref.save(
                                                "fullname",
                                                loginprovider.loginmodel
                                                    .result![i].fullname);
                                            await sharePref.save(
                                                "image",
                                                loginprovider.loginmodel
                                                    .result![i].image);
                                            await sharePref.save(
                                                "bgimage",
                                                loginprovider
                                                    .loginmodel
                                                    .result![i]
                                                    .backgroundImage);
                                            await sharePref.save(
                                                "email",
                                                loginprovider.loginmodel
                                                    .result![i].email);
                                            await sharePref.save(
                                                "password",
                                                loginprovider.loginmodel
                                                    .result![i].password);
                                            await sharePref.save(
                                                "authtoken",
                                                loginprovider.loginmodel
                                                    .result![i].authToken);
                                            await sharePref.save(
                                                "mobile",
                                                loginprovider.loginmodel
                                                    .result![i].mobile);
                                            await sharePref.save(
                                                "type",
                                                loginprovider.loginmodel
                                                    .result![i].type);
                                            await sharePref.save(
                                                "status",
                                                loginprovider.loginmodel
                                                    .result![i].status);
                                          }
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const BottomNavigation()),
                                          );
                                        } else {
                                          const CircularProgressIndicator();
                                        }
                                      }
                                    });
                                    debugPrint("Email Google Button:$email");
                                  }
                                },
                                child: MyImage(
                                  width: 45,
                                  height: 45,
                                  imagePath: "assets/images/googlelogin.png",
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MobileLogin()),
                                  );
                                },
                                child: MyImage(
                                  width: 45,
                                  height: 45,
                                  imagePath: "assets/images/phonelogin.png",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (Platform.isIOS)
                            SizedBox(
                              child: SignInWithAppleButton(
                                text: "",
                                style: SignInWithAppleButtonStyle.black,
                                iconAlignment: IconAlignment.center,
                                onPressed: () {
                                  if (!isChecked) {
                                    Utils().showToast(
                                        "You have to accept user policies.");
                                  }
                                  signInWithApple();
                                },
                              ),
                            ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              debugPrint("click");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()),
                              );
                            },
                            child: LanguageText(
                                color: white,
                                text: "signupnavigate",
                                textalign: TextAlign.center,
                                fontsize: 12,
                                fontwaight: FontWeight.w500,
                                fontstyle: FontStyle.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nameTextField() {
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
                  textInputAction: TextInputAction.done,
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

  Widget forgotpassword() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 20,
      alignment: Alignment.centerRight,
      child: LanguageText(
          color: white,
          text: "forgotpassword",
          textalign: TextAlign.center,
          fontsize: 12,
          fontwaight: FontWeight.w400,
          fontstyle: FontStyle.normal),
    );
  }

  Widget loginBtn() {
    return Consumer<ApiProvider>(builder: (context, loginprovider, child) {
      return InkWell(
        onTap: () async {
          String email = emailController.text;
          String password = passwordController.text;
          String deviceToken = "12234";
          String type = "1";

          if (email.isEmpty) {
            Utils().showToast("Please Enter your Email");
            return;
          } else if (password.isEmpty) {
            Utils().showToast("Please Enter your password");
            return;
          } else if (password.length < 6) {
            Utils().showToast("Password is not valid");
            return;
          } else if (!isChecked) {
            Utils().showToast("Read policy & accept to go ahead");
            return;
          }

          await loginprovider.login(email, password, deviceToken, type);

          if (loginprovider.loading) {
            log("===>${loginprovider.loginmodel.result}");
            if (loginprovider.loginmodel.status == 200) {
              for (var i = 0;
                  i < loginprovider.loginmodel.result!.length;
                  i++) {
                sharePref.save("userid",
                    loginprovider.loginmodel.result![i].id.toString());
                sharePref.save(
                    "roleid", loginprovider.loginmodel.result![i].roleId);
                sharePref.save(
                    "fullname", loginprovider.loginmodel.result![i].fullname);
                sharePref.save(
                    "image", loginprovider.loginmodel.result![i].image);
                sharePref.save("bgimage",
                    loginprovider.loginmodel.result![i].backgroundImage);
                sharePref.save(
                    "email", loginprovider.loginmodel.result![i].email);
                sharePref.save(
                    "password", loginprovider.loginmodel.result![i].password);
                sharePref.save(
                    "authtoken", loginprovider.loginmodel.result![i].authToken);
                sharePref.save(
                    "mobile", loginprovider.loginmodel.result![i].mobile);
                sharePref.save(
                    "type", loginprovider.loginmodel.result![i].type);
                sharePref.save(
                    "status", loginprovider.loginmodel.result![i].status);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavigation()),
                );
              }
            } else {
              Utils().showToast(loginprovider.loginmodel.message.toString());
            }
          } else {
            const CircularProgressIndicator();
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
              text: "login",
              textalign: TextAlign.center,
              fontsize: 16,
              fontwaight: FontWeight.w500,
              fontstyle: FontStyle.normal),
        ),
      );
    });
  }

  Widget orText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 25,
      alignment: Alignment.center,
      child: LanguageText(
          color: white,
          text: "or",
          textalign: TextAlign.center,
          fontsize: 14,
          fontwaight: FontWeight.w500,
          fontstyle: FontStyle.normal),
    );
  }

  Future<UserCredential> signInWithGoogle(email) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    email = googleUser!.email;
    String userid = googleUser.id;
    debugPrint("Google Email:===>$email");
    debugPrint("Google id:===>$userid");

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    // final digest = sha256.convert(bytes);
    return bytes.toString();
  }

  Future<User?> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    try {
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      print(appleCredential.authorizationCode);

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      final displayName =
          '${appleCredential.givenName} ${appleCredential.familyName}';

      final userEmail = '${appleCredential.email}';
      print("===>userEmail $userEmail");

      final firebaseUser = authResult.user;
      print("===>");
      print(firebaseUser?.email.toString());
      print(firebaseUser?.displayName.toString());
      print(firebaseUser?.photoURL.toString());
      print(firebaseUser?.uid);

      final photoURL = firebaseUser?.photoURL;
      final firebasedid = firebaseUser?.uid;

      await firebaseUser?.updateProfile(displayName: displayName);
      await firebaseUser?.updateEmail(userEmail);

      login(userEmail, "", "", "2");
    } catch (exception) {
      print(exception);
    }
  }

  login(email, password, deviceToken, type) async {
    var loginprovider = Provider.of<ApiProvider>(context, listen: false);

    await loginprovider.login(email, password, deviceToken, type);

    log("====> loading ${loginprovider.loading}");
    if (loginprovider.loading) {
      for (var i = 0; i < (loginprovider.loginmodel.result?.length ?? 0); i++) {
        log("====> ID ${loginprovider.loginmodel.result![i].id}");
        await sharePref.save(
            "userid", loginprovider.loginmodel.result![i].id.toString());
        await sharePref.save(
            "roleid", loginprovider.loginmodel.result![i].roleId);
        await sharePref.save(
            "fullname", loginprovider.loginmodel.result![i].fullname);
        await sharePref.save(
            "image", loginprovider.loginmodel.result![i].image);
        await sharePref.save(
            "bgimage", loginprovider.loginmodel.result![i].backgroundImage);
        await sharePref.save(
            "email", loginprovider.loginmodel.result![i].email);
        await sharePref.save(
            "password", loginprovider.loginmodel.result![i].password);
        await sharePref.save(
            "authtoken", loginprovider.loginmodel.result![i].authToken);
        await sharePref.save(
            "mobile", loginprovider.loginmodel.result![i].mobile);
        await sharePref.save("type", loginprovider.loginmodel.result![i].type);
        await sharePref.save(
            "status", loginprovider.loginmodel.result![i].status);
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavigation()),
      );
    } else {
      const CircularProgressIndicator();
    }
  }
}
