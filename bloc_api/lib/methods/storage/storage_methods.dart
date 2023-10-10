import 'dart:io';
import 'package:bloc_api/database/database_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sqflite/sqflite.dart';

Future<void> uploadCSVToFirebaseStorage(File result) async {
  final user = FirebaseAuth.instance.currentUser;
  Reference storageReference =
      FirebaseStorage.instance.ref('users').child(user!.uid);
  UploadTask uploadTask = storageReference.putFile(File(result.path));

  await uploadTask
      .whenComplete(() => print('CSV uploaded to Firebase Storage'));
}

DatabaseMethods database = DatabaseMethods.instance;



Future<String> getDatabasePath(String dbName) async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, dbName);
  return path;
}

String join(String databasesPath, String dbName) {
  return databasesPath + dbName;
}
