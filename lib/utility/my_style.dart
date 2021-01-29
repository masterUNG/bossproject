import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyStyle {
  Color bgColor = Colors.green.shade800;

  Column buildSignOut(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then(
                    (value) => Navigator.pushNamedAndRemoveUntil(
                        context, '/authen', (route) => false),
                  );
            });
          },
          tileColor: Colors.red.shade700,
          leading: Icon(
            Icons.exit_to_app,
            size: 36,
            color: Colors.white,
          ),
          title: Text(
            'Sign Out',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  ButtonStyle buttonStyle() => ElevatedButton.styleFrom(
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        onPrimary: Colors.orange.shade900,
        primary: Colors.greenAccent[400],
      );

  Decoration bgText() => BoxDecoration(color: Colors.white38);

  Widget showLogo() => Image.asset('images/logo.png');

  Widget titleH1(String string) => Container(
        margin: EdgeInsets.only(top: 16),
        child: Text(
          string,
          style: TextStyle(
            fontSize: 30,
            color: Colors.lime.shade200,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      );

  MyStyle();
}
