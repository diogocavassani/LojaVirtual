import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({this.id, this.email, this.pass, this.nome});

  User.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    nome = document.data['name'] as String;
    email = document.data['email'] as String;
  }
  String id;
  String nome;
  String email;
  String pass;
  String confirmPass;
  bool admn = false;

  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');
  CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': nome,
      'email': email,
    };
  }
}
