import 'package:flutter/material.dart';
import 'package:giga_test_app/widgets/circle_container.dart';

import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

class Stackwidget extends StatefulWidget {
  // puts a stack with a bigger invisible container wrapping so i
  // can push the container down and not be clipped
  const Stackwidget({Key? key}) : super(key: key);

  @override
  State<Stackwidget> createState() => _StackwidgetState();
}

class _StackwidgetState extends State<Stackwidget> {
  late final UserProvider _userProvider = context.read<UserProvider>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                fit: BoxFit.contain,
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
                      Circle_Container(url: _userProvider.largePicture),
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
    );
  }
}
