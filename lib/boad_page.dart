import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:metagamer/current_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:metagamer/model/boad_model.dart';

import 'appbar.dart';
import 'bottom_nav.dart';

class BoadPage extends StatefulWidget {
  const BoadPage({Key? key}) : super(key: key);

  @override
  _BoadPageState createState() => _BoadPageState();
}

class _BoadPageState extends State<BoadPage> {
  DateTime pre_backpress = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    setRoute(5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            final snack = SnackBar(
                content: Text("한번더눌러서종료"), duration: Duration(seconds: 2));
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomAppbar(),
                Boad(),
                KeyboardVisibilityProvider(child: BottomNav())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Boad extends StatefulWidget {
  const Boad({Key? key}) : super(key: key);

  @override
  _BoadState createState() => _BoadState();
}

class _BoadState extends State<Boad> {
  HtmlEditorController controller = HtmlEditorController();
  final _auth = FirebaseAuth.instance;

  late List<File> files = List.empty();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    _uploadBoad();
                    // print(await controller.getText());
                  },
                  child: Text("저장")),
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
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      child: files.length == 0
                          ? Row()
                          : files.length == 1
                              ? ImageSet(files[0].path, () {})
                              : files.length == 2
                                  ? Row(
                                      children: [
                                        ImageSet(files[0].path, () {}),
                                        ImageSet(files[1].path, () {}),
                                      ],
                                    )
                                  : files.length == 3
                                      ? Row(
                                          children: [
                                            ImageSet(files[0].path, () {}),
                                            ImageSet(files[1].path, () {}),
                                            ImageSet(files[2].path, () {}),
                                          ],
                                        )
                                      : files.length == 4
                                          ? Row(
                                              children: [
                                                ImageSet(files[0].path, () {}),
                                                ImageSet(files[1].path, () {}),
                                                ImageSet(files[2].path, () {}),
                                                ImageSet(files[3].path, () {}),
                                              ],
                                            )
                                          : Row(),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      pickFile();
                      // _uploadBoad();
                    },
                    child: Text("add pic"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
      for (int i = 0; i < files.length; i++) {
        print(">>>: " + files[i].path);
        setState(() {});
        // try {
        //   Reference reference = FirebaseStorage.instance.ref("/testupload/");
        //   await reference.putFile(files[i]);
        //   String downloadUrl = await reference.getDownloadURL();
        //   print(">>>: " + downloadUrl);
        // } on FirebaseException catch (e) {
        //   return null;
        // }
      }
    } else {}
  }

  void _uploadBoad() async {
    String date = DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now());
    CollectionReference reference =
        await FirebaseFirestore.instance.collection("free_boad");
    String myNickName = await FirebaseFirestore.instance
        .collection("user")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => value.get('nickname'));
    print(myNickName);
    BoadModel model = BoadModel(
        time: date,
        uid: _auth.currentUser!.uid,
        nickname: myNickName,
        title: "제목",
        content: await controller.getText(),
        like: "0",
        view: "0");
    await reference.doc("test").set(model.toJson());
  }

  Widget ImageSet(String path, VoidCallback onPressed) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: Image(
            image: FileImage(File(path)),
          ),
        ),
        IconButton(
          onPressed: () {
            onPressed;
          },
          icon: Icon(Icons.cancel),
        )
      ],
    );
  }

// Future<String> uploadFile(var file, String filePath, String uploadPath) async {
//   try {
//     Reference reference = FirebaseStorage.instance.ref("/testupload/");
//     await reference.putFile(file);
//     String downloadUrl = await reference.getDownloadURL();
//     return downloadUrl;
//   } on FirebaseException catch (e) {
//     return '-1';
//   }
// }
}

class Boad1 extends StatefulWidget {
  const Boad1({Key? key}) : super(key: key);

  @override
  _Boad1State createState() => _Boad1State();
}

class _Boad1State extends State<Boad1> {
  HtmlEditorController controller = HtmlEditorController();

  String pp = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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

          // callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
          //   print('html before change is $currentHtml');
          // }, onChangeContent: (String? changed) {
          //   print('content changed to $changed');
          // }, onChangeCodeview: (String? changed) {
          //   print('code changed to $changed');
          // }, onChangeSelection: (EditorSettings settings) {
          //   print('parent element is ${settings.parentElement}');
          //   print('font name is ${settings.fontName}');
          // }, onDialogShown: () {
          //   print('dialog shown');
          // }, onEnter: () {
          //   print('enter/return pressed');
          // }, onFocus: () {
          //   print('editor focused');
          // }, onBlur: () {
          //   print('editor unfocused');
          // }, onBlurCodeview: () {
          //   print('codeview either focused or unfocused');
          // }, onInit: () {
          //   print('init');
          // },
          //     //this is commented because it overrides the default Summernote handlers
          //     /*onImageLinkInsert: (String? url) {
          //               print(url ?? "unknown url");
          //             },
          //             onImageUpload: (FileUpload file) async {
          //               print(file.name);
          //               print(file.size);
          //               print(file.type);
          //               print(file.base64);
          //             },*/
          //     onKeyDown: (int? keyCode) {
          //   print('$keyCode key downed');
          //   print('current character count: ${controller.characterCount}');
          // }, onKeyUp: (int? keyCode) {
          //   print('$keyCode key released');
          // }, onMouseDown: () {
          //   print('mouse downed');
          // }, onMouseUp: () {
          //   print('mouse released');
          // }, onNavigationRequestMobile: (String url) {
          //   print(url);
          //   return NavigationActionPolicy.ALLOW;
          // }, onPaste: () {
          //   print('pasted into editor');
          // }, onScroll: () {
          //   print('editor scrolled');
          // }),
          // plugins: [
          //   SummernoteAtMention(
          //       getSuggestionsMobile: (String value) {
          //         var mentions = <String>['test1', 'test2', 'test3'];
          //         return mentions
          //             .where((element) => element.contains(value))
          //             .toList();
          //       },
          //       mentionsWeb: ['test1', 'test2', 'test3'],
          //       onSelect: (String value) {
          //         print(value);
          //       }),
          // ],
        ),
        TextButton(
            onPressed: () async {
              print(await controller.getText());
            },
            child: Text("test"))
      ],
    );
  }
}

class BoadTest extends StatefulWidget {
  const BoadTest({Key? key}) : super(key: key);

  @override
  _BoadTestState createState() => _BoadTestState();
}

class _BoadTestState extends State<BoadTest> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        "https://firebasestorage.googleapis.com/v0/b/metagamer-8d6a1.appspot.com/o/testfolder%2Ftesthtml.html?alt=media&token=ac95f610-6e29-4918-bd2f-ea5ff52849b5")),
              ),
            ),
            SizedBox(
              height: 200,
              child: Html(
                data: testString + testString2,
              ),
            )
          ],
        ));
  }

  String testString = "<p>11문단입니다</p><p>22문단입니다</p>";
  String testString2 =
      '<img src = "https://firebasestorage.googleapis.com/v0/b/metagamer-8d6a1.appspot.com/o/dev%2Fdefaultprofileicon.png?alt=media&token=cee38d5d-48b1-4e85-bbe0-d3114c07959a"/>';
  var htmldata = """
    <p>1문단입니다</p>
    <p>2문단입니다</p>
  """;
}
