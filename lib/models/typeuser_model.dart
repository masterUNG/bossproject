import 'dart:convert';

class TypeUserModel {
  final String email;
  final String name;
  final String typeuser;
  TypeUserModel({
    this.email,
    this.name,
    this.typeuser,
  });

  TypeUserModel copyWith({
    String email,
    String name,
    String typeuser,
  }) {
    return TypeUserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      typeuser: typeuser ?? this.typeuser,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'typeuser': typeuser,
    };
  }

  factory TypeUserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return TypeUserModel(
      email: map['email'],
      name: map['name'],
      typeuser: map['typeuser'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeUserModel.fromJson(String source) => TypeUserModel.fromMap(json.decode(source));

  @override
  String toString() => 'TypeUserModel(email: $email, name: $name, typeuser: $typeuser)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is TypeUserModel &&
      o.email == email &&
      o.name == name &&
      o.typeuser == typeuser;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode ^ typeuser.hashCode;
}
