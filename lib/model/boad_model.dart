class BoadModel {
  final String time;
  final String uid;
  final String nickname;
  final String title;
  final String content;
  final String like;
  final String view;

  BoadModel(
      {required this.time,
      required this.uid,
      required this.nickname,
      required this.title,
      required this.content,
      required this.like,
      required this.view});

  BoadModel.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        uid = json['uid'],
        nickname = json['nickname'],
        title = json['title'],
        content = json['content'],
        like = json['like'],
        view = json['view'];

  Map<String, String> toJson() => {
        'time': time,
        'uid': uid,
        'nickname': nickname,
        'title': title,
        'content': content,
        'like': like,
        'view': view
      };
}
