import 'package:fireport/auth/FireAuthRepo.dart';
import 'package:fireport/pages/clusters.page.dart';
import 'package:fireport/pages/login.page.dart';
import 'package:fireport/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: DraculaPalette.selection,
      statusBarBrightness: Brightness.dark,
    ),
  );
  return runApp(
    ScopedModel<FireAuthRepo>(
      child: FireportApp(),
      model: FireAuthRepo(),
    ),
  );
}

class FireportApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fireport sgmaster',
      theme: DraculaStyles.materialTheme,
      home: ScopedModelDescendant<FireAuthRepo>(
        builder: (c, w, m) {
          if (m.isAuth()) {
            return ClustersPage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
