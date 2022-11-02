import 'package:flutter/foundation.dart';
import 'package:giga_test_app/models/exceptions/api_exception.dart';
import 'package:giga_test_app/models/exceptions/database_exception.dart';
import 'package:giga_test_app/models/exceptions/no_user_exception.dart';
import 'package:giga_test_app/models/user_model.dart';
import 'package:giga_test_app/services/user_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:giga_test_app/singletons.dart';


import '../services/sql_service.dart';

abstract class UsersRepository {
  static Future<Result> repoFetchUser(
      {required int page, required String gender, required bool dbuse}) async {
    final Connectivity connectivity = Connectivity();
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    // if there is connectivity and the request of db use is false it requests the api else requests the db
    if (connectivityResult != ConnectivityResult.none && dbuse == false) {
      //return a Result object
      Result result = Result.fromJson(
          await UserService.fetchUsers(page: page, gender: gender));
      result.users?.forEach((element) {
        insertUser(element);
      });
      return result;
    } else {
      try {
        //requests from the db
        List<Map<String, dynamic>> dbquery =
            await SqLiteService.getUsers(db!, gender, page);
        // if query is right but empty
        if (dbquery.isEmpty) {
          throw NoUserException(message: 'No More Users to Show');
        }
        Map<String, dynamic> result = {'results': []};
        result = Mapresult(result, dbquery);

        return Result.fromJson(result);
      } catch (e) {
        if (e is NoUserException) {
          throw NoUserException(message: 'No More Users to Show');
        }
        //if the db throws
        throw MyDatabaseException();
      }
    }
  }

  static Future<void> insertUser(User user) async {
    try {
      SqLiteService.insertUser(db!, user);
    } catch (e) {
      throw MyDatabaseException();
    }
  }

  static Future<void> deleteDB() async {
    try {
      SqLiteService.deleteDB(db!);
    } catch (e) {
      throw MyDatabaseException();
    }
  }

  static Future<void> deleteUser(String email) async {
    try {
      SqLiteService.deleteUser(db!, email);
    } catch (e) {
      throw MyDatabaseException();
    }
  }

  static Map<String, dynamic> Mapresult(
      Map<String, dynamic> result, List<Map<String, dynamic>> dbquery) {
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
    return result;
  }
}
