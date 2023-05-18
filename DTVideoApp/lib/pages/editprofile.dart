// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/sharedpre.dart';
import 'package:dtvideo/utils/utils.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mynetworkimg.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../widget/mytextfield.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Editprofile extends StatefulWidget {
  String? imagepath, fullname;

  Editprofile({Key? key, this.imagepath, this.fullname}) : super(key: key);

  @override
  State<Editprofile> createState() => EditprofileState();
}

class EditprofileState extends State<Editprofile> {
  SharedPre sharePref = SharedPre();
  final ImagePicker picker = ImagePicker();
  XFile? _image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  String? userid, email, mobile;
  bool imgselect = false;

  _imgFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
      imgselect = true;
    });
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
      imgselect = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    userid = await sharePref.read("userid") ?? "";
    email = await sharePref.read("email") ?? "";
    mobile = await sharePref.read("mobile") ?? "";
    log("===>userID $userid");
    log("===>fullname ${widget.fullname} ${widget.imagepath}");
    log("===>image ${widget.imagepath}");

    nameController.text = widget.fullname.toString();
    emailController.text = email.toString();
    mobileController.text = mobile.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            editProfileUI(),
          ],
        ),
      ),
    );
  }

  Widget editProfileUI() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    gradient: LinearGradient(
                      colors: [
                        editgradiantOne.withOpacity(0.2),
                        editgradiantTwo.withOpacity(0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.5, 2],
                    ),
                  ),
                  child: MyImage(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                      imagePath: "assets/images/editprofile.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        DottedBorder(
                          dashPattern: const [5, 5],
                          borderType: BorderType.RRect,
                          color: botborder,
                          radius: const Radius.circular(40),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: _image != null
                                  ? Image.file(
                                      File(_image!.path),
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.fill,
                                    )
                                  : ((widget.imagepath?.length ?? 0) != 0)
                                      ? MyNetworkImage(
                                          width: 100,
                                          height: 100,
                                          imagePath:
                                              widget.imagepath.toString(),
                                          fit: BoxFit.cover,
                                        )
                                      : MyImage(
                                          width: 100,
                                          height: 100,
                                          imagePath:
                                              "assets/images/username.png",
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  debugPrint("Click");
                                  _showPicker(context);
                                },
                                child: MyImage(
                                    width: 25,
                                    height: 25,
                                    imagePath: "assets/images/edit.png"),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: LanguageText(
                        color: white,
                        text: "editprofile",
                        fontsize: 18,
                        fontwaight: FontWeight.w500,
                        textalign: TextAlign.center,
                        fontstyle: FontStyle.normal),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        iconSize: 15,
                        onPressed: () {
                          debugPrint("Click");
                          Navigator.pop(context, true);
                        },
                        icon: MyImage(
                            width: 20,
                            height: 20,
                            imagePath: "assets/images/back.png")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        iconSize: 15,
                        onPressed: () {
                          debugPrint("Click");
                          _showPicker(context);
                        },
                        icon: MyImage(
                            width: 20,
                            height: 20,
                            imagePath: "assets/images/edit.png")),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  MyText(
                    color: black,
                    text: "emailid",
                    fontsize: 14,
                    fontwaight: FontWeight.w500,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: TextField(
                          controller: nameController,
                          autocorrect: true,
                          enabled: true,
                          decoration: const InputDecoration(
                            hintText: 'Enter Your FullName',
                            prefixIcon: Icon(Icons.mail),
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white70,
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyText(
                    color: black,
                    text: "emailid",
                    fontsize: 14,
                    fontwaight: FontWeight.w500,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: TextField(
                          controller: emailController,
                          autocorrect: true,
                          enabled: false,
                          decoration: const InputDecoration(
                            hintText: 'Enter Your Email Address',
                            prefixIcon: Icon(Icons.mail),
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white70,
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyText(
                    color: black,
                    text: "contectno",
                    fontsize: 14,
                    fontwaight: FontWeight.w500,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 05),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        // height: MediaQuery.of(context).size.height * 0.08,
                        child: IntlPhoneField(
                          controller: mobileController,
                          showCountryFlag: false,
                          showDropdownIcon: false,
                          enabled: true,
                          dropdownTextStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'Enter Your Phone Number',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white70,
                            border: InputBorder.none,
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                          ),
                          onChanged: (value) {
                            log('===> ${value.completeNumber}');
                            mobile = value.completeNumber;
                            log('===>mobileNumber $mobile');
                          },
                          onCountryChanged: (country) {
                            log('===> ${country.name}');
                            log('===> ${country.code}');
                          },
                        )),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () async {
                          widget.fullname = nameController.text.toString();
                          email = emailController.text.toString();
                          mobile = mobileController.text.toString();

                          if (nameController.text.isEmpty) {
                            Utils().showToast("Please enter your fullname");
                            return;
                          }

                          File image;
                          if (imgselect) {
                            log("===>if");
                            image = File(_image!.path);
                          } else {
                            image = File("");
                          }

                          final updateprofileprovider =
                              Provider.of<ApiProvider>(context, listen: false);
                          await updateprofileprovider.updateprofile(
                              userid, widget.fullname, email, mobile, image);
                          if (updateprofileprovider.loading) {
                            Utils().showToast(updateprofileprovider
                                .updateprofilemodel.message
                                .toString());
                          }
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            gradient: LinearGradient(colors: [
                              editgradiantBtnOne,
                              editgradiantBtnTwo
                            ]),
                          ),
                          child: LanguageText(
                              color: white,
                              text: "save",
                              fontsize: 14,
                              fontwaight: FontWeight.w500,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
