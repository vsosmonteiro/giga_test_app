import 'package:giga_test_app/services/user_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
class UsersRepository{
  final Connectivity _connectivity = Connectivity();
 Future<Map<String,dynamic>> repoFetchUser({required int page, required String gender})
 async {
   ConnectivityResult connectivityResult= await _connectivity.checkConnectivity();
   if(connectivityResult != ConnectivityResult.none)
     {
       return UserService.fetchUsers(page: page, gender: gender);
     }

 }

}