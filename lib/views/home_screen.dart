import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giga_test_app/bloc/user/user_bloc.dart';
import 'package:giga_test_app/bloc/user/user_event.dart';
import 'package:giga_test_app/bloc/user/user_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random App'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24.0),
            child: InkWell(
              onTap: () {
                context.read<UserBloc>()
                  ..add(UserFetchEvent(false, 1, 'male'));
              },
              child: Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is UserErrorState)
          {
            return Container(
                height: 100,
                width: 100,
                color:Colors.pink
            );
          }

          if(state is UserLoadingState)
          {
            return Container(
                height: 100,
                width: 100,
                color:Colors.grey
            );
          }
          if(state is UserLoadedState)
            {
              return Container(
                  height: 100,
                  width: 100,
                  color:Colors.blue
              );
            }
          else
            {
              return Container(
                  height: 100,
                  width: 100,
                  color:Colors.red
              );
            }

        },
        buildWhen: (previous, current) => previous != current,
      ),
    );
  }
}
/*
ListView(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(12)),
          child:  ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Jose Carlos Segundo'),
            subtitle: Text('jose2@gmail.com'),
            trailing: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/user'),
                icon: Icon(Icons.navigate_next)),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 20))),
              onPressed: () {},
              child: const Text('Load More')),
        )
      ])
 */
