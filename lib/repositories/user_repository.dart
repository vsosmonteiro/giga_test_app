import 'package:flutter/foundation.dart';
import 'package:giga_test_app/models/exceptions/api_exception.dart';
import 'package:giga_test_app/models/exceptions/no_user_exception.dart';
import 'package:giga_test_app/models/user_model.dart';
import 'package:giga_test_app/services/user_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:giga_test_app/singletons.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../services/sql_service.dart';

abstract class UsersRepository {


  static Future<Result> repoFetchUser(
      {required int page, required String gender, required bool dbuse}) async {
    final Connectivity _connectivity = Connectivity();
    ConnectivityResult connectivityResult =
    await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none && dbuse == false) {
      return Result.fromJson(
          await UserService.fetchUsers(page: page, gender: gender));
    }

    List<Map<String, dynamic>> dbquery = await SqLiteService.getUsers(
        db!, gender, page);
    if (dbquery.length <= 0) {
      throw NoUserException(message: 'No More Users to Show');
    }
    Map<String, dynamic> result = {'results': []};
    for (Map<String, dynamic> current in dbquery) {
      Map<String, dynamic> map = {
        'gender': current['gender'],
        'name': {
          'title': current['title'],
          'first': current['first_name'],
          'last': current['last_name']
        },
        'email': current['email'],
        'picture': {
          'large': current['picture_large'],
          'medium': current['picture_medium'],
          'thumbnail': current['thumbnail']
        }
      };
      result['results'].add(map);
    }

    return Result.fromJson(
        result);
  }
  static Future<void> insertUser(User user)async{
    SqLiteService.insertUser(db!, user);
  }

  static Future<void> deleteDB() async {
    SqLiteService.deleteDB(db!);
  }
  static Future<void> deleteUser(String email) async {
    SqLiteService.deleteUser(db!, email);
  }


}
/*
 {results: [{gender: male, name: {title: Mr, first: Jesualdo, last: Viana},
 email: jesualdo.viana@example.com,
 picture: {large: https://randomuser.me/api/portraits/men/28.jpg, medium: https://randomuser.me/api/portraits/med/men/28.jpg, thumbnail: https://randomuser.me/api/portraits/thumb/men/28.jpg}}],
  info: {seed: a205a81bcf927423, results: 1, page: 1, version: 1.4}}
 */