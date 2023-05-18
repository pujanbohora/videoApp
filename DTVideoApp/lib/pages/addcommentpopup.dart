// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/utils.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Addcommentpopup extends StatefulWidget {
  var userid, videoid;

  Addcommentpopup({Key? key, this.userid, this.videoid}) : super(key: key);

  @override
  State<Addcommentpopup> createState() => AddcommentpopupState();
}

class AddcommentpopupState extends State<Addcommentpopup> {
  final addcommentController = TextEditingController();
  late String commentValue;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      insetPadding: const EdgeInsets.all(15),
      backgroundColor: addcommentPopup,
      child: dialogUI(),
    );
  }

  Widget dialogUI() {
    return SizedBox(
      width: 400,
      height: 320,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.center,
            child: MyText(
                color: white,
                text: "Add New Comment",
                fontsize: 16,
                fontwaight: FontWeight.w600,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
                textalign: TextAlign.left,
                fontstyle: FontStyle.normal),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                LanguageText(
                    color: white,
                    text: "yourrate",
                    fontsize: 14,
                    fontwaight: FontWeight.w600,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.left,
                    fontstyle: FontStyle.normal),
                const SizedBox(
                  width: 15,
                ),
                RatingBar.builder(
                  minRating: 1,
                  itemSize: 25,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  unratedColor: gray,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: addcommentTextfield,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: TextField(
                textInputAction: TextInputAction.done,
                obscureText: false,
                controller: addcommentController,
                keyboardType: TextInputType.text,
                maxLines: 5,
                style: const TextStyle(
                  color: white,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  hintStyle: TextStyle(
                      color: otpdivider,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400),
                  hintText: "Add Comment",
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.only(right: 15),
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () async {
                // ignore: unused_local_variable
                var addcommentprovider =
                    Provider.of<ApiProvider>(context, listen: false);

                await addcommentprovider.addcomment(
                    widget.userid, widget.videoid, addcommentController.text);
                if (addcommentprovider.loading) {
                  Navigator.pop(context, false);
                  Utils().showToast(
                      addcommentprovider.addcommentmodel.message.toString());
                }
              },
              child: Container(
                width: 100,
                height: 35,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: addcommentSubmitBtn,
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
                child: LanguageText(
                    color: white,
                    text: "submit",
                    fontsize: 12,
                    fontwaight: FontWeight.w600,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.left,
                    fontstyle: FontStyle.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
