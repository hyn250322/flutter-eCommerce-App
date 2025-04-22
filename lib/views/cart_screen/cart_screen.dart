//file cart_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emart1/consts/consts.dart';
import 'package:flutter_emart1/controllers/cart_controller.dart';
import 'package:flutter_emart1/services/firestore_services.dart';
import 'package:flutter_emart1/widgets_common/loading_indicator.dart';
import 'package:flutter_emart1/widgets_common/our_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Giỏ hàng"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 2.0,
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              // Image
                              Container(
                                width: 80,
                                height: 80,
                                padding: const EdgeInsets.all(5),
                                child: Image.network(
                                  "${data[index]['img']}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Title and price
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "${data[index]['title']}".text
                                        .fontFamily(semibold)
                                        .maxLines(2)
                                        .overflow(TextOverflow.ellipsis)
                                        .size(16)
                                        .make(),
                                    5.heightBox,
                                    NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                                        .format(int.parse(data[index]['price']))
                                        .text
                                        .color(redColor)
                                        .fontFamily(semibold)
                                        .make(),
                                  ],
                                ),
                              ),
                              // Quantity controls
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove, color: darkFontGrey),
                                    onPressed: () {
                                      controller.decreaseQuantity(data[index]);
                                    },
                                  ),
                                  "${data[index]['qty'] ?? 1}".text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .size(16)
                                      .make(),
                                  IconButton(
                                    icon: const Icon(Icons.add, color: darkFontGrey),
                                    onPressed: () {
                                      controller.increaseQuantity(data[index]);
                                    },
                                  ),
                                ],
                              ),
                              // Delete button
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ),
                                onPressed: () {
                                  FirestoreServices.deleteDocument(data[index].id);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(() => NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                          .format(controller.totalP.value)
                          .text
                          .color(redColor)
                          .fontFamily(semibold)
                          .make(),
                      )
                    ],
                  ).box
                      .padding(const EdgeInsets.all(12))
                      .color(lightGolden)
                      .width(context.screenWidth - 60)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                      color: redColor,
                      onPress: () {},
                      textColor: whiteColor,
                      title: "Proceed to shipping",
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}