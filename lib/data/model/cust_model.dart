class CustModel {
  String? name;
  String? email;
  String? userid;
  String? role;
  String? tlp;
  String? urlPhotos;

  CustModel({
    this.name,
    this.email,
    this.userid,
    this.role,
    this.tlp,
    this.urlPhotos,
  });

  //from server
  factory CustModel.fromMap(map) {
    return CustModel(
      name: map['name'],
      email: map['email'],
      userid: map['userid'],
      role: map['role'],
      tlp: map['tlp'],
      urlPhotos: map['urlPhotos'],
    );
  }
}
