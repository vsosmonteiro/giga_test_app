import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  double start = 0.05;

  @override
  void initState() {
    _recursion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 70,
      duration: Duration(milliseconds: 10),
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.grey, Colors.white, Colors.grey],
            stops: [start - 0.05, start, start + 0.05],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: CircleAvatar(backgroundColor: Colors.grey.shade200,radius: 24,),
          ),
          Padding(padding: EdgeInsets.only(left: 30),child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [Container(height: 16,width: 120,color: Colors.grey.shade200,),SizedBox(height: 8,),Container(height: 16,width: 120,color: Colors.grey.shade200,)],))
        ],
      ),
    );
  }

  Future<void> _recursion() async {
    await Future.delayed(
      Duration(milliseconds: 10),
      () {
        if (mounted) {
          setState(
            () {
              if (start < 0.98) {
                start += 0.01;
              } else {
                start = 0.05;
              }
            },
          );
          _recursion();
        }
      },
    );
  }
}
