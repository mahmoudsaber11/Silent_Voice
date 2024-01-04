class PostModel {
  final String name;
  final String uId;
  final String image;
  final String time;
  final String text;
  final String postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.time,
    required this.text,
    required this.postImage,
  });
  factory PostModel.fromJson(Map<String, dynamic>? json) {
    return PostModel(
        name: json!['name'],
        uId: json['uId'],
        image: json['image'],
        time: json['time'],
        text: json['text'],
        postImage: json['postImage']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'time': time,
    };
  }
}
