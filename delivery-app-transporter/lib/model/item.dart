class Item {
  static const FIELD_NAME = "item_name";
  static const FIELD_TOTAL = "total";

  String name;
  int total;

  Item({this.name, this.total});

  Item.fromMap(Map<dynamic, dynamic> inputMap) {
    name = inputMap[FIELD_NAME];
    total = inputMap[FIELD_TOTAL];
  }

  static List<Item> toList(List<dynamic> inputMapList) {
    return inputMapList.map((data) => Item.fromMap(data)).toList();
  }

  @override
  String toString() {
    return 'Item{name: $name, total: $total}';
  }

}
