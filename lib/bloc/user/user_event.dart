import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';

class UserEvent extends Equatable{
  @override
  List<Object?> get props => [];

}


class UserFetchEvent extends UserEvent{
  //fetch data
  bool db;
  int page;
  String gender;
  UserFetchEvent(this.db,this.page,this.gender);
}


class UserDeleteEvent extends UserEvent{
  //delete from db
  String email;
  UserDeleteEvent(this.email);
}


class UserInsertEvent extends UserEvent{
  //insert in db
  User user;
  UserInsertEvent(this.user);
}


class UserDBDeleteEvent extends UserEvent{
  // delete the entire db
}