class CommentModel {
  final String uid;
  final String nickname;
  final String content;
  final String tonickname;
  final String time;

  CommentModel(
      {required this.uid,
      required this.nickname,
      required this.content,
      required this.tonickname,
      required this.time});

  CommentModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] as String,
        nickname = json['nickname'] as String,
        content = json['content'] as String,
        tonickname = json['tonickname'] as String,
        time = json['time'] as String;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'nickname': nickname,
        'content': content,
        'tonickname': tonickname,
        'time': time,
      };
}
