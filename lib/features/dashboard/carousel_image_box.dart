import 'package:flutter/material.dart';
import 'package:shoes/app/text_style.dart';
import 'package:shoes/common/shoes_data.dart';
import 'package:shoes/common/theme.dart';
import 'package:shoes/common/utils/size_utils.dart';

class CarouselBoxDesign extends StatelessWidget {
  final ShoeProduct data;
  const CarouselBoxDesign({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            height: double.infinity,
            width: double.infinity,
            margin: const EdgeInsets.only(right: 60),
            decoration: BoxDecoration(
                color: data.color, borderRadius: BorderRadius.circular(18)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.brand,
                  style: PoppinsTextStyles.titleSmallRegular
                      .copyWith(color: CustomTheme.white, fontSize: 18),
                ),
                Text(
                  data.price,
                  style: PoppinsTextStyles.bodyMediumRegular
                      .copyWith(color: CustomTheme.white),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    data.gender,
                    textAlign: TextAlign.center,
                    style: PoppinsTextStyles.bodyMediumRegular
                        .copyWith(color: CustomTheme.white),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Transform.rotate(
              angle: 330 * (3.14 / 180),
              child: Image.asset(
                data.image,
                height: 120.hp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
