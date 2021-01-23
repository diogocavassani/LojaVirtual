import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier {
  List<User> users = [];
  final Firestore firestore = Firestore.instance;
  List<String> get names => users.map((e) => e.nome).toList();

  void updateUser(UserManager userManager) {
    if (userManager.adminEnabled) {
      _listenToUsers();
    } else {
      users.clear();
    }
  }

  void _listenToUsers() {
    firestore.collection('users').getDocuments().then((snapshot) {
      users = snapshot.documents.map((d) => User.fromDocument(d)).toList();
      users
          .sort((a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
      notifyListeners();
    });
  }
}
