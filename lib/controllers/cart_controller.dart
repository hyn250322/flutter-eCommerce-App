//file cart controller
import 'package:flutter_emart1/consts/consts.dart';
import 'package:get/get.dart';
import 'package:flutter_emart1/widgets_common/our_button.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  increaseQuantity(DocumentSnapshot doc) {
    int currentQty = doc['qty'] ?? 1;
    int price = int.parse(doc['price'].toString());

    int newQty = currentQty + 1;
    int totalPrice = price * newQty; // Calculate new total price

    // Update in Firestore
    firestore.collection(cartCollection).doc(doc.id).update({
      'qty': newQty,
      'tprice': totalPrice.toString(),
    });
  }

  decreaseQuantity(DocumentSnapshot doc) {
    int currentQty = doc['qty'] ?? 1;

    if (currentQty > 1) {
      int price = int.parse(doc['price'].toString());
      int newQty = currentQty - 1;
      int totalPrice = price * newQty; // Calculate new total price

      // Update in Firestore
      firestore.collection(cartCollection).doc(doc.id).update({
        'qty': newQty,
        'tprice': totalPrice.toString(),

      });
    }
  }
}