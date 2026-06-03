class RadioModel {
  int ?id;
  String name;
  String url;
  String ?recentDate;

  RadioModel({
     this.id,
    required this.name,
    required this.url,
     this.recentDate,
  });

  factory RadioModel.fromJson(Map<String, dynamic> json) {
    return RadioModel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      recentDate: json['recent_date'],
    );
  }
}
