import 'package:equatable/equatable.dart';
import 'package:giga_test_app/models/user_model.dart';

class UserState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class UserInitialState extends UserState{}
class UserNoUserState extends UserState{}
class UserLoadingState extends UserState{}
class UserErrorState extends UserState{
  final String? message;
  UserErrorState(this.message);


}

class UserLoadedState extends UserState{
  Result result;
  UserLoadedState(this.result);
}
class UserNewFetchState extends UserState{}
