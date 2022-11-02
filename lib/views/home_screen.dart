import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giga_test_app/bloc/user/user_bloc.dart';
import 'package:giga_test_app/bloc/user/user_event.dart';
import 'package:giga_test_app/bloc/user/user_state.dart';
import 'package:giga_test_app/providers/user_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random App'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: InkWell(
              onTap: () {
                context.read<UserBloc>()
                  ..add(UserFetchEvent(_selectedSource[0], 0, 'male'));
              },
              child: const Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text('Select The Source'),
          ),
          ToggleButtons(
            children: [Text('DB'), Text('APi')],
            isSelected: _selectedSource,
            onPressed: (int index) {
              setState(() {
                _selectedSource[0] = !_selectedSource[0];
                _selectedSource[1] = !_selectedSource[1];
              });
            },
          ),
          Flexible(
            fit: FlexFit.loose,
            child: BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserNewFetchState) {
                  context
                      .read<UserBloc>()
                      .add(UserFetchEvent(_selectedSource[0], page, 'male'));
                }
              },
              builder: (context, state) {
                if (state is UserErrorState) {
                  return Container(
                    child: Text(
                        'The database is empty, please make a api request'),
                  );
                }

                if (state is UserLoadingState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => LoadingWidget(),
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
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  state.result.users![index].picture!.medium!),
                            ),
                          ),
                        ),
                        title: Text(
                          '${state.result.users![index].name!.title!} ${state.result.users![index].name!.first!} ${state.result.users![index].name!.last!}',
                          style: TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(state.result.users![index].email!,
                            style: TextStyle(fontSize: 12)),
                        dense: true,
                        trailing: IconButton(
                            onPressed: () {
                              _userProvider
                                  .setEmail(state.result.users![index].email!);
                              _userProvider.setName(
                                  '${state.result.users![index].name!.title!} ${state.result.users![index].name!.first!} ${state.result.users![index].name!.last!}');
                              _userProvider.setgender(
                                  state.result.users![index].gender!);
                              _userProvider.setLargePicture(
                                  state.result.users![index].picture!.large!);
                              _userProvider.setThumbnail(state
                                  .result.users![index].picture!.thumbnail!);

                              Navigator.pushNamed(context, '/user');
                            },
                            icon: Icon(Icons.navigate_next)),
                      ),
                    ),
                  );
                } else {
                  return Container(height: 100, width: 100, color: Colors.red);
                }
              },
              buildWhen: (previous, current) => previous != current,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    page += 1;
                    context.read<UserBloc>()
                      ..add(UserFetchEvent(_selectedSource[0], page, 'male'));
                  },
                  child: Text('Next Page')),
              ElevatedButton(
                  onPressed: () {
                    page += 1;
                    context.read<UserBloc>()..add(UserDBDeleteEvent());
                  },
                  child: Text('Clean DB')),
            ],
          )
        ],
      ),
    );
  }
}
