import 'package:bossproject/utility/my_style.dart';
import 'package:bossproject/widget/list_post.dart';
import 'package:bossproject/widget/search.dart';
import 'package:bossproject/widget/show_calendar.dart';
import 'package:bossproject/widget/show_notification.dart';
import 'package:bossproject/widget/show_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyServiceTeacher extends StatefulWidget {
  @override
  _MyServiceTeacherState createState() => _MyServiceTeacherState();
}

class _MyServiceTeacherState extends State<MyServiceTeacher> {
  String name, email;
  List<Widget> widgets = [
    ListPost(),
    Search(),
    ShowCalendar(),
    ShowNotification(),
    ShowProfile()
  ];

  int index = 0;

  List<BottomNavigationBarItem> bottomNavigationBarItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Post'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today), label: 'Calendar'),
      BottomNavigationBarItem(
          icon: Icon(Icons.notification_important), label: 'Noti'),
      BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Profile'),
    ].toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readFirebase();
    bottomNavigationBarItems();
  }

  Future<Null> readFirebase() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event.displayName;
          email = event.email;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().bgColor,
        title: Text('Teacher'),
      ),
      drawer: buildDrawer(context),
      body: widgets[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationBarItems(),
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [buildUserAccountsDrawerHeader(), buildListTilePost()],
          ),
          MyStyle().buildSignOut(context),
        ],
      ),
    );
  }

  ListTile buildListTilePost() {
    return ListTile(
      leading: Icon(Icons.post_add),
      title: Text('Post'),
      subtitle: Text('Post Message and Add Post'),
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/teacher.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      accountName: name == null ? Text('Name ?') : Text(name),
      accountEmail: email == null ? Text('Email ?') : Text(email),
    );
  }
}
