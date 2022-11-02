import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giga_test_app/repositories/user_repository.dart';
import 'package:giga_test_app/widgets/circle_container.dart';
import 'package:giga_test_app/widgets/stack_widget.dart';
import 'package:provider/provider.dart';

import '../bloc/user/user_bloc.dart';
import '../bloc/user/user_event.dart';
import '../providers/user_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final UserProvider _userProvider = context.read<UserProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _floatingButton(context),
      body:  SingleChildScrollView(child: _body(context)),
    );
  }

  Column _body(BuildContext context)  {
    return Column(
      children: [
        const Stackwidget(),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          decoration: const BoxDecoration(color: Colors.grey),
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
              'Dados do usuário',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
         _copyWidget(_userProvider.email),
        _copyWidget(_userProvider.name),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          child: const Text('Return '),
        ),
      ],
    );
  }

  Padding _copyWidget(String value)  {
    return Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value),
            IconButton(
                onPressed: () async {
                  await Clipboard.setData(
                      ClipboardData(text: value));
                },
                icon: const Icon(Icons.copy))
          ],
        ),
      );
  }

  FloatingActionButton _floatingButton(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text('Deseja deletar esse usuário?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.read<UserBloc>()
                          ..add(UserDeleteEvent(_userProvider.email));
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Sim'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Não'),
                    )
                  ],
                );
              });
        },
        label: const Text('Delete user from DB'));
  }
}
