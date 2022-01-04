import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:metagamer/dialog/loader.dart';

import 'model/boad_model.dart';

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
  String picPath4 = "";

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
                    hint: "내용을 입력하세요..",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("(" + files.length.toString() + "/5)"),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigoAccent[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                      onPressed: () {
                        pickFile();
                      },
                      child: Row(
                        children: [Icon(Icons.photo), Text("사진첨부")],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                          child: files.length == 0
                              ? Row()
                              : files.length == 1
                                  ? ImageSet(files[0].path, () {
                                      setState(() {
                                        files.remove(files[0]);
                                      });
                                    })
                                  : files.length == 2
                                      ? Row(
                                          children: [
                                            ImageSet(files[0].path, () {
                                              setState(() {
                                                files.remove(files[0]);
                                              });
                                            }),
                                            ImageSet(files[1].path, () {
                                              setState(() {
                                                files.remove(files[1]);
                                              });
                                            }),
                                          ],
                                        )
                                      : files.length == 3
                                          ? Row(
                                              children: [
                                                ImageSet(files[0].path, () {
                                                  setState(() {
                                                    files.remove(files[0]);
                                                  });
                                                }),
                                                ImageSet(files[1].path, () {
                                                  setState(() {
                                                    files.remove(files[1]);
                                                  });
                                                }),
                                                ImageSet(files[2].path, () {
                                                  setState(() {
                                                    files.remove(files[2]);
                                                  });
                                                }),
                                              ],
                                            )
                                          : files.length == 4
                                              ? Row(
                                                  children: [
                                                    ImageSet(files[0].path, () {
                                                      setState(() {
                                                        files.remove(files[0]);
                                                      });
                                                    }),
                                                    ImageSet(files[1].path, () {
                                                      setState(() {
                                                        files.remove(files[1]);
                                                      });
                                                    }),
                                                    ImageSet(files[2].path, () {
                                                      setState(() {
                                                        files.remove(files[2]);
                                                      });
                                                    }),
                                                    ImageSet(files[3].path, () {
                                                      setState(() {
                                                        files.remove(files[3]);
                                                      });
                                                    }),
                                                  ],
                                                )
                                              : files.length == 5
                                                  ? Row(
                                                      children: [
                                                        ImageSet(files[0].path,
                                                            () {
                                                          setState(() {
                                                            files.remove(
                                                                files[0]);
                                                          });
                                                        }),
                                                        ImageSet(files[1].path,
                                                            () {
                                                          setState(() {
                                                            files.remove(
                                                                files[1]);
                                                          });
                                                        }),
                                                        ImageSet(files[2].path,
                                                            () {
                                                          setState(() {
                                                            files.remove(
                                                                files[2]);
                                                          });
                                                        }),
                                                        ImageSet(files[3].path,
                                                            () {
                                                          setState(() {
                                                            files.remove(
                                                                files[3]);
                                                          });
                                                        }),
                                                        ImageSet(files[4].path,
                                                            () {
                                                          setState(() {
                                                            files.remove(
                                                                files[4]);
                                                          });
                                                        }),
                                                      ],
                                                    )
                                                  : Row()),
                    ),
                  ],
                ),
                SizedBox(height: files.length != 0 ? 10.0 : 30.0),
                Text("사진은 ????KB이하 파일 5개 까지 첨부 가능합니다.",
                    style: TextStyle(color: Colors.grey)),
                SizedBox(height: 10.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0))),
                  onPressed: () {
                    _uploadPic(getBoadName(widget.category));
                  },
                  child: Text("등록"),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0))),
                  onPressed: () {
                    _deleteFile();
                  },
                  child: Text("test"),
                ),
              ],
            ),
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
      if (files.length > 5) {
        //파일선택 5개이상 됨
        files.clear();
        setState(() {});
      } else {
        setState(() {});
      }
    }
  }

  void _deleteFile() async {
    Reference reference = await FirebaseStorage.instance.refFromURL(
        "https://firebasestorage.googleapis.com/v0/b/metagamer-8d6a1.appspot.com/o/testfolder%2FKakaoTalk_20211201_111928654.jpg?alt=media&token=77436f0b-c8e3-42f5-9fb3-2c93afed2766");
    await reference.delete();
  }

  void _uploadPic(String boadName) async {
    Loader.showLoadingDialog(context);
    List<String> downloadUrls = [];
    int count = 0;
    String errorToString = "";
    bool isError = false;
    bool isHavePic = false;
    String myUid = await _auth.currentUser!.uid;
    String date = DateFormat('yyyyMMdd HH:mm:ss').format(DateTime.now());
    // Loader.showLoadingDialog(context);
    if (files.length != 0) {
      isHavePic = true;
      for (int i = 0; i < files.length; i++) {
        count++;
        try {
          Reference reference = FirebaseStorage.instance.ref("/boad/" +
              boadName +
              "/" +
              myUid +
              "_" +
              date +
              "/" +
              i.toString());
          await reference.putFile(files[i]);
          String downloadUrl = await reference.getDownloadURL();
          downloadUrls.add(downloadUrl);
          if (i == 0) {
            picPath0 = '<div><img src = "' + downloadUrl + '"/></div>';
          } else if (i == 1) {
            picPath1 = '<div><img src = "' + downloadUrl + '"/></div>';
          } else if (i == 2) {
            picPath2 = '<div><img src = "' + downloadUrl + '"/></div>';
          } else if (i == 3) {
            picPath3 = '<div><img src = "' + downloadUrl + '"/></div>';
          } else if (i == 4) {
            picPath4 = '<div><img src = "' + downloadUrl + '"/></div>';
          }
          print(">>>: " + downloadUrl);
        } on FirebaseException catch (e) {
          isError = true;
          errorToString = e.toString();
        }
      }
      _uploadBoad(boadName, myUid, date, myUid + "_" + date, isError,
          downloadUrls, isHavePic, errorToString);
    } else {
      _uploadBoad(boadName, myUid, date, myUid + "_" + date, isError,
          downloadUrls, isHavePic, errorToString);
    }
  }

  void _uploadBoad(
      String boadName,
      String myUid,
      String date,
      docName,
      bool isError,
      List<String> downloadUrls,
      bool isHavePic,
      String errorToString) async {
    if (isHavePic && isError) {
      for (int i = 0; i < downloadUrls.length; i++) {
        Reference reference =
            await FirebaseStorage.instance.refFromURL(downloadUrls[i]);
        reference.delete();
        ErrorDialog(errorToString);
      }
      Loader.closeLoadingDialog();
    } else {
      bool isStoreError = false;
      CollectionReference reference =
          await FirebaseFirestore.instance.collection(boadName);
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
              picPath3 +
              picPath4,
          like: 0,
          view: 0,
          comment: 0);
      await reference.doc(docName).set(model.toJson()).catchError(
        (e) async {
          isStoreError = true;
          await FirebaseFirestore.instance
              .collection(boadName)
              .doc(docName)
              .delete();
          for (int i = 0; i < downloadUrls.length; i++) {
            Reference reference =
                await FirebaseStorage.instance.refFromURL(downloadUrls[i]);
            reference.delete();
          }
          ErrorDialog(e.toString());
        },
      );
      Loader.closeLoadingDialog();
      if (!isStoreError) {
        Navigator.pop(context);
      }
    }
  }

  Widget ImageSet(String path, VoidCallback onPressed) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Image(
            image: FileImage(File(path)),
          ),
        ),
        IconButton(
          onPressed: () {
            onPressed();
          },
          icon: Icon(Icons.cancel, color: Colors.grey[600]),
        )
      ],
    );
  }

  String getBoadName(int pageNum) {
    if (pageNum == 0) {
      return 'main';
    } else if (pageNum == 1) {
      return 'free_boad';
    } else if (pageNum == 2) {
      return 'sad_boad';
    } else if (pageNum == 3) {
      return 'bomb_boad';
    } else if (pageNum == 4) {
      return 'bnbh_boad';
    } else if (pageNum == 5) {
      return 'hicat_boad';
    } else if (pageNum == 6) {
      return 'agian_boad';
    } else {
      return '';
    }
  }

  void ErrorDialog(String errorToString) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text("실패"),
            content: Column(
              children: [
                Text("오류로 인해 글등록에 실패했습니다."),
                Text("error: "),
                Text(errorToString)
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("확인"),
              ),
            ],
          );
        });
  }
}
