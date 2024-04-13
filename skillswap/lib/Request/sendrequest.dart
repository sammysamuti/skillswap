import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:skillswap/Request/requestTemplate.dart';

class RequestSend extends ChangeNotifier {
  final FirebaseAuth _authentication = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> sendrequest(String recieverid, String projectid, String message,
      Map<String, dynamic> userdata, String title,List<String> skill) async {
    final String senderid = _authentication.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();
    RequestTemp newrequest = RequestTemp(
        sendId: senderid,
        receiverId: recieverid,
        projectid: projectid,
        message: message,
        timestamp: timestamp,
        skills: skill,
        userdata: userdata,
        projectTitle: title
        );
    await _firestore
        .collection("Requests")
        .doc(recieverid)
        .collection('messages')
        .add(newrequest.tomap());
  }

  // read from db

  Stream<QuerySnapshot> getrequest(String recieverid) {
    return _firestore
        .collection("Requests")
        .doc(recieverid)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }


}
