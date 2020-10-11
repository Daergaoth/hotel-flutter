class ImageSaved {
  int id;
  String imgUrl;
  String imageStatus;

  ImageSaved({this.id, this.imgUrl, this.imageStatus});

  factory ImageSaved.fromJson(Map<String, dynamic> json) {
    return ImageSaved(
      id: json['id'],
      imgUrl: json['imgUrl'],
      imageStatus: json['imageStatus'],
    );
  }
}
