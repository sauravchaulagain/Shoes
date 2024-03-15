import 'package:flutter/material.dart';
import 'package:shoes/app/text_style.dart';
import 'package:shoes/common/shoes_data.dart';
import 'package:shoes/common/theme.dart';
import 'package:shoes/common/utils/size_utils.dart';
import 'package:shoes/features/dashboard/product_detail_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final color = [
    Colors.green,
    Colors.lightBlue,
    Colors.blue,
    Colors.brown,
  ];
  @override
  Widget build(BuildContext context) {
    final data = ShoesData().shoesData;
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailWidget(
                    color: color[index],
                    data: data[index],
                  ),
                ));
          },
          contentPadding: const EdgeInsets.all(12),
          leading: Container(
              padding: const EdgeInsets.all(8),
              width: 80.wp,
              decoration: BoxDecoration(
                  color: color[index], borderRadius: BorderRadius.circular(8)),
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
                fontWeight: FontWeight.w500, color: CustomTheme.googleColor),
          ),
        ),
      ),
    );
  }
}
