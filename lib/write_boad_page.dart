import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class WriteBoadPage extends StatefulWidget {
  final int category;

  const WriteBoadPage({Key? key, required this.category}) : super(key: key);

  @override
  _WriteBoadPageState createState() => _WriteBoadPageState();
}

class _WriteBoadPageState extends State<WriteBoadPage> {
  HtmlEditorController controller = HtmlEditorController();
  TextEditingController titleController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  List<String> categoryList = [
    "게시판선택",
    "자유게시판",
    "사드게시판",
    "붐크게시판",
    "히엠게시판",
    "히캣게시판",
    "또게시판"
  ];
  late List<File> files = List.empty();
  String picPath0 = "";
  String picPath1 = "";
  String picPath2 = "";
  String picPath3 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Column(
              children: [
                DropdownButton(
                  value: categoryList[widget.category].toString(),
                  items: categoryList.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                TextField(controller: titleController),
                HtmlEditor(
                  controller: controller,
                  htmlEditorOptions: HtmlEditorOptions(
                    hint: "Your text here...",
                  ),
                  htmlToolbarOptions: HtmlToolbarOptions(
                    defaultToolbarButtons: [
                      FontButtons(),
                      ColorButtons(),
                      InsertButtons(
                          video: false,
                          audio: false,
                          table: false,
                          hr: false,
                          otherFile: false)
                    ],
                    mediaUploadInterceptor:
                        (PlatformFile file, InsertFileType type) async {
                      print(file.name); //filename
                      print(file.size); //size in bytes
                      print(file.extension); //file extension (eg jpeg or mp4)
                      return true;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
