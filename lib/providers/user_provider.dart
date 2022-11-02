import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // provides the necessary data for the user screen
  String name = '';
  String email = '';
  String largePicture = '';
  String thumbnail = '';
  String gender = '';

  setEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  setName(String newName) {
    name = newName;
    notifyListeners();
  }

  setLargePicture(String newlargePicture) {
    largePicture = newlargePicture;
    notifyListeners();
  }

  setThumbnail(String newThumb) {
    thumbnail = newThumb;
    notifyListeners();
  }

  setgender(String newGender) {
    gender = newGender;
    notifyListeners();
  }
}
