
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  Post(this.id,this.userId, this.title, this.body);

  // named constructor
  Post.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        userId = int.parse(json['userId'].toString()),
        title = json['title'],
        body = json['body'];

  // method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}