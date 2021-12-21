import 'dart:convert';

class FirstLoginModel {
  final String email;
  final String nickname;
  final String defaulticon;

  FirstLoginModel({required this.email, required this.nickname, required this.defaulticon});

  FirstLoginModel.fromJson(Map<String, dynamic> json) : email = json['email'], nickname = json['nickname'], defaulticon = json['defaulticon'];

  Map<String, String> toJson() => {
    'email': email,
    'nickname': nickname,
    'defaulticon': defaulticon
  };
}