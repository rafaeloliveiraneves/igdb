class Cover {
  final String imageId;

  Cover({this.imageId});

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      imageId: json['image_id'],
    );
  }
}
