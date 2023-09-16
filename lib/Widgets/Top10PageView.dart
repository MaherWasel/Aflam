import 'package:flutter/material.dart';

class Top10PageView extends StatelessWidget {
  final ScrollController scrollController;

  Top10PageView({required this.scrollController});
  List<Widget> list = [
    Container(
      width: 150,
      color: Colors.red,
    ),
    Container(
      width: 150,
      color: Colors.blue,
    ),
    Container(
      width: 150,
      color: Colors.purple,
    ),
    Container(
      width: 150,
      color: Colors.green,
    ),
    Container(
      width: 150,
      color: Colors.yellow,
    ),
    Container(
      width: 150,
      color: Colors.orange,
    ),
    Container(
      width: 150,
      color: Colors.grey,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: list[index],
          ),
        );
      },
    );
  }
}
