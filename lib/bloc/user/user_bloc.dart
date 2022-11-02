import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giga_test_app/bloc/user/user_event.dart';
import 'package:giga_test_app/bloc/user/user_state.dart';
import 'package:giga_test_app/models/exceptions/no_user_exception.dart';
import 'package:giga_test_app/models/user_model.dart';
import 'package:giga_test_app/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<UserFetchEvent>(
      (event, emit) async {
        emit(UserLoadingState());
        try {
          Result result = await UsersRepository.repoFetchUser(
              page: event.page, gender: event.gender, dbuse: event.db);
          emit(
            UserLoadedState(result),
          );
        } on NoUserException catch (e) {
          emit(
            UserErrorState(e.message),
          );
        }
      },
    );
    on<UserDeleteEvent>(
      (event, emit) async {
        await UsersRepository.deleteUser(event.email);
        emit(UserNewFetchState());
      },
    );
    on<UserInsertEvent>(
      (event, emit) async {
        await UsersRepository.insertUser(event.user);
        emit(UserNewFetchState());
      },
    );
    on<UserDBDeleteEvent>((event,emit){
      UsersRepository.deleteDB();
      emit(UserNewFetchState());
    });
  }
}
