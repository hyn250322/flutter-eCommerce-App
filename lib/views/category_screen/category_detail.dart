import 'package:flutter_emart1/consts/consts.dart';
import 'package:flutter_emart1/views/category_screen/item_details.dart';
import 'package:flutter_emart1/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryDetail extends StatelessWidget {
  final String? title;
  const CategoryDetail({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(title: title!.text.fontFamily(bold).white.make()),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    6,
                    (index) =>
                        "Baby Clothing"
                            .text
                            .size(12)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .makeCentered()
                            .box
                            .white
                            .rounded
                            .size(120, 60)
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .make(),
                  ),
                ),
              ),

              //items container

              20.heightBox,

              Expanded(
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250, mainAxisSpacing: 8, crossAxisSpacing: 8),
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            Image.asset(
                                imgP5,
                                height: 150,
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
                            .outerShadowSm
                            .padding(const EdgeInsets.all(12))
                            .make()
                            .onTap(() {
                              Get.to(() => const ItemDetails(title: "Test Item"));
                        });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
