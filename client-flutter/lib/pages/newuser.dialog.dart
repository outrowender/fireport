import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireport/services/util.dart';
import 'package:fireport/widgets/form.widgets.dart';
import 'package:flutter/material.dart';

class NewUserDialog extends StatefulWidget {
  BuildContext ctx;

  NewUserDialog(this.ctx);

  @override
  _NewUserDialogState createState() => _NewUserDialogState(this.ctx);
}

class _NewUserDialogState extends State<NewUserDialog> {
  BuildContext ctx;
  _NewUserDialogState(this.ctx);
  final emailController = TextEditingController();
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();

  salvar() {
    var email = emailController.text;
    var nome = nomeController.text;
    var senha = senhaController.text;

    Firestore.instance.collection('users').add({
      'e': email,
      'n': nome,
      'p': senha,
    });

    sair('Usuário adicionado!');
  }

  sair(String message) {
    Navigator.of(context).pop();
    Util.showMessage(ctx: context, message: message, callbackOK: () {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      title: const Text('Adicionar usuário'),
      content: Container(
        height: 250,
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialFormWidgets.textField(
              label: 'Nome',
              inputType: TextInputType.emailAddress,
              controller: nomeController,
              isPassword: false,
              callback: null,
            ),
            MaterialFormWidgets.textField(
              label: 'Email',
              inputType: TextInputType.emailAddress,
              controller: emailController,
              isPassword: false,
              callback: null,
            ),
            MaterialFormWidgets.textField(
              label: 'Senha',
              inputType: TextInputType.emailAddress,
              controller: senhaController,
              isPassword: false,
              callback: null,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('SALVAR'),
          onPressed: () {
            salvar();
          },
        ),
      ],
    );
  }
}
