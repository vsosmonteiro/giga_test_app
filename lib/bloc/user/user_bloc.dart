import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giga_test_app/bloc/user/user_event.dart';
import 'package:giga_test_app/bloc/user/user_state.dart';
import 'package:giga_test_app/models/exceptions/api_exception.dart';
import 'package:giga_test_app/models/exceptions/database_exception.dart';
import 'package:giga_test_app/models/exceptions/no_user_exception.dart';
import 'package:giga_test_app/models/user_model.dart';
import 'package:giga_test_app/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  // bloc to manage state
  UserBloc() : super(UserInitialState()) {
    //when you request the data
    on<UserFetchEvent>(
      _fetch
    );
    //when you delete the data
    on<UserDeleteEvent>(
     _deleteUser
    );
    //insert new user on db
    on<UserInsertEvent>(
      _insertUser
    );
    // delete user from db
    on<UserDBDeleteEvent>(
        _deleteDB
    );
  }

  Future<void> _deleteUser(UserDeleteEvent event, Emitter<UserState> emit) async {
    await UsersRepository.deleteUser(event.email);
    emit(UserNewFetchState());
  }

  FutureOr<void> _fetch(UserFetchEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      Result result = await UsersRepository.repoFetchUser(
          page: event.page, gender: event.gender, dbuse: event.db);
      //if everything is okay will emit
      emit(UserLoadedState(result),
      );
    } catch (e) {
      //if the list is empty
      if (e is NoUserException) {
        emit(
          UserNoUserState(),
        );
      }

      if (e is ApiException) {
        //if the request didnt make to the api
        if (e.code == -1) {
          emit(
            UserErrorState(' Error Sending Request'),
          );
        } else {
          //if the request make but didnt return 200
          emit(
            UserErrorState('API Error'),
          );
        }
      }
      if (e is MyDatabaseException) {
        //if the db Throw an error
        emit(
          UserErrorState('Database error, please try again'),
        );
      }
    }
  }

  FutureOr<void> _deleteDB(UserDBDeleteEvent event, Emitter<UserState> emit) async{
    await UsersRepository.deleteDB();
    emit(UserNewFetchState());
  }

  FutureOr<void> _insertUser(UserInsertEvent event, Emitter<UserState> emit) async{
    await UsersRepository.insertUser(event.user);
    emit(UserNewFetchState());
  }
}
