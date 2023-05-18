import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:dtvideo/model/addcommentmodel.dart';
import 'package:dtvideo/model/addfavouritemodel.dart';
import 'package:dtvideo/model/addlikemodel.dart';
import 'package:dtvideo/model/albumnmodel.dart';
import 'package:dtvideo/model/artistlistmodel.dart';
import 'package:dtvideo/model/artistprofilemodel.dart';
import 'package:dtvideo/model/categorylistmodel.dart';
import 'package:dtvideo/model/chackfavouritemodel.dart';
import 'package:dtvideo/model/explore.dart';
import 'package:dtvideo/model/favouritelistmodel.dart';
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
import 'package:dtvideo/model/viewcommentmodel.dart';
import 'package:dtvideo/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../model/videomodel.dart';

class ApiService {
  String baseurl = "${Constant().baseurl}/api/";
  late Dio dio;

  ApiService() {
    dio = Dio();
    dio.interceptors.add(dioLoggerInterceptor);
  }

  Future<Generalsettingmodel> genaralSetting() async {
    Generalsettingmodel generalSettingModel;
    String generalsetting = "general_setting";
    Response response = await dio.get('$baseurl$generalsetting');
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("generalsetting apiservice:===>${response.data}");
      generalSettingModel =
          Generalsettingmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return generalSettingModel;
  }

  Future<Registrationmodel> ragister(fullname, email, mobile, password) async {
    Registrationmodel registerModel;
    String registration = "registration";
    Response response = await dio.post('$baseurl$registration',
        queryParameters: {
          'fullname': fullname,
          'email': email,
          'password': password,
          'mobile': mobile
        });
    registerModel = Registrationmodel.fromJson(jsonDecode(response.data));
    return registerModel;
  }

  Future<Loginmodel> login(email, password, deviceToken, type) async {
    debugPrint("login fullname:$email");
    debugPrint("login password:$password");
    Loginmodel loginmodel;
    String login = "login";

    Response response = await dio.post('$baseurl$login',
        data: FormData.fromMap({
          'email': email,
          'password': password,
          'device_token': deviceToken,
          'type': type,
        }));

    if (response.statusCode == 200) {
      loginmodel = Loginmodel.fromJson(jsonDecode(response.data));
    } else if (response.statusCode == 400) {
      loginmodel = Loginmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }

    return loginmodel;
  }

  Future<Loginmodel> loginwithotp(mobile) async {
    Loginmodel loginmodel;
    String login = "loginwithotp";
    Response response = await dio.post('$baseurl$login',
        data: FormData.fromMap({
          'mobile': mobile,
        }));
    if (response.statusCode == 200) {
      loginmodel = Loginmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return loginmodel;
  }

  Future<VideoModel> featurevideos() async {
    VideoModel videoModel;
    String methodname = "featurevideos";
    Response response = await dio.post('$baseurl$methodname'
        // data: FormData.fromMap({"is_feature": "1"})
        );
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint(response.data);
      videoModel = VideoModel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return videoModel;
  }

  Future<Artistlistmodel> artist() async {
    Artistlistmodel artistlistmodel;
    String methodname = "artistlist";
    Response response = await dio.get('$baseurl$methodname');
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint(" artistlist apiservice:===>${response.data}");
      artistlistmodel = Artistlistmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return artistlistmodel;
  }

  Future<Categorylistmodel> categorylist() async {
    Categorylistmodel categorylistmodel;
    String methodname = "categorylist";
    Response response = await dio.get('$baseurl$methodname');
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint(" categorylist apiservice:===>${response.data}");
      categorylistmodel = Categorylistmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return categorylistmodel;
  }

  Future<Latestvideomodel> latestvideos() async {
    Latestvideomodel latestvideomodel;
    String methodname = "latestvideos";
    Response response = await dio.get('$baseurl$methodname');
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint(" latestvideo apiservice:===>${response.data}");
      latestvideomodel = Latestvideomodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return latestvideomodel;
  }

  Future<Mostviewvideomodel> mostviewvideos() async {
    Mostviewvideomodel mostviewvideomodel;
    String methodname = "mostviewvideos";
    Response response = await dio.get('$baseurl$methodname');
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint(" mostviewvideo apiservice:===>${response.data}");
      mostviewvideomodel =
          Mostviewvideomodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return mostviewvideomodel;
  }

  Future<Relatedvideomodel> relatedvideo(catid, id) async {
    Relatedvideomodel relatedvideomodel;
    String methodname = "related_item";
    debugPrint('$baseurl$methodname');
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"cat_id": catid, "id": id}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint(" relatedvideo apiservice:===>${response.data}");
      relatedvideomodel = Relatedvideomodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return relatedvideomodel;
  }

