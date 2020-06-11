import 'package:flutter/material.dart';
import 'package:quiz/Colors.dart';
import 'package:quiz/USER/BeginnerTab.dart';
import 'package:quiz/USER/Delegate.dart';
import 'package:quiz/USER/ExpertTab.dart';
import 'package:quiz/USER/Intermediate.dart';
import 'package:quiz/USER/User.dart';

class QuizCategories extends StatefulWidget {
  User user;
  QuizCategories(this.user);

  @override
  _QuizCategoriesState createState() => _QuizCategoriesState();
}

class _QuizCategoriesState extends State<QuizCategories>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              forceElevated: boxIsScrolled,
              floating: false,
              pinned: false,
              backgroundColor: pinkey,
              expandedHeight: 0.1996 * height,
              leading: FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: const FractionalOffset(3.9, 1.0),
                                end: const FractionalOffset(0.4, 1.9),
                                colors: [move, pinkey],
                                stops: [0.0, 1.6],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 0.0335 * height, left: 0.0462 * width),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Hi There "+ widget.user.prenom+"\nThese are our quizes",
                              style: titlesmall(height),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: ProfHeader(
                  maxExtent: 0.098 * height,
                  minExtent: 0.098 * height,
                  tabcontoller: _tabController),
              pinned: true,
              floating: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            BeginnerTab(widget.user),
            IntermediateTab(widget.user),
            ExpertTab(widget.user)
          ],
        ),
      ),
    );
  }
}






