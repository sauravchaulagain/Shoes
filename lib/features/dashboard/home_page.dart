import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shoes/app/text_style.dart';
import 'package:shoes/common/shoes_data.dart';
import 'package:shoes/common/theme.dart';
import 'package:shoes/common/utils/size_utils.dart';
import 'package:shoes/features/dashboard/carousel_image_box.dart';
import 'package:shoes/features/dashboard/product_detail_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final data = ShoesData().shoesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discover",
          style: PoppinsTextStyles.titleMediumRegular.copyWith(
              color: CustomTheme.darkColor, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: data.length,
            itemBuilder: (context, index, realIndex) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailWidget(
                          data: data[index],
                        ),
                      ));
                },
                child: CarouselBoxDesign(data: data[index])),
            options: CarouselOptions(
              enlargeCenterPage: true,
              initialPage: 2,
              height: 260.hp,
              viewportFraction: 0.6,
              animateToClosest: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlay: true,
            ),
          ),
          SizedBox(height: 10.hp),
          const Divider(thickness: 1),
          SizedBox(height: 10.hp),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: data.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailWidget(
                          data: data[index],
                        ),
                      ));
                },
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                    padding: const EdgeInsets.all(8),
                    width: 80.wp,
                    decoration: BoxDecoration(
                        color: data[index].color,
                        borderRadius: BorderRadius.circular(8)),
                    child: Image.asset(data[index].image)),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index].brand,
                      style: PoppinsTextStyles.bodyLargeRegular
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data[index].shortDesc,
                      style: PoppinsTextStyles.bodySmallRegular,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                trailing: Text(
                  data[index].price,
                  style: PoppinsTextStyles.bodyLargeRegular.copyWith(
                      fontWeight: FontWeight.w500,
                      color: CustomTheme.googleColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
