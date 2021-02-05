import 'package:flutter_app_bloc/model/transporter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransporterService {
  final Firestore _firestore = Firestore.instance;

  Future<List<Transporter>> getTransporters(String division) async {
    Query query = _firestore.collection('accounts')
        .where('row', isEqualTo: 'DELIVERY')
        .where('division', isEqualTo: division);
//        .where(Order.FIELD_STATE, isEqualTo: OrderState.PENDING.toShortString());

    List transporters;

    await query.getDocuments().then((snapshot) {
      transporters = snapshot.documents.map((document) {
       String id = document.data['id'];
       String name = document.data['name'];
       String phone = document.data['phone_number'][0];

       return Transporter(
          id: id,
          name: name,
          phoneNumber: phone
        );
      }).toList();
    });

    print(transporters);

    return transporters;
  }

  Future<void> assignOrder(String orderId, String deliveryId) async{
    print(orderId);
    print(deliveryId);
    await _firestore.collection('orders')
        .document(orderId).updateData({ 'delivery_account_id': deliveryId });
  }
}