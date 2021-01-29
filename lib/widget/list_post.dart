import 'package:flutter/material.dart';

class ListPost extends StatefulWidget {
  @override
  _ListPostState createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              icon: Icon(
                Icons.add_circle,
                size: 36,
              ),
              onPressed: ()=> Navigator.pushNamed(context, '/addPostTeacher')),
          IconButton(
              icon: Icon(
                Icons.chat_bubble,
                size: 36,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }
}
