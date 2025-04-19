import 'dart:io';

import 'package:flutter_emart1/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emart1/controllers/profile_controller.dart';
import 'package:flutter_emart1/widgets_common/bg_widget.dart';
import 'package:flutter_emart1/widgets_common/custom_textfield.dart';
import 'package:flutter_emart1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Gọi Firestore để lấy lại data
  }

  void fetchUserData() async {
    var doc = await firestore.collection(usersCollection).doc(currentUser!.uid).get();
    setState(() {
      userData = doc.data();
      controller.nameController.text = userData?['name'] ?? '';
      // KHÔNG gán password vào controller
      controller.oldpassController.clear();
      controller.newpassController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: userData == null
            ? const Center(child: CircularProgressIndicator())
            : Obx(
              () => SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                userData!['imageUrl'] == '' && controller.profileImgPath.isEmpty
                    ? Image.asset(imgProfile3, width: 130, height: 90, fit: BoxFit.cover)
                    .box.roundedFull.clip(Clip.antiAlias).make()
                    : userData!['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(userData!['imageUrl'], width: 130, height: 90, fit: BoxFit.cover)
                    .box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(File(controller.profileImgPath.value), width: 130, height: 90, fit: BoxFit.cover)
                    .box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change",
                ),
                const Divider(),
                20.heightBox,
                customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.oldpassController,
                  hint: passwordHint,
                  title: oldpass,
                  isPass: true,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.newpassController,
                  hint: passwordHint,
                  title: newpass,
                  isPass: true,
                ),
                controller.isloading.value
                    ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor))
                    : SizedBox(
                  width: context.screenWidth - 60,
                  child: ourButton(
                    color: redColor,
                    onPress: () async {
                      controller.isloading(true);

                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink = userData?['imageUrl'] ?? '';
                      }

                      // So sánh mật khẩu cũ
                      if (userData?['password'] == controller.oldpassController.text) {
                        await controller.changeAuthPassword(
                            email: userData?['email'],
                            password: controller.oldpassController.text,
                            newpassword: controller.newpassController.text
                        );

                        await controller.updateProfile(
                          imgUrl: controller.profileImageLink,
                          name: controller.nameController.text,
                          password: controller.newpassController.text,
                        );

                        VxToast.show(context, msg: "Updated");
                      } else {
                        VxToast.show(context, msg: "Wrong old password");
                        controller.isloading(false);
                      }

                      fetchUserData();
                      controller.profileImgPath.value = '';
                    },

                    textColor: whiteColor,
                    title: "Save",
                  ),
                ),
              ],
            )
                .box
                .white
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                .rounded
                .make(),
          ),
        ),
      ),
    );
  }
}
