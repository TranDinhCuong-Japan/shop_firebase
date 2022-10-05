  class MyUserModel {
  String? _phone;
  String? _id;
  String? _email;
  String? _name;

  MyUserModel({String? phone, String? id, String? email, String? name}) {
  if (phone != null) {
  this._phone = phone;
  }
  if (id != null) {
  this._id = id;
  }
  if (email != null) {
  this._email = email;
  }
  if (name != null) {
  this._name = name;
  }
  }

  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get id => _id;
  set id(String? id) => _id = id;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get name => _name;
  set name(String? name) => _name = name;

  MyUserModel.fromJson(Map<String, dynamic> json) {
  _phone = json['phone'];
  _id = json['id'];
  _email = json['email'];
  _name = json['name'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['phone'] = this._phone;
  data['id'] = this._id;
  data['email'] = this._email;
  data['name'] = this._name;
  return data;
  }
  }