class UserModel {
  int id;
  dynamic name;
  dynamic photo;
  dynamic email;
  dynamic phone;
  dynamic gender;
  dynamic genderId;
  dynamic contactAddress;
  dynamic lat;
  dynamic lng;
  //List<Children> listChildren;
  dynamic listTagId;
  static dynamic aliasName = "Parent";
  static UserModel _singleton;

  factory UserModel() {
    if (_singleton != null)
      return _singleton;
    else
      return _singleton = new UserModel._internal();
  }

  UserModel._internal();

  UserModel.newInstance({this.id,
    this.name,
    this.photo,
    this.email,
    this.phone,
    this.gender,
    this.contactAddress,
    this.lat,
    this.lng}) {
    id = id;
    name = name;
    photo = photo;
    email = email;
    phone = phone;
    gender = gender;
    contactAddress = contactAddress;
  }
}