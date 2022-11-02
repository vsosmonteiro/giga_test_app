import 'package:equatable/equatable.dart';

class UserEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class UserFetchEvent extends UserEvent{
  bool db;
  int page;
  String gender;
  UserFetchEvent(this.db,this.page,this.gender);
}
class UserDeleteEvent extends UserEvent{
  String email;
  UserDeleteEvent(this.email);
}