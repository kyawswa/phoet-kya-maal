class Order {
  final int id;
  final String userName;
  final String address;
  final int phone;
  final String deliveryTime;
  final String est;

  Order({
    this.id,
    this.userName,
    this.address,
    this.phone,
    this.deliveryTime,
    this.est,
  });

  Order.mock(this.id)
      : userName = 'U Mg',
        address = 'No.40, Aung Mingalar Str.',
        phone = 09404343434,
        deliveryTime = 'Monday 3:00 PM',
        est = '30 minutes';
}
