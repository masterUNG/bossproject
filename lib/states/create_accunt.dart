import 'package:bossproject/models/typeuser_model.dart';
import 'package:bossproject/utility/dialog.dart';
import 'package:bossproject/utility/my_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String name, email, password, typeuser;

  Container buildName() {
    return Container(
      decoration: MyStyle().bgText(),
      margin: EdgeInsets.only(top: 64),
      width: 250,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.perm_identity),
          hintText: 'Display Name :',
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildEmail() {
    return Container(
      decoration: MyStyle().bgText(),
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => email = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email_outlined),
          hintText: 'Email :',
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
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline),
          hintText: 'Password :',
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().bgColor,
        title: Text('Create Account'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildName(),
              buildTypeUser(),
              buildEmail(),
              buildPassword(),
              buildCreateAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTypeUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          child: RadioListTile(
            title: Text('Student'),
            value: 'Student',
            groupValue: typeuser,
            onChanged: (value) {
              setState(() {
                typeuser = value;
              });
            },
          ),
        ),
        Container(
          width: 150,
          child: RadioListTile(
            title: Text('Teacher'),
            value: 'Teacher',
            groupValue: typeuser,
            onChanged: (value) {
              setState(() {
                typeuser = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Container buildCreateAccount() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: ElevatedButton(
        style: MyStyle().buttonStyle(),
        onPressed: () {
          if ((name?.isEmpty ?? true) ||
              (email?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ?', 'Please Fill Every Blank');
          } else if (typeuser?.isEmpty ?? true) {
            normalDialog(
                context, 'Non Choose Type ?', 'Please Choose Type User');
          } else {
            registerAndInsertData();
          }
        },
        child: Text('Create Account'),
      ),
    );
  }

  Future<Null> registerAndInsertData() async {
    print(
        'name= $name, typeuser = $typeuser, email = $email, password = $password');
    await Firebase.initializeApp().then((value) async {
      print('Initialize Success');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        String uid = value.user.uid;
        print('Register Success uid = $uid');
        await value.user.updateProfile(displayName: name).then((value) async {
          TypeUserModel model =
              TypeUserModel(email: email, name: name, typeuser: typeuser);
          Map<String, dynamic> data = model.toMap();
          await FirebaseFirestore.instance
              .collection('typeuser')
              .doc(uid)
              .set(data)
              .then((value) {
            switch (typeuser) {
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
        });
      }).catchError((onError) =>
              normalDialog(context, onError.code, onError.message));
    });
  }
}
