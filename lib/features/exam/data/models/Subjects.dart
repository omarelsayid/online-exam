class Subjects {
  String? id;
  String? name;
  String? icon;
  String? createdAt;
  Subjects({
    this.id,
    this.name,
    this.icon,
    this.createdAt,
  });

  Subjects.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    icon = json['icon'];
    createdAt = json['createdAt'];
  }

  Subjects copyWith({
    String? id,
    String? name,
    String? icon,
    String? createdAt,
  }) =>
      Subjects(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        createdAt: createdAt ?? this.createdAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['icon'] = icon;
    map['createdAt'] = createdAt;
    return map;
  }
}
