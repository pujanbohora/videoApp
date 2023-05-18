// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';

import 'package:dtvideo/model/addcommentmodel.dart';
import 'package:dtvideo/model/addfavouritemodel.dart';
import 'package:dtvideo/model/addlikemodel.dart';
import 'package:dtvideo/model/albumnmodel.dart';
import 'package:dtvideo/model/artistlistmodel.dart';
import 'package:dtvideo/model/artistprofilemodel.dart';
import 'package:dtvideo/model/categorylistmodel.dart';
import 'package:dtvideo/model/chackfavouritemodel.dart';
import 'package:dtvideo/model/explore.dart';
import 'package:dtvideo/model/generalsettingmodel.dart';
import 'package:dtvideo/model/latestvideomodel.dart';
import 'package:dtvideo/model/loginmodel.dart';
import 'package:dtvideo/model/mostviewvideomodel.dart';
import 'package:dtvideo/model/notificationmodel.dart';
import 'package:dtvideo/model/packagesmodel.dart';
import 'package:dtvideo/model/profilemodel.dart';
import 'package:dtvideo/model/ragistermodel.dart';
import 'package:dtvideo/model/relatedvideomodel.dart';
import 'package:dtvideo/model/searchmodel.dart';
import 'package:dtvideo/model/successmodel.dart';
import 'package:dtvideo/model/updateprofile.dart';
import 'package:dtvideo/model/videobyartist.dart';
import 'package:dtvideo/model/videobyidmodel.dart';
import 'package:dtvideo/model/videomodel.dart';
import 'package:dtvideo/model/favouritelistmodel.dart';
import 'package:dtvideo/model/viewcommentmodel.dart';
import 'package:dtvideo/utils/utils.dart';
import 'package:dtvideo/webservices/apiservice.dart';
import 'package:flutter/material.dart';

import '../utils/sharedpre.dart';

class ApiProvider extends ChangeNotifier {
  Generalsettingmodel generalsettingmodel = Generalsettingmodel();
  Registrationmodel registrationmodel = Registrationmodel();
  Loginmodel loginmodel = Loginmodel();
  VideoModel videomodel = VideoModel();
  Artistlistmodel artistlistmodel = Artistlistmodel();
  Categorylistmodel categorylistmodel = Categorylistmodel();
  Latestvideomodel latestvideomodel = Latestvideomodel();
  Mostviewvideomodel mostviewvideomodel = Mostviewvideomodel();
  Relatedvideomodel relatedvideomodel = Relatedvideomodel();
  Videobyidmodel videobyidmodel = Videobyidmodel();
  Videobyidmodel videosmodel = Videobyidmodel();
  Profilemodel profilemodel = Profilemodel();
  Favouritelistmodel favouritelistmodel = Favouritelistmodel();
  Artistprofilemodel artistprofilemodel = Artistprofilemodel();
  Updateprofilemodel updateprofilemodel = Updateprofilemodel();
  Viewcommentmodel viewcommentmodel = Viewcommentmodel();
  Addlikemodel addlikemodel = Addlikemodel();
  PackagesModel packagemodel = PackagesModel();
  Addfavouritemodel addfavouritemodel = Addfavouritemodel();
  Chackfavouritemodel chackfavouritemodel = Chackfavouritemodel();
  Searchmodel searchmodel = Searchmodel();
  Albumnmodel albumnmodel = Albumnmodel();
  Addcommentmodel addcommentmodel = Addcommentmodel();
  Videobyartistmodel videobyartistmodel = Videobyartistmodel();
  Exploremodel exploremodel = Exploremodel();
  SuccessModel successModel = SuccessModel();
  NotificationModel notificationModel = NotificationModel();

  bool loading = false;
  var fullname, email, mobile, password, deviceToken;
  bool ischange = true;
  String? userId;
  SharedPre sharePref = SharedPre();

  getUserId() async {
    userId = await sharePref.read("userid") ?? "";
    log('userId===> $userId');
  }

  getGeneralsetting() async {
    loading = false;
    generalsettingmodel = await ApiService().genaralSetting();
    debugPrint("${generalsettingmodel.status}");
    loading = true;
    notifyListeners();
  }

  registration(fullname, email, mobile, password) async {
    loading = false;
    registrationmodel =
        await ApiService().ragister(fullname, email, mobile, password);
    debugPrint("status register :== ${registrationmodel.status}");
    loading = true;
    notifyListeners();
  }

  login(email, password, deviceToken, type) async {
    loading = false;
    loginmodel = await ApiService().login(email, password, deviceToken, type);
    loading = true;
    notifyListeners();
  }

  loginwithotp(mobile) async {
    loading = false;
    loginmodel = await ApiService().loginwithotp(mobile);
    debugPrint("login status :== ${loginmodel.status}");
    loading = true;
    notifyListeners();
  }

  feturevideo(context) async {
    loading = false;
    videomodel = await ApiService().featurevideos();
    loading = true;
    notifyListeners();
  }

  artistlist(context) async {
    loading = false;
    artistlistmodel = await ApiService().artist();
    loading = true;
    notifyListeners();
  }

  categorylist(context) async {
    loading = false;
    categorylistmodel = await ApiService().categorylist();
    loading = true;
    notifyListeners();
  }

  latestvideo(context) async {
    loading = false;
    latestvideomodel = await ApiService().latestvideos();
    loading = true;
    notifyListeners();
  }

