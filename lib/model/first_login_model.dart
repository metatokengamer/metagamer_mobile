import 'dart:convert';

class FirstLoginModel {
  final String email;
  final String nickname;
  final String defaulticon;
  final String accept1;
  final String accept2;

  FirstLoginModel({required this.email, required this.nickname, required this.defaulticon, required this.accept1, required this.accept2});

  FirstLoginModel.fromJson(Map<String, dynamic> json) : email = json['email'], nickname = json['nickname'], defaulticon = json['defaulticon'], accept1 = json['이용약관동의'], accept2 = json['개인정보수집및이용동의'];

  Map<String, String> toJson() => {
    'email': email,
    'nickname': nickname,
    'defaulticon': defaulticon,
    '이용약관동의': accept1,
    '개인정보수집및이용동의': accept2
  };
}