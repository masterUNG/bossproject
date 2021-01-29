import 'dart:io';

import 'package:bossproject/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostTeacher extends StatefulWidget {
  @override
  _AddPostTeacherState createState() => _AddPostTeacherState();
}

class _AddPostTeacherState extends State<AddPostTeacher> {
  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().bgColor,
        title: Text('Add Post'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildRowImage(context),
            buildPost(),
            buildBottonPost(),
          ],
        ),
      ),
    );
  }

  Container buildBottonPost() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: MyStyle().buttonStyle(),
            onPressed: () {},
            child: Text('Post'),
          ),
        ],
      ),
    );
  }

  Container buildPost() {
    return Container(
      decoration: MyStyle().bgText(),
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        maxLines: 4,
        onChanged: (value) {},
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
            child: Icon(Icons.post_add),
          ),
          hintText: 'Post :',
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<Null> chooseImageSource(ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result.path);
      });
    } catch (e) {}
  }

  Row buildRowImage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: Icon(
              Icons.add_a_photo,
              size: 48,
            ),
            onPressed: () => chooseImageSource(ImageSource.camera)),
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: file == null ? Image.asset('images/image.png') : Image.file(file) ,
        ),
        IconButton(
            icon: Icon(
              Icons.add_photo_alternate,
              size: 48,
            ),
            onPressed: () => chooseImageSource(ImageSource.gallery)),
      ],
    );
  }
}
