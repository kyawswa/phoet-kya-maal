class User {
  final String username;
  final String phoneNumber;
  final String address;
  final String division;
  final String township;

  User({this.username, this.phoneNumber, this.address, this.division,
      this.township});

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        phoneNumber = json['phone_number'],
        address = json['address'],
        division = json['diviosn'],
        township = json['township'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'phone_number': phoneNumber,
        'address': address,
        'division': division,
        'township': township
      };
}
