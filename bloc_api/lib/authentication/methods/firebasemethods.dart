// import 'package:bloc_api/authentication/models/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseMethods {
//   MyUser? user;

//   Future<String> signUpWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       User? person = userCredential.user;
//       return person!.uid;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         return 'The password provided is too weak.';
//       } else if (e.code == 'email-already-in-use') {
//         return 'The account already exists for that email.';
//       }
//     } catch (e) {
//       return e.toString();
//     }
//     return 'success';
//   } 



//   Future<MyUser?> signInWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       User? person =  userCredential.user;
//       return MyUser(displayName: person == null ? '' : person.displayName, email: person.email, photoUrl: '', uid: );
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       }
//     }
//     return null;
//   }
// }
