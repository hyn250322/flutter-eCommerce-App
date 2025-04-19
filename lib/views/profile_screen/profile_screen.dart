import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_emart1/controllers/auth_controller.dart';
import 'package:flutter_emart1/controllers/profile_controller.dart';
import 'package:flutter_emart1/services/firestore_services.dart';
import 'package:flutter_emart1/views/auth_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emart1/consts/consts.dart';
import 'package:flutter_emart1/consts/lists.dart';
import 'package:flutter_emart1/views/profile_screen/components/details_card.dart';
import 'package:flutter_emart1/views/profile_screen/edit_profile_screen.dart';
import 'package:flutter_emart1/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
       body: StreamBuilder(
           stream: FirestoreServices.getUser(currentUser!.uid),

           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshop) {
             if (!snapshop.hasData) {
               return const Center(
                 child: CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(redColor),
                 ),
               );
             }
             else {
               var data = snapshop.data!.docs[0];
               return SafeArea(
                   child: Column(
                     children: [
                       //edit profile button
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: const Align(alignment: Alignment.topRight, child: Icon(Icons.edit, color: whiteColor)).onTap(() {
                           controller.nameController.text = data['name'];
                           Get.to(() =>  EditProfileScreen(data: data));
                         }),
                       ),


                       //users details section
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                         child: Row(
                           children: [
                             data['imageUrl'] == '' ?
                             Image.asset(imgProfile3, width: 100, height: 80, fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                             :
                             Image.network(data['imageUrl'], width: 100, height: 80, fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),
                             10.widthBox,
                             Expanded(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     "${data['name']}".text.fontFamily(semibold).white.make(),
                                     "${data['email']}".text.white.make(),
                                   ],
                                 )),
                             OutlinedButton(
                               style: OutlinedButton.styleFrom(
                                 side: const BorderSide(
                                   color: whiteColor,
                                 ),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.zero,
                                 ),
                               ),
                               onPressed: () async {
                                 await Get.put(AuthController()).signoutMehod(context);
                                 Get.offAll(() => const LoginScreen());
                               },
                               child: logout.text.fontFamily(semibold).white.make(),
                             )
                           ],
                         ),
                       ),

                       20.heightBox,
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           detailsCard(count: data['cart_count'], title: "in your cart", width: context.screenWidth / 3.4),
                           detailsCard(count: data['wishlist_count'], title: "in your wishlist", width: context.screenWidth / 3.4),
                           detailsCard(count: data['order_count'], title: "your orders", width: context.screenWidth / 3.4),
                         ],
                       ),

                       //buttons section


                       ListView.separated(
                         shrinkWrap: true,
                         separatorBuilder: (context, index){
                           return const Divider(color: lightGrey);
                         },
                         itemCount: profileButtonsList.length,
                         itemBuilder: (BuildContext context, int index) {
                           return ListTile(
                             leading: Image.asset(
                               profileButtonsIcon[index],
                               width: 22,
                             ),
                             title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                           );
                         },
                       ).box.white.rounded.margin(EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make(),
                     ],
                   ));
             }

           })
      )
    );
  }
}
