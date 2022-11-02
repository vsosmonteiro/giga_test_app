import 'package:flutter/material.dart';
class Circle_Container extends StatefulWidget {
  final String url;
  const Circle_Container({Key? key,required this.url}) : super(key: key);

  @override
  State<Circle_Container> createState() => _Circle_ContainerState();
}

class _Circle_ContainerState extends State<Circle_Container> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
              widget.url),
        ),
      ),
    );
  }
}
