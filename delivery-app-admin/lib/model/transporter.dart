class Transporter {
  static const FIELD_ID="id";
  static const FIELD_NAME="name";
  static const FIELD_PHONE="phone_number";

  String id;
  String name;
  String phoneNumber;

  Transporter({this.id, this.name, this.phoneNumber});

  Transporter.fromMap(Map<dynamic, dynamic> inputMap) {
    id = inputMap[FIELD_ID];
    name = inputMap[FIELD_NAME];
    phoneNumber = inputMap[FIELD_PHONE];
  }

  @override
  String toString() {
    return 'Transporter{id: $id, name: $name, phoneNumber: $phoneNumber}';
  }

}