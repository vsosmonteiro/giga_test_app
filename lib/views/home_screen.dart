
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giga_test_app/bloc/user/user_bloc.dart';
import 'package:giga_test_app/bloc/user/user_event.dart';
import 'package:giga_test_app/bloc/user/user_state.dart';
import 'package:giga_test_app/widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page=0;
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
                context.read<UserBloc>()..add(UserFetchEvent(true, page, 'male'));
              },
              child: const Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is UserErrorState) {
                  return Container(height: 100, width: 100, color: Colors.pink);
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
                      margin:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
                          state.result.users![index].name!.title! +
                              ' ' +
                              state.result.users![index].name!.first! +
                              ' ' +
                              state.result.users![index].name!.last!,
                          style: TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(state.result.users![index].email!,
                            style: TextStyle(fontSize: 12)),
                        dense: true,
                        trailing: IconButton(
                            onPressed: () {
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
          ElevatedButton(onPressed: (){
            page+=1;
            context.read<UserBloc>()..add(UserFetchEvent(false, page, 'male'));
          }, child: Text('Next Page'))
        ],
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
