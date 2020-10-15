import 'package:fireport/auth/FireAuthRepo.dart';
import 'package:fireport/widgets/form.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers de input
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _fieldChanged(String text) {
    //print(text);
  }

  void _emailLogin(String email, String password) async {
    var auth = FireAuthRepo.of(context);

    var user = await auth.loginWithEmailAndPassword(email, password);

    print(user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //campo de email
              MaterialFormWidgets.textField(
                label: "Email",
                inputType: TextInputType.emailAddress,
                controller: emailController,
                isPassword: false,
                callback: _fieldChanged,
              ),
              //campo de senha
              MaterialFormWidgets.textField(
                label: "Senha",
                inputType: TextInputType.text,
                controller: passwordController,
                isPassword: true,
                callback: _fieldChanged,
              ),
              //campo de lembrar senha
              MaterialFormWidgets.checkbox('Lembrar senha'),
              //botao de login
              RaisedButton(
                child: Text('Entrar'),
                onPressed: () {
                  var email = emailController.text;
                  var password = passwordController.text;
                  _emailLogin(email, password);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
