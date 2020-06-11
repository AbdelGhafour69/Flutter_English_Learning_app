import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz/Colors.dart';

class ProfHeader implements SliverPersistentHeaderDelegate {
  ProfHeader(
      {this.minExtent, @required this.maxExtent, this.tabcontoller});
  final double minExtent;
  final double maxExtent;
  final TabController tabcontoller;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: 0.0367*height),
      height: 0.306*height,
      decoration: BoxDecoration(
        color: pinkey,
        gradient: LinearGradient(
          begin: const FractionalOffset(3.9, 1.0),
          end: const FractionalOffset(0.4, 1.9),
          colors: [move, pinkey],
          stops: [0.0, 1.6],
        ),
      ),
      child: TabBar(
          controller: tabcontoller,
          labelColor: pinkey,
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white),
          tabs: [
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Beginner",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Intermediate",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Expert",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
    );
  }

  double titleOpacity(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
