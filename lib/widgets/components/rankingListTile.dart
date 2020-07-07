import 'package:flutter/material.dart';

class RankingListTile extends StatelessWidget {
  final int rank;
  final String name;
  final double totalDistance;

  RankingListTile({@required this.rank, @required this.name, @required this.totalDistance});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(rank.toString()),
          Text(name),
          Text(totalDistance.toString())
        ],
      ),
    );
  }
}