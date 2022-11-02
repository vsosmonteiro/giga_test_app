import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giga_test_app/repositories/user_repository.dart';
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
      floatingActionButton: FloatingActionButton.extended(
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
          label: const Text('Delete user from DB')),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(_userProvider.thumbnail),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 24,
                    right: 24,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, blurRadius: 10)
                          ]),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: [
                              const Icon(Icons.person),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_userProvider.email),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(_userProvider.name)
                                ],
                              ),
                              const Spacer(),
                              _userProvider.gender == 'male'
                                  ? Icon(
                                      Icons.male,
                                      color: Colors.blue,
                                    )
                                  : Icon(
                                      Icons.female,
                                      color: Colors.pink,
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_userProvider.email),
                  IconButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            ClipboardData(text: _userProvider.email));
                      },
                      icon: const Icon(Icons.copy))
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_userProvider.name),
                  IconButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            ClipboardData(text: _userProvider.name));
                      },
                      icon: const Icon(Icons.copy))
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: const Text('Return '),
            ),
          ],
        ),
      ),
    );
  }
}
