import 'dart:ffi';
import 'dart:io';
import 'dart:math';

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
import 'dialog/loader.dart';

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
                BoadTest(),
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
  TextEditingController titleController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  late List<File> files = List.empty();
  String picPath0 = "";
  String picPath1 = "";
  String picPath2 = "";
  String picPath3 = "";

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
                    // _uploadBoad();
                    // print(await controller.getText());
                    _uploadPic();
                    // await FirebaseStorage.instance.ref().child("testtest/").delete();
                    // await FirebaseStorage.instance.refFromURL("https://firebasestorage.googleapis.com/v0/b/metagamer-8d6a1.appspot.com/o/boad%2Ffree_boad%2FMffvHR0Lv7c0ikZTgoH7CbhvSK53_2022%2F01%2F01%2015%3A44%3A12%2F0?alt=media&token=826d491e-6b39-4a95-8a87-d689b9823403").delete();

                    if (titleController.text.length == 0) {
                    } else if (controller.getText().toString().length == 0) {
                    } else {}
                  },
                  child: Text("저장")),
              TextField(
                controller: titleController,
              ),
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
      if (files.length > 4) {
        //파일선택 4개이상 됨
      } else {
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
      }
    }
  }

  void _uploadPic() async {
    String myUid = await _auth.currentUser!.uid;
    String date = DateFormat('yyyyMMdd HH:mm:ss').format(DateTime.now());
    // Loader.showLoadingDialog(context);
    if (files.length != 0) {
      for (int i = 0; i < files.length; i++) {
        try {
          Reference reference = FirebaseStorage.instance.ref(
              "/boad/free_boad/" + myUid + "_" + date + "/" + i.toString());
          await reference.putFile(files[i]);
          String downloadUrl = await reference.getDownloadURL();
          if (i == 0) {
            picPath0 = '<div><img src = "' + downloadUrl + '"/></div>';
          } else if (i == 1) {
            picPath1 = '<div><img src = "' + downloadUrl + '"/></div>';
          } else if (i == 2) {
            picPath2 = '<div><img src = "' + downloadUrl + '"/></div>';
          } else if (i == 3) {
            picPath3 = '<div><img src = "' + downloadUrl + '"/></div>';
          }
          print(">>>: " + downloadUrl);
          _uploadBoad(myUid, date, myUid + "_" + date);
        } on FirebaseException catch (e) {
          print("인터넷 연결 안좋음: " + toString());
          //dialog 띄우기
          //이미 업로드 한 파일 있으면 지우기
        }
      }
    }
  }

  void _uploadBoad(String myUid, String date, docName) async {
    CollectionReference reference =
        await FirebaseFirestore.instance.collection("free_boad");
    String myNickName = await FirebaseFirestore.instance
        .collection("user")
        .doc(myUid)
        .get()
        .then((value) => value.get('nickname'));
    BoadModel model = BoadModel(
        time: date,
        uid: myUid,
        nickname: myNickName,
        title: titleController.text,
        content: await controller.getText() +
            picPath0 +
            picPath1 +
            picPath2 +
            picPath3,
        like: 0,
        view: 0);
    await reference
        .doc(docName)
        .set(model.toJson())
        .catchError((e) => print("laskdjf")); //upload firestore.
    //에러시 업로드 했던 storage 파일 지우기
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
            // SizedBox(
            //   height: 200,
            //   child: InAppWebView(
            //     initialUrlRequest: URLRequest(
            //         url: Uri.parse(
            //             "https://firebasestorage.googleapis.com/v0/b/metagamer-8d6a1.appspot.com/o/testfolder%2Ftesthtml.html?alt=media&token=ac95f610-6e29-4918-bd2f-ea5ff52849b5")),
            //   ),
            // ),
            SizedBox(
              height: 500,
              child: Html(
                data:
                    '<p>ㅏ탙햫</p><p>ㅐ해햏</p><div><img src = "https://firebasestorage.googleapis.com/v0/b/metagamer-8d6a1.appspot.com/o/boad%2Ffree_boad%2FMffvHR0Lv7c0ikZTgoH7CbhvSK53_20220101%2015%3A58%3A05%2F0?alt=media&token=b49105ed-2932-4825-a91c-5097fbc5feb4"/></div><div><img src = "https://firebasestorage.googleapis.com/v0/b/metagamer-8d6a1.appspot.com/o/boad%2Ffree_boad%2FMffvHR0Lv7c0ikZTgoH7CbhvSK53_20220101%2015%3A58%3A03%2F1?alt=media&token=2a8720b6-5c67-4ec1-bddc-6cc9205b8470"/></div>',
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
