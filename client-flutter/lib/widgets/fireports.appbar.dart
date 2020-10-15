import 'package:fireport/auth/FireAuthRepo.dart';
import 'package:fireport/pages/admin.page.dart';
import 'package:flutter/material.dart';

class FireportAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  FireportAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title),
      actions: <Widget>[
        PopupMenuButton(
            itemBuilder: (_) => <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                      child: const Text('Administrador'), value: 'admin'),
                  PopupMenuItem<String>(
                      child: const Text('Sair'), value: 'exit'),
                ],
            onSelected: (String item) {
              if (item == 'exit') {
                FireAuthRepo.of(context).logout();
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => AdminPage()),
                  ),
                );
              }
            }),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
