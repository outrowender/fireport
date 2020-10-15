import 'package:fireport/pages/cluster.tab.dart';
import 'package:fireport/pages/newuser.dialog.dart';
import 'package:fireport/pages/users.tab.dart';
import 'package:fireport/styles.dart';
import 'package:flutter/material.dart';

import 'newcluster.dialog.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _pageController = PageController();

  int _selectedItem = 0;

  _pageChange(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  _pageJump(index) async {
    _pageController.jumpToPage(index);
  }

  _openNewUser(BuildContext ctx) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return NewUserDialog(ctx);
      },
    );
  }

  _openNewCluster(BuildContext ctx) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return NewClusterDialog(ctx);
      },
    );
  }

  alertClosed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: Text('Admin area'),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).appBarTheme.color,
              items: [
                BottomNavigationBarItem(
                  title: const Text('Usuários'),
                  icon: const Icon(Icons.supervised_user_circle),
                ),
                BottomNavigationBarItem(
                  title: const Text('Estabelecimentos'),
                  icon: const Icon(Icons.store),
                ),
              ],
              onTap: _pageJump,
              currentIndex: _selectedItem,
            ),
            body: PageView(
              controller: _pageController,
              onPageChanged: _pageChange,
              physics: NeverScrollableScrollPhysics(),
              children: [
                UserTab(),
                ClusterTab(),
              ],
            ),
            floatingActionButton: _selectedItem == 0
                ? FloatingActionButton.extended(
                    icon: const Icon(Icons.person_add),
                    label: const Text('NOVO'),
                    backgroundColor: DraculaPalette.purple,
                    onPressed: () {
                      _openNewUser(context);
                    },
                  )
                : FloatingActionButton.extended(
                    icon: const Icon(Icons.add_box),
                    label: const Text('NOVO'),
                    backgroundColor: DraculaPalette.purple,
                    onPressed: () {
                      _openNewCluster(context);
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
