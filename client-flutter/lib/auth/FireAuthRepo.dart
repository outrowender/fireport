import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

class FireAuthRepo extends Model {
  final auth = FirebaseAuth.instance;
  Map<String, dynamic> userData = Map();
  FirebaseUser firebaseUser;

  static FireAuthRepo of(BuildContext context) =>
      ScopedModel.of<FireAuthRepo>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  //pega o token do facebook e faz login no google
  // Future<FirebaseUser> loginWithGoogle() async {
  //   GoogleSignInAccount googleUser = await gSignIn.signIn();
  //   GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //   FirebaseUser user = await auth.signInWithGoogle(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   //print("signed in " + user.displayName);
  //   await _loadCurrentUser();
  //   return user;
  // }

  bool isAuth() {
    return this.firebaseUser != null;
  }

  //faz login com facebook
  Future<FirebaseUser> loginWithFacebook() {
    return null;
  }

  //login com email e senha
  Future<FirebaseUser> loginWithEmailAndPassword(
      String mail, String password) async {
    try {
      var user = await auth.signInWithEmailAndPassword(
          email: mail, password: password);
      await _loadCurrentUser();
      return user.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //logout
  Future logout() async {
    firebaseUser = null;
    userData = null;
    //await gSignIn.signOut();
    await auth.signOut();
    notifyListeners();
  }

  Future _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await auth.currentUser();
    if (firebaseUser != null) {
      if (userData == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }
}
