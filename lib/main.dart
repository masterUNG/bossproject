import 'package:bossproject/models/typeuser_model.dart';
import 'package:bossproject/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String initialRoute = '/authen';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        String uid = event.uid;
        await FirebaseFirestore.instance
            .collection('typeuser')
            .doc(uid)
            .snapshots()
            .listen((event) {
          TypeUserModel model = TypeUserModel.fromMap(event.data());
          switch (model.typeuser) {
            case 'Student':
              initialRoute = '/myServiceStudent';
              break;
            case 'Teacher':
              initialRoute = '/myServiceTeacher';
              break;
            default:
          }
          runApp(MyApp());
        });
      } else {
        runApp(MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initialRoute,
    );
  }
}
