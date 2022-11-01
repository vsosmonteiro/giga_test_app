import 'package:flutter/material.dart';

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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24.0),
            child: InkWell(
              child: Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: ListView(children: [
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
      ]),
    );
  }
}
