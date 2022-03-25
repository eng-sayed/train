import 'dart:convert';

class post {
  String? name;
  String? details;
  DateTime? time;
  String image;
  post({
    this.name,
    this.details,
    this.time,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'details': details,
      'time': time?.millisecondsSinceEpoch,
      'image': image,
    };
  }

  factory post.fromMap(Map<String, dynamic> map) {
    return post(
      name: map['name'],
      details: map['details'],
      time: map['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['time'])
          : null,
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory post.fromJson(String source) => post.fromMap(json.decode(source));

  post copyWith({
    String? name,
    String? details,
    DateTime? time,
    String? image,
  }) {
    return post(
      name: name ?? this.name,
      details: details ?? this.details,
      time: time ?? this.time,
      image: image ?? this.image,
    );
  }
}
