import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
                    content: Text('Deseja deletar esse usuário?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Sim'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Não'),
                      )
                    ],
                  );
                });
          },
          label: Text('Delete user from DB')),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://sm.ign.com/ign_br/screenshot/default/blob_3r9t.jpg'),
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
                                children: const [
                                  Text('jose@gmail.com'),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text('Jose Sousa Segundo')
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.male,
                                color: Colors.blue,
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
            SizedBox(
              height: 12,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  'Dados do usuário',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(color: Colors.grey),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('jose@gmail.com'),
                  IconButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            const ClipboardData(text: "your text"));
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
                  const Text('Jose Sousa Segundo'),
                  IconButton(
                      onPressed: () async {
                        await Clipboard.setData(
                            const ClipboardData(text: "your text"));
                      },
                      icon: const Icon(Icons.copy))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
