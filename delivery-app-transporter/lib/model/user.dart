class User {
  static const COLLECTION_NAME="";
  static const FIELD_ID="";
  static const FIELD_NAME="name";
  static const FIELD_PHONE="phone_number";
  static const FIELD_ADDRESS="address";

  String id;
  String name;
  String phoneNo;
  String address;

  User({
    this.id,
    this.address,
    this.name,
    this.phoneNo
  });

  User.fromMap(Map<dynamic, dynamic> inputMap){
//    id = inputMap[FIELD_ID];
    name = inputMap[FIELD_NAME];
    phoneNo = inputMap[FIELD_PHONE];
    address = inputMap[FIELD_ADDRESS];
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, phoneNo: $phoneNo, address: $address}';
  }


}
