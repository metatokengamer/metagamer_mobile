import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:metagamer/loader.dart';
import 'package:metagamer/model/first_login_model.dart';

import '../appbar.dart';
import '../bottom_nav.dart';
import '../current_route.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  void initState() {
    // TODO: implement initState
    setRoute(4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                child: CustomAppbar(),
                top: 0,
                right: 0,
                left: 0,
              ),
              Center(child: KeyboardVisibilityProvider(child: EditSignUp())),
              Positioned(
                child: KeyboardVisibilityProvider(child: BottomNav()),
                bottom: 0,
                right: 0,
                left: 0,
              ),
            ],
          ),
        ),
        onWillPop: () {
          currentRoute = CurrentRoute.login;
          return Future.value(true);
        },
      ),
    );
  }
}

class EditSignUp extends StatefulWidget {
  const EditSignUp({Key? key}) : super(key: key);

  @override
  _EditSignUpState createState() => _EditSignUpState();
}

class _EditSignUpState extends State<EditSignUp> {
  bool isGoogleLoginPage = true;

  final _auth = FirebaseAuth.instance;

  TextEditingController nickname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    return Padding(
      padding:
          // isKeyboardVisible ? EdgeInsets.only(top: 70.0) : EdgeInsets.all(0.0),
      isKeyboardVisible ? EdgeInsets.only(top: 70.0) : EdgeInsets.symmetric(vertical: 70.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                          color: Colors.grey)
                    ]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isGoogleLoginPage = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text("Google 가입",
                                  style: TextStyle(
                                      fontWeight: isGoogleLoginPage
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      fontSize: 17.0)),
                              SizedBox(height: 3.0),
                              isGoogleLoginPage
                                  ? Container(
                                      height: 3,
                                      width: 90,
                                      color: Colors.orangeAccent,
                                    )
                                  : Container(
                                      height: 3,
                                      width: 90,
                                      color: Colors.transparent,
                                    )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isGoogleLoginPage = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text("Email 가입",
                                  style: TextStyle(
                                      fontWeight: !isGoogleLoginPage
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      fontSize: 17.0)),
                              SizedBox(height: 3.0),
                              !isGoogleLoginPage
                                  ? Container(
                                      height: 3,
                                      width: 90,
                                      color: Colors.orangeAccent,
                                    )
                                  : Container(
                                      height: 3,
                                      width: 90,
                                      color: Colors.transparent,
                                    )
                            ],
                          ),
                        )
                      ],
                    ),
                    isGoogleLoginPage ? SignUpGoogle() : SignUpEmail()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpGoogle extends StatefulWidget {
  const SignUpGoogle({Key? key}) : super(key: key);

  @override
  _SignUpGoogleState createState() => _SignUpGoogleState();
}

class _SignUpGoogleState extends State<SignUpGoogle> {
  final _auth = FirebaseAuth.instance;
  TextEditingController nickname = TextEditingController();
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  bool isAccept = true;

  int nicknamenum = 1;
  Widget nicknamegood = Text("완료", style: TextStyle(color: Colors.transparent));
  Widget nicknamenohave =
      Text("닉네임을 입력해주세요.", style: TextStyle(color: Colors.red));
  Widget nicknameunder2 =
      Text("2자리보다 적습니다.", style: TextStyle(color: Colors.red));
  Widget nicknamemore10 =
      Text("10자리를 초과합니다.", style: TextStyle(color: Colors.red));
  Widget nicknamenogood =
      Text("올바른 닉네임을 입력해주세요.", style: TextStyle(color: Colors.red));
  Widget nicknamespecial =
      Text("특수문자는 사용할 수 없습니다.", style: TextStyle(color: Colors.red));
  Widget nicknamespacebar =
      Text("공백이 포함될 수 없습니다.", style: TextStyle(color: Colors.red));

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,

