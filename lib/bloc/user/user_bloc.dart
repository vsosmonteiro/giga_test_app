import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giga_test_app/bloc/user/user_event.dart';
import 'package:giga_test_app/bloc/user/user_state.dart';
import 'package:giga_test_app/models/exceptions/no_user_exception.dart';
import 'package:giga_test_app/models/user_model.dart';
import 'package:giga_test_app/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<UserFetchEvent>((event, emit) async {
      try {
        Result result = await UsersRepository.repoFetchUser(
            page: event.page, gender: event.gender);
        emit(
          UserLoadedState(result),
        );
      } on NoUserException catch (e) {
        emit(UserErrorState(e.message));
      }
      on<UserDeleteEvent>((event, emit) {

      });
    });
  }
}
