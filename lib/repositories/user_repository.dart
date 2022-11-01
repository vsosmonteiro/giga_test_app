import 'package:giga_test_app/models/user_model.dart';
import 'package:giga_test_app/services/user_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UsersRepository{
  final Connectivity _connectivity = Connectivity();


 Future<UserModel> repoFetchUser({required int page, required String gender})
 async {
   ConnectivityResult connectivityResult= await _connectivity.checkConnectivity();
   if(connectivityResult != ConnectivityResult.none)
     {
       return UserModel.fromJson(await UserService.fetchUsers(page: page, gender: gender));
     }
   return UserModel.fromJson( await UserService.fetchUsers(page: page, gender: gender));

 }

}