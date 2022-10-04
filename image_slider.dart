import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:platformtbd/helper/constant.dart';
import 'package:platformtbd/screens/shopping/brows/provider/product_brows_provider.dart';
import 'package:platformtbd/screens/shopping/cart/model.dart';
import 'package:platformtbd/screens/shopping/cart/provider/cart_provider.dart';
import 'package:platformtbd/widgets/custom_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../widgets/increment_decrement_widget.dart';

class ProductDetailsView extends StatefulWidget {

  ProductDetailsView({Key? key, }) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int currentIndex = 0;

  final PageController controller = PageController();
  final List<String> imageList = [
    "https://wenr.wes.org/wp-content/uploads/2019/09/iStock-1142918319_WENR_Ranking_740_430.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOh2gJ9eXdaox-uRpAz3oqWtjDlJ3k0AukWgxlzXg07nH71OpRzx20BZG9JcxkxH3loZc&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnj7GvtqijGyb2focyFejrmqJk1g_Bcjl2qg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRV7vJmRomAsYtE3JazzOxK61x63rrsfilphA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0YpfIsnCgTkcz39Z_4-EzgbDsDqh9T0wPfA&usqp=CAU",
    "https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg?cs=srgb&dl=pexels-pixabay-60597.jpg&fm=jpg",
    "https://wallpaperaccess.com/full/1622640.jpg",
    "https://wallpapercave.com/wp/tZqP1i4.jpg",
  ];
  ScrollController scrollController = ScrollController();
  void _animateToIndex(int index) {
    scrollController.animateTo(
      index * 50,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void _animateToIndexback(int index) {
    scrollController.animateTo(
      index * 50,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }



  @override
  Widget build(BuildContext context) {
    final productPr = Provider.of<ProductProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.clrBlack,
        title: Text("View Product"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 80.h,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:
                            Device.screenType == ScreenType.mobile ? 400 : 45.h,
                        width: 100.w,
                        child: PageView.builder(
                            onPageChanged: (index) {
                              currentIndex = productPr.onChangeIndex(
                                  index, FetchProduct.productList.length);
                            },
                            controller: controller,
                            itemCount: FetchProduct.productList.length,
                            itemBuilder: (context, index) {
                              final items = FetchProduct.productList[index];

                              return Container(
                                  height: 400,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image: NetworkImage(
                                            items.imgUrl.toString(),
                                          ))));
                            }),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconButton(
                            height: Device.screenType == ScreenType.mobile
                                ? 8.h
                                : 15.h,
                            width: Device.screenType == ScreenType.mobile
                                ? 40
                                : 8.w,
                            icon: Icon(Icons.arrow_back_ios,
                                size: Device.screenType == ScreenType.mobile
                                    ? 20
                                    : 40),
                            onPressed: () {
                              controller.jumpToPage(currentIndex - 1);
                              _animateToIndexback(currentIndex - 1);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: Device.screenType == ScreenType.mobile
                                ? 65.w
                                : 70.w,
                            height: Device.screenType == ScreenType.mobile
                                ? 8.h
                                : 15.h,
                            child: ListView.builder(
                                controller: scrollController,
                            
                                scrollDirection: Axis.horizontal,
                                itemCount: FetchProduct.productList.length,
                                itemBuilder: (context, index) {
                                  return buildIndicatorNew(
                                      currentIndex == index, index);
                                }),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomIconButton(
                            height: Device.screenType == ScreenType.mobile
                                ? 8.h
                                : 15.h,
                            width: Device.screenType == ScreenType.mobile
                                ? 40
                                : 8.w,
                            icon: Icon(Icons.arrow_forward_ios_rounded,
                                size: Device.screenType == ScreenType.mobile
                                    ? 20
                                    : 40),
                            onPressed: () {
                              controller.jumpToPage(currentIndex + 1);
                              _animateToIndex(currentIndex);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "${widget.cartModel.title}",
                        style: Constant.txtBlack,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            itemSize: Device.screenType == ScreenType.mobile
                                ? 15
                                : 25,
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            //  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber.shade700,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          Text(
                            "(13k)",
                            style: Device.screenType == ScreenType.mobile
                                ? TextStyle(fontSize: 10)
                                : TextStyle(fontSize: 19),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IncrementDecrementWidget(
                              onDecreament: () {
                              
                              },
                              qty: '${cart.qty}',
                              onIcreament: () {
                              
                              },
                            ),
                            Row(
                              children: [
                                Text(
                                  "\$",
                                  style: Device.screenType == ScreenType.mobile
                                      ? Constant.tabtxtBlack15Bold
                                      : Constant.tabMPortraitBold14,
                                ),
                                Text(
                                  "${double.parse(widget.cartModel.price.toString()) * cart.qty}",
                                  style: Device.screenType == ScreenType.mobile
                                      ? Constant.tabtxtBlack15Bold
                                      : Constant.tabMPortraitBold14,
                                ),
                                Text(
                                  ".99",
                                  style: Device.screenType == ScreenType.mobile
                                      ? Constant.txtBlack
                                      : Constant.tabMPortraitBold14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        style: Device.screenType == ScreenType.mobile
                            ? Constant.txtBlack
                            : Constant.headingM1Black,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  height: 7.h,
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 7.h,
                        width: 45.w,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            side: BorderSide(width: 1),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Buy now',
                            style: Device.screenType == ScreenType.mobile
                                ? Constant.txtBlackBold
                                : Constant.tabheading2Blk25,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        height: 7.h,
                        width: 45.w,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.zero,
                          ),
                          elevation: 0,
                          color: Constant.clrBlack,
                          onPressed: () {
                           
                          },
                          child: Text(
                            "Add to cart",
                            style: Device.screenType == ScreenType.mobile
                                ? Constant.txtWhiteBoldNoSize
                                : Constant.tabheading2White25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildIndicatorNew(bool isSelected, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: Device.screenType == ScreenType.mobile ? 55 : 18.h,
        width: Device.screenType == ScreenType.mobile ? 65 : 15.w,
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
                  color: Colors.green,
                  width: Device.screenType == ScreenType.mobile ? 4 : 8)
              : Border(),
          color: isSelected ? Colors.black : Colors.grey,
          image: DecorationImage(
              image: NetworkImage(
                  FetchProduct.productList[index].imgUrl.toString()),
              fit: BoxFit.fitHeight),
        ),
      ),
    );
  }
}
