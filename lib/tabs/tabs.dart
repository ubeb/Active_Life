import 'package:coba/tabs/Homepage.dart';
import 'package:coba/tabs/fcm.dart';
import 'package:coba/tabs/profile.dart';
import 'package:coba/tabs/workout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tabs extends StatefulWidget {
  final Map<String, String> userData;

  Tabs({required this.userData});

  @override
  _TabsState createState() => _TabsState();
}

class TabControllerProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeTab(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  void changeTab(int index) {
    _tabController.animateTo(index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabControllerProvider()),
      ],
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 30),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[homepage(), Workout(), fcm(), profile()],
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
              icon: Icon(Icons.notifications, size: 26.0),
            ),
            Tab(
              icon: Icon(Icons.account_circle_outlined, size: 26.0),
            ),
          ],
          labelPadding: EdgeInsets.all(5.0),
          labelColor: Color.fromARGB(
            255,
            208,
            253,
            62,
          ),
          unselectedLabelColor: Colors.grey[700],
          indicatorWeight: 0.01,
          isScrollable: false,
        ),
      ),
    );
  }
}
