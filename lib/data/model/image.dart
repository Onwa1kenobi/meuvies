class ImageData {
  String medium;
  String original;

  ImageData({
    required this.medium,
    required this.original,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      medium: json['medium'],
      original: json['original'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medium'] = medium;
    data['original'] = original;
    return data;
  }
}