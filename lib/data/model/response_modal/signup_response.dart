class SignupResponse {
  SignupResponse({
    this.email,
    this.password,
    this.name,
    this.avatar,
    this.role,
    this.id,
    this.creationAt,
    this.updatedAt,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        email: json['email'] == null ? null : json['email'] as String,
        password: json['password'] == null ? null : json['password'] as String,
        name: json['name'] == null ? null : json['name'] as String,
        avatar: json['avatar'] == null ? null : json['avatar'] as String,
        role: json['role'] == null ? null : json['role'] as String,
        id: json['id'] == null ? null : json['id'] as int,
      );
  String? email;
  String? password;
  String? name;
  String? avatar;
  String? role;
  int? id;
  String? creationAt;
  String? updatedAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'email': email,
        'password': password,
        'name': name,
        'role': role,
        'id': id,
      };
}
