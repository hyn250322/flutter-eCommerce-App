import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_emart1/consts/consts.dart';
import 'package:flutter_emart1/consts/lists.dart';
import 'package:flutter_emart1/widgets_common/applogo_widget.dart';
import 'package:flutter_emart1/widgets_common/bg_widget.dart';
import 'package:flutter_emart1/widgets_common/custom_textfield.dart';
import 'package:flutter_emart1/widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool? isCheck = false;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                "Join the $appname".text.fontFamily(bold).white.size(22).make(),
                15.heightBox,
                Column(
                  children: [
                    customTextField(title: name, hint: nameHint),
                    customTextField(title: email, hint: emailHint),
                    customTextField(title: password, hint: passwordHint),
                    customTextField(title: retypePassword, hint: passwordHint),


                    Row(
                      children: [
                        Checkbox(
                        checkColor: whiteColor, // Màu dấu check (✓)
                        activeColor: redColor,
                            value: isCheck,
                            onChanged: (newValue){
                          setState(() {
                            isCheck = newValue;
                          });
                            },
                        ),
                        5.widthBox,

                        Expanded(
                          child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    )),
                                  TextSpan(
                                    text: termAndCond,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    )),
                                  TextSpan(
                                      text: " & ",
                                      style: TextStyle(
                                        fontFamily: regular,
                                        color: fontGrey,
                                      )),
                                  TextSpan(
                                      text: privacyPolicy,
                                      style: TextStyle(
                                        fontFamily: regular,
                                        color: redColor,
                                      ))
                                ]
                              ))
                        )
                      ]
                    ),
                    5.heightBox,
                    ourButton(color: isCheck == true? redColor : lightGrey, title: signup, textColor: whiteColor, onPress: (){})
                        .box
                        .width(context.screenWidth - 50)
                        .make(),
                    10.heightBox,
                    RichText(text: TextSpan(
                      children: [
                        TextSpan(
                          text: alreadyHaveAccount,
                          style: TextStyle(fontFamily: bold, color: fontGrey),
                        ),
                        TextSpan(
                          text: login,
                          style: TextStyle(fontFamily: bold, color: redColor),
                        )
                      ],
                    ),
                    ).onTap((){
                      Get.back();
                    }),
                  ],
                ).box.white.rounded.padding(EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make()
              ],
            ),
          ),
        ));
  }
}
