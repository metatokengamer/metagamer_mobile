import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
          isKeyboardVisible ? EdgeInsets.only(top: 70.0) : EdgeInsets.all(0.0),
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

  String nicknametext = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,

      child: Column(
        children: [
          SizedBox(height: 30.0),
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
          SizedBox(height: 15.0),
          Text("약관 동의 후 가입이 가능합니다.",
              style:
                  TextStyle(color: isAccept ? Colors.transparent : Colors.red)),
          SizedBox(height: 15.0),
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          SizedBox(height: 30.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (text) {
                  if (text.length >= 2 && nicknametext == "2글자보다 적습니다.") {
                    setState(() {
                      nicknametext = "";
                    });
                  } else if (text.length <= 10 &&
                      nicknametext == "10글자를 초과합니다") {
                    setState(() {
                      nicknametext = "";
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
                    child:
                        Text(nicknametext, style: TextStyle(color: Colors.red)),
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
                        setState(() {
                          isAccept = false;
                        });
                      } else if (nickname.text.length < 2) {
                        setState(() {
                          nicknametext = "2글자보다 적습니다.";
                        });
                      } else if (nickname.text.length > 10) {
                        setState(() {
                          nicknametext = "10글자를 초과합니다";
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
              // TextButton(
              //     onPressed: () async {
              //       await GoogleSignIn().disconnect();
              //       await _auth.signOut();
              //     },
              //     child: Text("로그아웃")),
              // TextButton(
              //   onPressed: () async {
              //     await GoogleSignIn().disconnect();
              //     await _auth.currentUser!.delete();
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
          defaulticon: defaultIconUrl);
      await reference.doc(_auth.currentUser!.email).set(model.toJson());
    }

    return isNew;
  }
}

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({Key? key}) : super(key: key);

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30.0),
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
          SizedBox(height: 15.0),
          Text("약관 동의 후 가입이 가능합니다.",
              style:
                  TextStyle(color: isAccept ? Colors.transparent : Colors.red)),
          SizedBox(height: 15.0),
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          SizedBox(height: 30.0),
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
                        ? nicknameunder2
                        : nicknamenum == 3
                            ? nicknamemore10
                            : nicknamenum == 4
                                ? nicknamenogood
                                : nicknamenum == 5
                                    ? nicknamespecial
                                    : nicknamespacebar,
              ),
            ],
          ),
          SizedBox(height: 15.0),
          TextField(
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
                child: Text("올바른 이메일 주소를 입력해주세요.",
                    style: TextStyle(color: Colors.black54)),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          TextField(
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
          SizedBox(height: 30.0),
          TextField(
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
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            onPressed: () {
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

              // String s = "아 아";
              // var regex = new RegExp(r'^[ㄱ-ㅎ ㅏ-ㅣ]+$');
              // var regex1 = new RegExp(r'^[!@#$%^&*(),.?":{}|<>]+$');
              // var regex2 = new RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
              // var allMatches = regex.allMatches(s);
              //
              // // bool specialChar = s.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
              // bool specialChar1 = s.contains(new RegExp(r'[ㄱ-ㅎㅏ-ㅣ]+'));//성공!!!
              // print(specialChar1);

              // if (allMatches.isNotEmpty) {
              //   print("111");
              // } else {
              //   print("222");
              // }

              if (!isChecked2 || !isChecked3) {
                setState(() {
                  isAccept = false;
                });
              } else if (nickname.text.length < 2) {
                setState(() {
                  nicknamenum = 2;
                });
              } else if (nickname.text.length > 10) {
                setState(() {
                  nicknamenum = 3;
                });
              } else if (nickname.text.contains(new RegExp(r'[ㄱ-ㅎㅏ-ㅣ]+'))) {
                setState(() {
                  nicknamenum = 4;
                });
              } else if (nickname.text
                  .contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]+'))) {
                setState(() {
                  nicknamenum = 5;
                });
              } else if (nickname.text.contains(new RegExp(r'[ ]+'))) {
                setState(() {
                  nicknamenum = 6;
                });
              } else {
                print("정상");
              }

              // if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+").hasMatch(email.text)) {
              //   print("정상");
              // } else {
              //   print("오류");
              // }
            },
            child: Text("가입"),
          ),
        ],
      ),
    );
  }
}
