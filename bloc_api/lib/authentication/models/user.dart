import 'package:firebase_auth/firebase_auth.dart';

class MyUser {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;

  MyUser({
    required this.displayName,
    required this.photoUrl,
    required this.uid,
    required this.email,
  });

  factory MyUser.fromMap(Map<String, dynamic> data) {
    // if (data == null) {
    //   return User;
    // }
    final String uid = data['uid'];
    final String email = data['email'];
    final String displayName = data['displayName'] ?? '';
    final String photoUrl = data['photoUrl'] ?? '';
    return MyUser(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

  factory MyUser.fromFirebaseUser(User user) {
    return MyUser(
      uid: user.uid,
      email: user.email!,
      displayName: user.displayName!,
      photoUrl: user.photoURL!,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }
}
