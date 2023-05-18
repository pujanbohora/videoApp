import 'dart:developer';
import 'package:country_codes/country_codes.dart';
import 'package:dtvideo/pages/otp.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/utils.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:dtvideo/widget/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({Key? key}) : super(key: key);

  @override
  State<MobileLogin> createState() => MobileLoginState();
}

class MobileLoginState extends State<MobileLogin> {
  final numberController = TextEditingController();
  ScrollController scollController = ScrollController();
  String? mobileNumber;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: loginbgLight,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(118.0),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LanguageText(
                      color: white,
                      text: "logincontinue",
                      fontsize: 18,
                      fontwaight: FontWeight.w600,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                  MyImage(
                      width: 200,
                      height: 160,
                      imagePath: "assets/images/ic_icon.png"),
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
                  const SizedBox(
                    height: 40,
                  ),
                  numberTextField(),
                  const SizedBox(
                    height: 10,
                  ),
                  requestOtpBtn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget numberTextField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      decoration: BoxDecoration(
          color: textfieldlogin,
          border: Border.all(
            color: textfieldlogin,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(13))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IntlPhoneField(
          disableLengthCheck: true,
          textAlignVertical: TextAlignVertical.center,
          autovalidateMode: AutovalidateMode.disabled,
          controller: numberController,
          style: const TextStyle(fontSize: 14, color: white),
          showCountryFlag: true,
          showDropdownIcon: false,
          initialCountryCode: 'IN',
          dropdownTextStyle: GoogleFonts.inter(
              color: white, fontSize: 16, fontWeight: FontWeight.w500),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: false,
            // fillColor: white,
            hintStyle: GoogleFonts.inter(
                color: white, fontSize: 14, fontWeight: FontWeight.w500),
            hintText: "MobileNumber",
          ),
          onChanged: (phone) {
            log('===> ${phone.completeNumber}');
            log('===> ${numberController.text}');
            mobileNumber = phone.completeNumber;
            log('===> $mobileNumber');
          },
          onCountryChanged: (country) {
            log('===> ${country.name}');
            log('===> ${country.code}');
          },
        ),
      ),
    );
  }

  Widget requestOtpBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          if (numberController.text.isEmpty) {
            Utils().showToast("Please Enter Mobile Numbre");
          } else {
            String num = mobileNumber.toString();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Otp(
                  number: num,
                ),
              ),
            );
          }
        },
        child: Container(
          width: 170,
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
              text: "requestotp",
              textalign: TextAlign.center,
              fontsize: 14,
              fontwaight: FontWeight.w500,
              fontstyle: FontStyle.normal),
        ),
      ),
    );
  }
}