  mostviewvideo(context) async {
    loading = false;
    mostviewvideomodel = await ApiService().mostviewvideos();
    loading = true;
    notifyListeners();
  }

  relatedvideo(catid, id) async {
    debugPrint("CatID ==>:$catid");
    debugPrint("ID ==>:$id");
    loading = false;
    relatedvideomodel = await ApiService().relatedvideo(catid, id);
    loading = true;
    notifyListeners();
  }

  videobyid(id) async {
    loading = false;
    videobyidmodel = await ApiService().videoById(id, userId);
    loading = true;
    notifyListeners();
  }

  videoslist(id, type) async {
    loading = false;
    debugPrint("ID ==>:$id");
    if (type == "category") {
      videosmodel = await ApiService().videoBycatid(id);
    } else {
      videosmodel = await ApiService().getAlbumDetail(id);
    }
    debugPrint("Videolist ${videosmodel.status}");
    loading = true;
    notifyListeners();
  }

  profile() async {
    loading = false;
    profilemodel = await ApiService().profile(userId);
    loading = true;
    notifyListeners();
  }

  favouritelist(userid) async {
    debugPrint("ID ==>:$userid");
    loading = false;
    favouritelistmodel = await ApiService().favouritelist(userid);
    loading = true;
    notifyListeners();
  }

  artistprofile(id, userid) async {
    debugPrint("ID ==>:$id");
    loading = false;
    artistprofilemodel = await ApiService().artistProfile(id, userId);
    loading = true;
    notifyListeners();
  }

  updateprofile(userid, fullname, email, mobile, File file) async {
    debugPrint("ID ==>:$userid");
    loading = false;
    updateprofilemodel =
        await ApiService().updateProfile(userid, fullname, email, mobile, file);
    loading = true;
    notifyListeners();
  }

  viewcomment(id) async {
    loading = false;
    viewcommentmodel = await ApiService().viewcomment(id);
    loading = true;
    notifyListeners();
  }

  addlike(videoid, userid) async {
    loading = false;
    addlikemodel = await ApiService().addLike(videoid, userid);
    loading = true;
    notifyListeners();
  }

  package(context) async {
    loading = false;
    packagemodel = await ApiService().package();
    debugPrint("${packagemodel.status}");
    loading = true;
    notifyListeners();
  }

  addfavourite(videoid, userid) async {
    debugPrint("videoid addfavourite:$videoid");
    debugPrint("userid addfavourite:$userid");
    loading = false;
    addfavouritemodel = await ApiService().addFavorite(videoid, userid);
    debugPrint("${addfavouritemodel.status}");
    loading = true;
    notifyListeners();
  }

  chackfavourite(videoid, userid) async {
    debugPrint("videoid chackfavourite:$videoid");
    debugPrint("userid chackfavourite:$userid");
    loading = false;
    chackfavouritemodel = await ApiService().checkFavorite(videoid, userid);
    debugPrint("${chackfavouritemodel.status}");
    loading = true;
    notifyListeners();
  }

  search(name) async {
    debugPrint("search api:$name");
    loading = false;
    searchmodel = await ApiService().search(name);
    debugPrint(":Search api status:${searchmodel.status}");
    loading = true;
    notifyListeners();
  }

  albumn(context) async {
    loading = false;
    albumnmodel = await ApiService().albumn();
    debugPrint("Albumn status:${albumnmodel.status}");
    loading = true;
    notifyListeners();
  }

  addcomment(userid, videoid, comment) async {
    loading = false;
    addcommentmodel = await ApiService().addcomment(userid, videoid, comment);
    debugPrint("addcomment api status:${addcommentmodel.status}");
    loading = true;
    notifyListeners();
  }

  videobyArtist(artistid) async {
    debugPrint("VideoByArtist api:$artistid");
    // loading = false;
    videobyartistmodel = await ApiService().videoByArtist(artistid);
    debugPrint("VideoByArtist api status:${videobyartistmodel.status}");
    // loading = true;
    notifyListeners();
  }

  explore(pageno) async {
    debugPrint("pageno:$pageno");
    loading = false;
    exploremodel = await ApiService().explore(pageno);
    debugPrint("explore api status:${exploremodel.status}");
    loading = true;
    notifyListeners();
  }

  addview(id) async {
    loading = false;
    successModel = await ApiService().addview(id);
    loading = true;
    notifyListeners();
  }

  addfollow(userid, toUserId) async {
    loading = false;
    successModel = await ApiService().addfollow(userId, toUserId);
    loading = true;
    notifyListeners();
  }

  getPackage(context, userId) async {
    loading = false;
    packagemodel = await ApiService().packages();
    debugPrint("${packagemodel.status}");
    loading = true;
    notifyListeners();
  }

  getaddTranscation(
      String userId, String planId, String amount, String coin) async {
    loading = false;
    successModel =
        await ApiService().addTransacation(userId, planId, amount, coin);
    debugPrint("${successModel.status}");
    loading = true;
    notifyListeners();
  }

  getnotification(String userId) async {
    loading = false;
    notificationModel = await ApiService().getnotification(userId);
    loading = true;
    notifyListeners();
  }

  readnotification(String userId, String notificationId) async {
    loading = false;
    successModel = await ApiService().readnotification(userId, notificationId);
    loading = true;
    notifyListeners();
  }
}