  Future<Videobyidmodel> videoById(id, userid) async {
    Videobyidmodel videobyidmodel;
    String methodname = "video_by_id";
    debugPrint('$baseurl$methodname/$id');
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"id": id, "user_id": userid}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint(" videobyid apiservice:===>${response.data}");
      videobyidmodel = Videobyidmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return videobyidmodel;
  }

  Future<Videobyidmodel> videoBycatid(id) async {
    Videobyidmodel videobyidmodel;
    String methodname = "video_by_category";
    debugPrint('$baseurl$methodname/$id');
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({
          "category_id": id,
        }));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint(" video_by_category apiservice:===>${response.data}");
      videobyidmodel = Videobyidmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return videobyidmodel;
  }

  Future<Videobyidmodel> getAlbumDetail(id) async {
    Videobyidmodel videobyidmodel;
    String methodname = "get_album_detail";
    debugPrint('$baseurl$methodname/$id');
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"album_id": id}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint(" get_album_detail apiservice:===>${response.data}");
      videobyidmodel = Videobyidmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return videobyidmodel;
  }

  Future<Favouritelistmodel> favouritelist(userid) async {
    debugPrint("userid apiservice favouritelist:$userid");
    Favouritelistmodel favouritelistmodel;
    String methodname = "favorite_list";
    debugPrint('$baseurl$methodname');
    debugPrint(userid);
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"user_id": userid}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("==> favouritelist apiservice:===>${response.data}");
      favouritelistmodel =
          Favouritelistmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return favouritelistmodel;
  }

  Future<Profilemodel> profile(id) async {
    Profilemodel profilemodel;
    String methodname = "profile";
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"user_id": id}));
    debugPrint("profile data ===>>:${response.data}");
    if (response.statusCode == 200) {
      debugPrint(" profile apiservice:===>${response.data}");
      profilemodel = Profilemodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return profilemodel;
  }

  Future<Artistprofilemodel> artistProfile(id, userid) async {
    debugPrint("artist ID:---$id");
    Artistprofilemodel artistprofilemodel;
    String methodname = "artist_profile";
    debugPrint('$baseurl$methodname/$id');
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"id": id, "user_id": userid}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("artistprofile apiservice:===>${response.data}");
      artistprofilemodel =
          Artistprofilemodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return artistprofilemodel;
  }

  Future<Updateprofilemodel> updateProfile(
      userid, fullname, email, mobile, File file) async {
    Updateprofilemodel updateprofilemodel;
    String methodname = "update_profile";
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({
          "user_id": userid,
          "fullname": fullname,
          "email": email,
          "mobile": mobile,
          if (file.path.isNotEmpty)
            "image": await MultipartFile.fromFile(file.path,
                filename: basename(file.path))
        }));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("UpdateProfile apiservice:===>${response.data}");
      updateprofilemodel =
          Updateprofilemodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return updateprofilemodel;
  }

  Future<Viewcommentmodel> viewcomment(id) async {
    Viewcommentmodel viewcommentmodel;
    String methodname = "view_comment";
    debugPrint('$baseurl$methodname');
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"video_id": id}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("viewcomment apiservice:===>${response.data}");
      viewcommentmodel = Viewcommentmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return viewcommentmodel;
  }

  Future<Addlikemodel> addLike(videoid, userid) async {
    Addlikemodel addlikemodel;
    String methodname = "add_like";
    debugPrint('$baseurl$methodname');
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"id": videoid, "user_id": userid}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("addlike apiservice:===>${response.data}");
      addlikemodel = Addlikemodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return addlikemodel;
  }

  Future<PackagesModel> package() async {
    PackagesModel packagemodel;
    String methodname = "get_package";
    Response response = await dio.get('$baseurl$methodname');
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("generalsetting apiservice:===>${response.data}");
      packagemodel = PackagesModel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return packagemodel;
  }

  Future<Addfavouritemodel> addFavorite(videoid, userid) async {
    Addfavouritemodel addfavouritemodel;
    String methodname = "add_favorite";
    debugPrint('$baseurl$methodname');
    debugPrint(userid);
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"video_id": videoid, "user_id": userid}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("addfavourite apiservice:===>${response.data}");
      addfavouritemodel = Addfavouritemodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return addfavouritemodel;
  }

  Future<Chackfavouritemodel> checkFavorite(videoid, userid) async {
    Chackfavouritemodel chackfavouritemodel;
    String methodname = "checkfavorite";
    debugPrint('$baseurl$methodname');
    debugPrint(userid);
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"video_id": videoid, "user_id": userid}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("chackfavourite apiservice:===>${response.data}");
      chackfavouritemodel =
          Chackfavouritemodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return chackfavouritemodel;
  }

  Future<Searchmodel> search(name) async {
    Searchmodel searchmodel;
    String methodname = "videosearch";
    debugPrint('$baseurl$methodname');
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"name": name}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("Video Search apiservice:===>${response.data}");
      searchmodel = Searchmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return searchmodel;
  }

  Future<Albumnmodel> albumn() async {
    Albumnmodel albumnmodel;
    String methodname = "get_album";
    debugPrint('$baseurl$methodname');
    Response response = await dio.post('$baseurl$methodname');
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("Albumn apiservice:===>${response.data}");
      albumnmodel = Albumnmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return albumnmodel;
  }

  Future<Addcommentmodel> addcomment(userid, videoid, comment) async {
    Addcommentmodel addcommentmodel;
    String methodname = "add_comment";
    debugPrint('$baseurl$methodname');
    debugPrint(userid);
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap(
            {"user_id": userid, "video_id": videoid, "comment": comment}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("addcomment apiservice:===>${response.data}");
      addcommentmodel = Addcommentmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return addcommentmodel;
  }

  Future<Videobyartistmodel> videoByArtist(aristid) async {
    Videobyartistmodel videobyartistmodel;
    String methodname = "video_by_artist";
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"artist_id": aristid}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("addcomment apiservice:===>${response.data}");
      videobyartistmodel =
          Videobyartistmodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return videobyartistmodel;
  }

  Future<Exploremodel> explore(pageno) async {
    Exploremodel exploremodel;
    String methodname = "video_list";
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"page_no": pageno}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("explore apiservice:===>${response.data}");
      exploremodel = Exploremodel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return exploremodel;
  }

  Future<SuccessModel> addview(id) async {
    SuccessModel successModel;
    String methodname = "add_view";
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"id": id}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("explore apiservice:===>${response.data}");
      successModel = SuccessModel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return successModel;
  }

  Future<SuccessModel> addfollow(userId, toUserId) async {
    SuccessModel successModel;
    String methodname = "follow";
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"user_id": userId, "artist_id": toUserId}));
    debugPrint(response.data);
    if (response.statusCode == 200) {
      debugPrint("follow apiservice:===>${response.data}");
      successModel = SuccessModel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return successModel;
  }

  Future<PackagesModel> packages() async {
    PackagesModel packagesModel;
    String profile = "get_packages";
    Response response = await dio.get('$baseurl$profile');
    if (response.statusCode == 200) {
      debugPrint("Package apiservice:===>${response.data}");
      packagesModel = PackagesModel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return packagesModel;
  }

  Future<SuccessModel> addTransacation(
      String userId, String planId, String amount, String coin) async {
    SuccessModel successModel;
    String content = "add_transaction";
    Response response = await dio.post('$baseurl$content',
        data: FormData.fromMap({
          'user_id': userId,
          'package_id': planId,
          'currency_code': "INR",
          'description': "test transacation",
          'state': "state",
          'amount': amount,
          'payment_id': coin
        }));
    debugPrint("${response.data}");
    if (response.statusCode == 200) {
      debugPrint("add_transaction apiservice:===>${response.data}");
      successModel = SuccessModel.fromJson(jsonDecode(response.data));
    } else {
      throw Exception('Failed to load album');
    }
    return successModel;
  }

  Future<NotificationModel> getnotification(id) async {
    NotificationModel notificationModel;
    String methodname = "get_notification";
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({"user_id": id}));
    notificationModel = NotificationModel.fromJson(jsonDecode(response.data));
    return notificationModel;
  }

  Future<SuccessModel> readnotification(id, notificationid) async {
    SuccessModel successModel;
    String methodname = "read_notification";
    Response response = await dio.post('$baseurl$methodname',
        data: FormData.fromMap({
          "user_id": id,
          "notification_id": notificationid,
        }));
    successModel = SuccessModel.fromJson(jsonDecode(response.data));
    return successModel;
  }
}