      child: Column(
        children: [
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 35.0,
                      child: Checkbox(
                          value: isChecked1,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked1 = value!;
                              isChecked2 = value;
                              isChecked3 = value;
                              if (value == true) {
                                isAccept = true;
                              }
                            });
                          })),
                  Text("전체 동의")
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 35.0,
                      child: Checkbox(
                          value: isChecked2,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked2 = value!;
                              if (isChecked2 && isChecked3) {
                                isAccept = true;
                              } else if (!isChecked2 || !isChecked3) {
                                isChecked1 = false;
                              }
                            });
                          })),
                  Text("[필수] Meta Gamer 이용약관")
                ],
              ),
              SizedBox(
                  height: 35.0,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "보기",
                        style: TextStyle(decoration: TextDecoration.underline),
                      )))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 35.0,
                      child: Checkbox(
                          value: isChecked3,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked3 = value!;
                              if (isChecked2 && isChecked3) {
                                isAccept = true;
                              } else if (!isChecked2 || !isChecked3) {
                                isChecked1 = false;
                              }
                            });
                          })),
                  Text("[필수] 개인정보수집 및 이용 동의")
                ],
              ),
              SizedBox(
                  height: 35.0,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "보기",
                        style: TextStyle(decoration: TextDecoration.underline),
                      )))
            ],
          ),
          SizedBox(height: 5.0),
          Text("약관 동의 후 가입이 가능합니다.",
              style:
                  TextStyle(color: isAccept ? Colors.transparent : Colors.red)),
          SizedBox(height: 8.0),
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          SizedBox(height: 15.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (text) {
                  if (text.length >= 2 && text.length <= 10) {
                    setState(() {
                      nicknamenum = 1;
                    });
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigoAccent),
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    hintText: "닉네임",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.all(10.0)),
                controller: nickname,
                autofocus: false,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 7.0),
                    child: Text("2~10자리 한글, 영문, 숫자만 가능합니다.",
                        style: TextStyle(color: Colors.black54)),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 4.0),
                    child: nicknamenum == 1
                        ? nicknamegood
                        : nicknamenum == 2
                            ? nicknamenohave
                            : nicknamenum == 3
                                ? nicknameunder2
                                : nicknamenum == 4
                                    ? nicknamemore10
                                    : nicknamenum == 5
                                        ? nicknamenogood
                                        : nicknamenum == 6
                                            ? nicknamespecial
                                            : nicknamespacebar,
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              ButtonTheme(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0))),
                    onPressed: () async {
                      // if (nickname.text.length < 2 && nickname.text.length > 9 && nickname.text.contains(".*[ㄱ-ㅎ ㅏ-ㅣ]+.*")) {
                      //   // setState(() {
                      //   //   textColor = Colors.red;
                      //   // });
                      //   print("오류" + nickname.text);
                      // } else {
                      //   print("정상" + nickname.text);
                      //   // setState(() {
                      //   //   textColor = Colors.grey[100];
                      //   // });
                      //   // signInWithGoogle(); //가입, 로그인
                      // }

                      if (!isChecked2 || !isChecked3) {
                        print("111");
                        setState(() {
                          isAccept = false;
                        });
                      } else if (nickname.text.length == 0) {
                        setState(() {
                          nicknamenum = 2;
                        });
                      } else if (nickname.text.length < 2) {
                        print("222");
                        setState(() {
                          nicknamenum = 3;
                        });
                      } else if (nickname.text.length > 10) {
                        print("333");
                        setState(() {
                          nicknamenum = 4;
                        });
                      } else if (nickname.text
                          .contains(new RegExp(r'[ㄱ-ㅎㅏ-ㅣ]+'))) {
                        print("444");
                        setState(() {
                          nicknamenum = 5;
                        });
                      } else if (nickname.text
                          .contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]+'))) {
                        print("555");
                        setState(() {
                          nicknamenum = 6;
                        });
                      } else if (nickname.text.contains(new RegExp(r'[ ]+'))) {
                        print("666");
                        setState(() {
                          nicknamenum = 7;
                        });
                      } else {
                        signInWithGoogle();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          child: Image.asset(
                            "assets/googleicon.png",
                            height: 20.0,
                          ),
                        ),
                        Text("Google 아이디로 가입",
                            style: TextStyle(color: Colors.black)),
                        Opacity(
                          opacity: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            child: Image.asset(
                              "assets/googleicon.png",
                              height: 20.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              SizedBox(height: 30),
              //
              // TextButton(
              //     onPressed: () async {
              //       // await GoogleSignIn().disconnect();
              //       await _auth.signOut();
              //       // await GoogleSignIn().signOut();
              //     },
              //     child: Text("로그아웃")),
              // TextButton(
              //   onPressed: () async {
              //     // await GoogleSignIn().disconnect();
              //     await _auth.currentUser!.delete();
              //     await _auth.signOut();
              //   },
              //   child: Text("삭제"),
              // )
            ],
          )
        ],
      ),
    );
  }

  Future<bool> signInWithGoogle() async {
    Loader.showLoadingDialog(context);
    await GoogleSignIn().disconnect();
    String date = DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now());
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    print("okok" + googleUser.email);

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // return await FirebaseAuth.instance.signInWithCredential(credential);
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final isNew = userCredential.additionalUserInfo!.isNewUser;
    print(isNew);

    if (isNew) {
      CollectionReference reference =
          await FirebaseFirestore.instance.collection("user");
      String defaultIconUrl =
          "https://firebasestorage.googleapis.com/v0/b/metagamer-8d6a1.appspot.com/o/dev%2Fdefaultprofileicon.png?alt=media&token=cee38d5d-48b1-4e85-bbe0-d3114c07959a";
      FirstLoginModel model = FirstLoginModel(
          email: _auth.currentUser!.email.toString(),
          nickname: nickname.text,
          defaulticon: defaultIconUrl,
          accept1: date,
          accept2: date); //날짜 설정
      await reference.doc(_auth.currentUser!.email).set(model.toJson());
    }
    Loader.closeLoadingDialog();
    return isNew;
  }
}

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({Key? key}) : super(key: key);

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {

  final _auth = FirebaseAuth.instance;

  TextEditingController nickname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isAccept = true;

  int nicknamenum = 1;

  Widget nicknamegood = Text("2~10자리 한글, 영문, 숫자만 가능합니다.",
      style: TextStyle(color: Colors.black54));
  Widget nicknamenohave =
      Text("닉네임을 입력해주세요.", style: TextStyle(color: Colors.red));
  Widget nicknameunder2 =
      Text("2자리보다 적습니다.", style: TextStyle(color: Colors.red));
  Widget nicknamemore10 =
      Text("10자리를 초과합니다.", style: TextStyle(color: Colors.red));
  Widget nicknamenogood =
      Text("올바른 닉네임을 입력해주세요.", style: TextStyle(color: Colors.red));
  Widget nicknamespecial =
      Text("특수문자는 사용할 수 없습니다.", style: TextStyle(color: Colors.red));
  Widget nicknamespacebar =
      Text("공백이 포함될 수 없습니다.", style: TextStyle(color: Colors.red));

  int emailnum = 1;
  Widget emailtext = Text("완료", style: TextStyle(color: Colors.transparent));
  Widget emailnohave =
      Text("이메일을 입력해주세요.", style: TextStyle(color: Colors.red));
  Widget emailnogood =
      Text("올바른 이메일주소를 입력해주세요.", style: TextStyle(color: Colors.red));

  int password1num = 1;
  Widget passwordgood = Text("8~12자(영문, 숫자, 특수문자)로 입력할 수 있습니다.",
      style: TextStyle(color: Colors.black54));
  Widget passwordtext =
      Text("8~12자(영문, 숫자, 특수문자) 확인해주세요.", style: TextStyle(color: Colors.red));

  int password2num = 1;
  Widget password2good = Text("", style: TextStyle(color: Colors.transparent));
  Widget password2text =
      Text("비밀번호를 한번 더 입력해주세요.", style: TextStyle(color: Colors.red));
  Widget password2nosame =
      Text("비밀번호가 다릅니다.", style: TextStyle(color: Colors.red));

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 35.0,
                      child: Checkbox(
                          value: isChecked1,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked1 = value!;
                              isChecked2 = value;
                              isChecked3 = value;
                              if (value == true) {
                                isAccept = true;
                              }
                            });
                          })),
                  Text("전체 동의")
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 35.0,
                      child: Checkbox(
                          value: isChecked2,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked2 = value!;
                              if (isChecked2 && isChecked3) {
                                isAccept = true;
                              } else if (!isChecked2 || !isChecked3) {
                                isChecked1 = false;
                              }
                            });
                          })),
                  Text("Meta Gamer 이용약관")
                ],
              ),
              SizedBox(
                  height: 35.0,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "보기",
                        style: TextStyle(decoration: TextDecoration.underline),
                      )))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 35.0,
                      child: Checkbox(
                          value: isChecked3,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked3 = value!;
                              if (isChecked2 && isChecked3) {
                                isAccept = true;
                              } else if (!isChecked2 || !isChecked3) {
                                isChecked1 = false;
                              }
                            });
                          })),
                  Text("개인정보수집 및 이용 동의")
                ],
              ),
              SizedBox(
                  height: 35.0,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "보기",
                        style: TextStyle(decoration: TextDecoration.underline),
                      )))
            ],
          ),
          SizedBox(height: 5.0),
          Text("약관 동의 후 가입이 가능합니다.",
              style:
                  TextStyle(color: isAccept ? Colors.transparent : Colors.red)),
          SizedBox(height: 8.0),
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          SizedBox(height: 15.0),
          TextField(
            onChanged: (text) {
              if (text.length >= 2 && text.length <= 10) {
                setState(() {
                  nicknamenum = 1;
                });
              }
            },
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                hintText: "닉네임",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(10.0)),
            controller: nickname,
            autofocus: false,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                child: nicknamenum == 1
                    ? nicknamegood
                    : nicknamenum == 2
                        ? nicknamenohave
                        : nicknamenum == 3
                            ? nicknameunder2
                            : nicknamenum == 4
                                ? nicknamemore10
                                : nicknamenum == 5
                                    ? nicknamenogood
                                    : nicknamenum == 6
                                        ? nicknamespecial
                                        : nicknamespacebar,
              ),
            ],
          ),
          SizedBox(height: 15.0),
          TextField(
            onChanged: (text) {
              if (text.length != 0) {
                setState(() {
                  emailnum = 1;
                });
              }
            },
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                hintText: "이메일",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(10.0)),
            controller: email,
            autofocus: false,
          ),
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                  child: emailnum == 1
                      ? emailtext
                      : emailnum == 2
                          ? emailnohave
                          : emailnogood),
            ],
          ),
          SizedBox(height: 15.0),
          TextField(
            onChanged: (text) {
              setState(() {
                password1num = 1;
              });
            },
            obscureText: true,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                hintText: "비밀번호",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(10.0)),
            controller: password1,
            autofocus: false,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                child: password1num == 1 ? passwordgood : passwordtext,
              )
            ],
          ),
          SizedBox(height: 15.0),
          TextField(
            onChanged: (text) {
              setState(() {
                password2num = 1;
              });
            },
            obscureText: true,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                hintText: "비밀번호 확인",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(10.0)),
            controller: password2,
            autofocus: false,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                child: password2num == 1
                    ? password2good
                    : password2num == 2
                        ? password2text
                        : password2nosame,
              )
            ],
          ),
          SizedBox(height: 15.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            onPressed: () async {
              // String uid = _auth.currentUser!.uid;
              // print(uid);
              // await _auth.currentUser!.delete();

              // try {
              //   final newUser = await _auth.createUserWithEmailAndPassword(
              //     email: email.text,
              //     password: password.text,
              //   );
              // } on FirebaseAuthException catch (e) {
              //   if (e.code == 'weak-password') {
              //     print('The password provided is too weak.');
              //   } else if (e.code == 'email-already-in-use') {
              //     print('The account already exists for that email.');
              //   }
              // } catch (e) {
              //   print(e);
              // }

              if (!isChecked2 || !isChecked3) {
                setState(() {
                  isAccept = false;
                });
              } else if (nickname.text.length == 0) {
                setState(() {
                  nicknamenum = 2;
                });
              } else if (nickname.text.length < 2) {
                setState(() {
                  nicknamenum = 3;
                });
              } else if (nickname.text.length > 10) {
                setState(() {
                  nicknamenum = 4;
                });
              } else if (nickname.text.contains(new RegExp(r'[ㄱ-ㅎㅏ-ㅣ]+'))) {
                setState(() {
                  nicknamenum = 5;
                });
              } else if (nickname.text
                  .contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]+'))) {
                setState(() {
                  nicknamenum = 6;
                });
              } else if (nickname.text.contains(new RegExp(r'[ ]+'))) {
                setState(() {
                  nicknamenum = 7;
                });
              } else if (email.text.length == 0) {
                setState(() {
                  emailnum = 2;
                });
              } else if (!email.text.contains(new RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'))) {
                setState(() {
                  emailnum = 3;
                });
              } else if (!password1.text.contains(new RegExp(r'[a-zA-Z]+')) ||
                  password1.text.contains(new RegExp(r'[ㄱ-ㅎㅏ-ㅣ가-힣]+')) ||
                  password1.text.length < 6 ||
                  password1.text.length > 12) {
                setState(() {
                  password1num = 2;
                });
              } else if (password2.text.length == 0) {
                setState(() {
                  password2num = 2;
                });
              } else if (password2.text != password1.text) {
                setState(() {
                  password2num = 3;
                });
              } else {
                setState(() {
                  password2num = 1;
                  print("정상");
                });
                Loader.showLoadingDialog(context);
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email.text,
                    password: password1.text,
                  );
                  bool isNew = newUser.additionalUserInfo!.isNewUser;
                  print(isNew);
                  if (isNew) {
                    String date = DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now());
                    CollectionReference reference =
                    await FirebaseFirestore.instance.collection("user");
                    String defaultIconUrl =
                        "https://firebasestorage.googleapis.com/v0/b/metagamer-8d6a1.appspot.com/o/dev%2Fdefaultprofileicon.png?alt=media&token=cee38d5d-48b1-4e85-bbe0-d3114c07959a";
                    FirstLoginModel model = FirstLoginModel(
                        email: _auth.currentUser!.email.toString(),
                        nickname: nickname.text,
                        defaulticon: defaultIconUrl,
                        accept1: date,
                        accept2: date); //날짜 설정
                    await reference.doc(_auth.currentUser!.email).set(model.toJson());
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
                Loader.closeLoadingDialog();
              }
            },
            child: Text("가입"),
          ),
          // TextButton(onPressed: () async {
          //   try {
          //     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          //         email: "kmj654649@gmail.com",
          //         password: "goqkfkrl"
          //     );
          //   } on FirebaseAuthException catch (e) {
          //     if (e.code == 'user-not-found') {
          //       print('No user found for that email.');
          //     } else if (e.code == 'wrong-password') {
          //       print('Wrong password provided for that user.');
          //     }
          //   }
          // }, child: Text("로그인"))
        ],
      ),
    );
  }
}
