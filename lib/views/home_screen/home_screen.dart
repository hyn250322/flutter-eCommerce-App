import 'package:flutter_emart1/consts/consts.dart';
import 'package:flutter_emart1/consts/lists.dart';
import 'package:flutter_emart1/views/home_screen/components/featured_button.dart';
import 'package:flutter_emart1/widgets_common/home_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 60,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchanything,
                    hintStyle: TextStyle(color: textfieldGrey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),

              10.heightBox,

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      VxSwiper.builder(
                          itemCount: slidersList.length,
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemBuilder: (context, index) {
                            return Image
                                .asset(
                              slidersList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }),

                      10.heightBox,
                      //deals buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            2, (index) => homeButtons(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 2.5,
                          icon: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? todayDeal : flashsale,
                        )),
                      ),


                      //2nd swiper
                      10.heightBox,
                      //swiper brand
                      VxSwiper.builder(
                          itemCount: secondSlidersList.length,
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemBuilder: (context, index) {
                            return Image
                                .asset(
                              secondSlidersList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }),

                      //category buttons
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                                (index) => homeButtons(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 3.5,
                              icon: index == 0? icTopCategories : index == 1 ? icBrands : icTopSeller,
                              title: index == 0 ? topCategories : index == 1 ? brand : topSellers,
                            )),
                      ),

                      //featured categories
                      20.heightBox,

                      Align(
                          alignment: Alignment.centerLeft,
                          child: featuredCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),
                      20.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              3,
                                  (index) => Column(
                                children: [
                                  featuredButton(icon: featuredListImages1[index], title: featuredTitles1[index]),
                                  10.heightBox,
                                  featuredButton(icon: featuredListImages2[index], title: featuredTitles2[index]),

                                ],
                              )),
                        ),
                      ),

                      //featured product

                      20.heightBox,

                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: const BoxDecoration(color: redColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text.white.fontFamily(bold).size(18).make(),
                            10.heightBox,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(6, (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                        imgP1,
                                        width: 130,
                                        fit: BoxFit.cover
                                    ),
                                    10.heightBox,
                                    "Laptop 4GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                                    10.heightBox,
                                    "₫ 1.800.000".text.color(redColor).fontFamily(bold).size(15).make()
                                  ],
                                ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(8)).make()),
                              ),
                            )
                          ],
                        ),
                      ),

                      //third swiper
                      20.heightBox,
                      VxSwiper.builder(
                          itemCount: secondSlidersList.length,
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemBuilder: (context, index) {
                            return Image
                                .asset(
                              secondSlidersList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }),

                      //all products section
                      20.heightBox,
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 300 ),
                          itemBuilder: (context,index){
                            return Column(
                              children: [
                                Image.asset(
                                    imgP5,
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover
                                ),
                                10.heightBox,
                                "Laptop 4GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                                10.heightBox,
                                "₫ 1.800.000".text.color(redColor).fontFamily(bold).size(15).make()
                              ],
                            )
                                .box
                                .white
                                .margin(const EdgeInsets.symmetric(horizontal: 4))
                                .roundedSM
                                .padding(const EdgeInsets.all(12))
                                .make();

                          })


                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}