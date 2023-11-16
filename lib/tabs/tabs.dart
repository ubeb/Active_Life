import 'package:coba/tabs/Homepage.dart';
import 'package:coba/tabs/crud.dart';
import 'package:coba/tabs/fcm.dart';
import 'package:coba/tabs/profile.dart';
import 'package:coba/tabs/testpage.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  final Map<String, String> userData;

  Tabs({required this.userData});

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          fcm(),
          crud(),
          Profile(),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.explicit, size: 26.0),
          ),
          Tab(
            icon: Icon(Icons.fitness_center, size: 26.0),
          ),
          Tab(
            icon: Icon(Icons.account_circle_outlined, size: 26.0),
          ),
        ],
        labelPadding: EdgeInsets.all(5.0),
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.black12,
        indicatorWeight: 0.01,
        isScrollable: false,
      ),
    );
  }
}
