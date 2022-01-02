class BoadModel {
  final String time;
  final String uid;
  final String nickname;
  final String title;
  final String content;
  final int like;
  final int view;

  BoadModel(
      {required this.time,
      required this.uid,
      required this.nickname,
      required this.title,
      required this.content,
      required this.like,
      required this.view});

  BoadModel.fromJson(Map<String, dynamic> json)
      : time = json['time'] as String,
        uid = json['uid'] as String,
        nickname = json['nickname'] as String,
        title = json['title'] as String,
        content = json['content'] as String,
        like = json['like'] as int,
        view = json['view'] as int;

  Map<String, dynamic> toJson() => {
        'time': time,
        'uid': uid,
        'nickname': nickname,
        'title': title,
        'content': content,
        'like': 0,
        'view': 0
      };
}
