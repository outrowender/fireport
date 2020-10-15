import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireport/services/util.dart';
import 'package:fireport/styles.dart';
import 'package:fireport/widgets/form.widgets.dart';
import 'package:flutter/material.dart';

class NewClusterDialog extends StatefulWidget {
  BuildContext ctx;

  NewClusterDialog(this.ctx);

  @override
  _NewClusterDialogState createState() => _NewClusterDialogState(this.ctx);
}

class _NewClusterDialogState extends State<NewClusterDialog> {
  BuildContext ctx;
  _NewClusterDialogState(this.ctx);
  final nomeController = TextEditingController();
  final detalheController = TextEditingController();

  salvar() {
    var nome = nomeController.text;
    var detalhe = detalheController.text;

    Firestore.instance.collection('clusters').add({
      'd': detalhe,
      'n': nome,
      'a': false,
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
      title: const Text('Novo estabelecimento'),
      content: Container(
        height: 150,
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
              label: 'Detalhe',
              inputType: TextInputType.emailAddress,
              controller: detalheController,
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
