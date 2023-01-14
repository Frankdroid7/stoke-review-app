import 'package:hooks_riverpod/hooks_riverpod.dart';

var userStateProvider = StateProvider<UserModel>((ref) => UserModel());

class UserModel {
  int userId = 0;
  int? userRoleId;
  String? fullName;
  String? userRoleName;
  String? forenames;
  String? surname;
  String? phone;
  String? email;
  String? password;
  String? token;

  UserModel(
      {this.token,
      this.userId = 0,
      this.userRoleId = 2,
      this.fullName = "",
      this.userRoleName = "",
      this.forenames,
      this.surname,
      this.phone,
      this.email,
      this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
    userRoleId = json['userRoleId'];
    fullName = json['fullName'];
    userRoleName = json['userRoleName'];
    forenames = json['forenames'];
    surname = json['surname'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userRoleId'] = userRoleId;
    data['fullName'] = fullName;
    data['userRoleName'] = userRoleName;
    data['forenames'] = forenames;
    data['surname'] = surname;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
