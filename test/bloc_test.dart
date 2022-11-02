import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:giga_test_app/bloc/user/user_bloc.dart';
import 'package:giga_test_app/bloc/user/user_event.dart';
import 'package:giga_test_app/bloc/user/user_state.dart';
import 'package:giga_test_app/models/user_model.dart';
import 'package:giga_test_app/services/sql_service.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  group('User Bloc Test', ()  {
    late UserBloc userBloc;


    setUp(()  {
      userBloc = UserBloc();
    });

    test('Initial test ', () {
      expect(userBloc.state, UserInitialState());
    });

    blocTest<UserBloc, UserState>('Test user fetch Event from Api loading',
        build: () => userBloc,
        act: (bloc) => bloc.add(UserFetchEvent(false, 0, 'male')),
        expect: () => [isA <UserLoadingState>()]);

    expectLater(UserLoadingState(), isA <UserLoadedState>());
  });

}
