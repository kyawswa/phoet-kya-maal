class User {
 final String name;
 final String address;
 final String phone;
 final String division;
final  String township;

  User({this.name, this.address, this.phone, this.division, this.township});
  User.fromJson(Map<String, dynamic> json)
  : name = json['name'],
    address = json['address'],
     phone = json['phone'],
      division = json['division'],
       township = json['township'];

        Map<String, dynamic> toJson() =>
    {
      'name': name,
      'address': address,
      'phone':phone,
      'division' :division,
      'township' : township
    };
}
