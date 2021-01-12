import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Nome completo'),
                        enabled: !userManager.loading,
                        validator: (name) {
                          if (name.isEmpty) {
                            return 'Campo Obrigatório';
                          } else if (name.trim().split(' ').length <= 1) {
                            return 'Preencha seu nome completo';
                          }
                          return null;
                        },
                        onSaved: (name) => user.nome = name,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(hintText: 'E-mail'),
                        enabled: !userManager.loading,
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email.isEmpty) {
                            return 'Campo Obrigatório';
                          } else if (!emailValid(email)) {
                            return 'E-mail inválido';
                          }
                          return null;
                        },
                        onSaved: (email) => user.email = email,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(hintText: 'Senha'),
                        enabled: !userManager.loading,
                        obscureText: true,
                        autocorrect: false,
                        validator: (pass) {
                          if (pass.isEmpty) {
                            return 'Campo Obrigatório';
                          } else if (pass.length < 6) {
                            return 'Senha muito curta';
                          }
                          return null;
                        },
                        onSaved: (pass) => user.pass = pass,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Repita a senha'),
                        enabled: !userManager.loading,
                        obscureText: true,
                        autocorrect: false,
                        validator: (pass) {
                          if (pass.isEmpty) {
                            return 'Campo Obrigatório';
                          } else if (pass.length < 6) {
                            return 'Senha muito curta';
                          }
                          return null;
                        },
                        onSaved: (confirmPass) =>
                            user.confirmPass = confirmPass,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 44,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  formKey.currentState.validate();
                                  formKey.currentState.save();
                                  if (user.pass != user.confirmPass) {
                                    scaffoldKey.currentState.showSnackBar(
                                      const SnackBar(
                                        content: Text('Senha diferentes'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }
                                  userManager.signUp(
                                    user: user,
                                    onSuccess: () {
                                      debugPrint('Sucesso');
                                      Navigator.of(context).pop();
                                    },
                                    onFail: (e) {
                                      debugPrint(e.toString());
                                      scaffoldKey.currentState.showSnackBar(
                                        const SnackBar(
                                          content: Text('Cadastro incorreto'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                  );
                                },
                          child: userManager.loading
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text(
                                  'Criar Conta',
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      )
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
