import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giga_test_app/bloc/user/user_bloc.dart';
import 'package:giga_test_app/bloc/user/user_event.dart';
import 'package:giga_test_app/bloc/user/user_state.dart';
import 'package:giga_test_app/models/user_model.dart';
import 'package:giga_test_app/providers/user_provider.dart';
import 'package:giga_test_app/widgets/circle_container.dart';
import 'package:giga_test_app/widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;
  late final UserProvider _userProvider = context.read<UserProvider>();
  final List<bool> _selectedSource = [true, false];
  final List<bool> _selectedGender = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _myAppBar(context),
      body: _body(context),
    );
  }

  Column _body(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Text('Select The Source'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: _MyToggleButton(
              _selectedSource, [const Text('DB'), const Text('APi')]),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Text('Select The Gender'),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: _MyToggleButton(
              _selectedGender, [const Text('Male'), const Text('Female')]),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserNewFetchState) {
                context.read<UserBloc>().add(UserFetchEvent(
                    _selectedSource[0],
                    page,
                    _selectedGender[0] == true ? 'male' : 'female'));
              }
            },
            builder: (context, state) {
              if (state is UserErrorState) {
                return Text(state.message!);
              }
              if (state is UserNoUserState) {
                return const Text(
                    'The database is empty, please make a api request or return the page');
              }

              if (state is UserLoadingState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => const LoadingWidget(),
                  itemCount: 6,
                );
              }
              if (state is UserLoadedState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.users!.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setProvider(state.result, index);
                        Navigator.pushNamed(context, '/user');
                      },
                      child: ListTile(
                          leading: Circle_Container(
                              url: state
                                  .result.users![index].picture!.medium!),
                          title: Text(
                            '${state.result.users![index].name!.title!} ${state.result.users![index].name!.first!} ${state.result.users![index].name!.last!}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          subtitle: Text(state.result.users![index].email!,
                              style: const TextStyle(fontSize: 12)),
                          dense: true,
                          trailing: const Icon(Icons.navigate_next)),
                    ),
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Welcome to The Random User App'),
                );
              }
            },
            buildWhen: (previous, current) => previous != current,
          ),
        ),
        _buttonRow(context)
      ],
    );
  }

  Row _buttonRow(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  page += 1;
                  context.read<UserBloc>().add(UserFetchEvent(
                      _selectedSource[0],
                      page,
                      _selectedGender[0] == true ? 'male' : 'female'));
                },
                child: const Text('Next Page')),
            ElevatedButton(
                onPressed: () {
                  if (page >= 1) {
                    page -= 1;
                  }
                  context.read<UserBloc>().add(UserFetchEvent(
                      _selectedSource[0],
                      page,
                      _selectedGender[0] == true ? 'male' : 'female'));
                },
                child: const Text('Previous Page')),
            ElevatedButton(
                onPressed: () {
                  page += 1;
                  context.read<UserBloc>().add(UserDBDeleteEvent());
                },
                child: const Text('Clean DB')),
          ],
        );
  }

  ToggleButtons _MyToggleButton(List<bool> list, List<Widget> children) {
    return ToggleButtons(
      isSelected: list,
      onPressed: (int index) {
        setState(() {
          list[0] = !list[0];
          list[1] = !list[1];
        });
      },
      children: children,
    );
  }

  AppBar _myAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Random App'),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: InkWell(
            onTap: () {
              context.read<UserBloc>().add(UserFetchEvent(_selectedSource[0], 0,
                  _selectedGender[0] == true ? 'male' : 'female'));
            },
            child: const Icon(Icons.refresh),
          ),
        )
      ],
    );
  }

  void setProvider(Result result, int index) {
    _userProvider.setEmail(result.users![index].email!);
    _userProvider.setName(
        '${result.users![index].name!.title!} ${result.users![index].name!.first!} ${result.users![index].name!.last!}');
    _userProvider.setgender(result.users![index].gender!);
    _userProvider.setLargePicture(result.users![index].picture!.large!);
    _userProvider.setThumbnail(result.users![index].picture!.thumbnail!);
  }
}
