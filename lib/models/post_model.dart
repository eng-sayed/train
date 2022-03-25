import 'dart:convert';

class PostModel {
  String? name;
  String? image;
  String? details;
  String? time;
  PostModel({
    this.name,
    this.image,
    this.details,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'details': details,
      'time': time,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      name: map['name'],
      image: map['image'],
      details: map['details'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  PostModel copyWith({
    String? name,
    String? image,
    String? details,
    String? time,
  }) {
    return PostModel(
      name: name ?? this.name,
      image: image ?? this.image,
      details: details ?? this.details,
      time: time ?? this.time,
    );
  }
}
