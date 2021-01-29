import 'package:bossproject/models/typeuser_model.dart';
import 'package:bossproject/utility/dialog.dart';
import 'package:bossproject/utility/my_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 50,
              ),
              Text('No Acount ?'),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/createAccount');
                },
                child: Text('Create Account'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wall.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildLogo(),
              buildAppName(),
              buildUser(),
              buildPassword(),
              buildLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: ElevatedButton(
        style: MyStyle().buttonStyle(),
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ?', 'Please Fill Every Blank');
          } else {
            checkAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Container buildUser() {
    return Container(
      decoration: MyStyle().bgText(),
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.perm_identity),
          hintText: 'User :',
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: MyStyle().bgText(),
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_open_outlined),
          hintText: 'Password :',
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildAppName() => MyStyle().titleH1('Boss Project');

  Container buildLogo() {
    return Container(
      width: 120,
      child: MyStyle().showLogo(),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        String uid = value.user.uid;
        await FirebaseFirestore.instance
            .collection('typeuser')
            .doc(uid)
            .snapshots()
            .listen((event) {
          TypeUserModel model = TypeUserModel.fromMap(event.data());
          switch (model.typeuser) {
            case 'Student':
              Navigator.pushNamedAndRemoveUntil(
                  context, '/myServiceStudent', (route) => false);
              break;
              case 'Teacher':
              Navigator.pushNamedAndRemoveUntil(
                  context, '/myServiceTeacher', (route) => false);
              break;
            default:
          }
        });
      }).catchError((onError) =>
              normalDialog(context, onError.code, onError.message));
    });
  }
}
