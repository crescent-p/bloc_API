import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("users");

  //upload datetime
  Future<String> uploadDateTimes(String email, String? dateTime1,
      String? dateTime2, String? dateTime3) async {
    String retVal = "error";
    try {
      await _collectionReference.doc(email).set({
        'dateTime1': dateTime1,
        "dateTime2": dateTime2,
        "dateTime3": dateTime3,
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> uploadData(String email, double N, double P, double K) async {
    String retVal = "error";
    try {
      await _collectionReference.doc(email).set({
        'N': N,
        "P": P,
        "K": K,
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  //dowload npk values and soil moisture
  Stream<DocumentSnapshot> getDateTimes(String email) {
    return _collectionReference.doc(email).snapshots();
  }

  Future<void> updateDateTimes(String email, String? dateTime1,
      String? dateTime2, String? dateTime3) async {
    try {
      await _collectionReference.doc(email).update({
        'dateTime1': dateTime1,
        "dateTime2": dateTime2,
        "dateTime3": dateTime3,
      });
    } catch (e) {
      print(e);
    }
  }
  //download datetime
}
