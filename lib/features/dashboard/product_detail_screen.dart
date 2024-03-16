import 'package:flutter/material.dart';
import 'package:shoes/app/text_style.dart';
import 'package:shoes/common/shoes_data.dart';
import 'package:shoes/common/theme.dart';
import 'package:shoes/common/utils/size_utils.dart';
import 'package:shoes/common/widget/key_value_tile.dart';

class ProductDetailWidget extends StatefulWidget {
  final ShoeProduct data;

  const ProductDetailWidget({Key? key, required this.data}) : super(key: key);

  @override
  _ProductDetailWidgetState createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _padding = 500;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 360, end: 340).animate(_controller);
    _triggerRotationAfterDelay();
    _triggerTextAnimation();
  }

  void _triggerRotationAfterDelay() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _controller.forward();
    });
  }

  void _triggerTextAnimation() {
    Future.delayed(const Duration(seconds: 1), () {
      _padding = 0;
      setState(() {});
    });
  }

  final List images = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
  ];
  final List colorss = [
    Colors.green,
    const Color(0xFFA4C9D2),
    Colors.blue,
    const Color(0xFF622036),
  ];
  int? sizeIndex;
  bool _textExpanded = true;
  Color? colorTheme;
  String? displayImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              stretch: true,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: colorTheme,
              expandedHeight: 360,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.blurBackground],
                background: Container(
                  color: CustomTheme.lightColor,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100.wp,
                        child: Column(
                          children: List.generate(
                            images.length,
                            (index) => InkWell(
                              onTap: () {
                                setState(() {
                                  colorTheme = colorss[index];
                                  displayImage = images[index];
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: colorTheme ?? widget.data.color,
                                  ),
                                ),
                                child: Image.asset(images[index]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 30),
                              height: 360,
                              decoration: BoxDecoration(
                                color: colorTheme ?? widget.data.color,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(600),
                                ),
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.rotate(
                                  alignment: Alignment.center,
                                  angle: _animation.value * 3.14 / 180,
                                  child: ClipRRect(
                                    child: Hero(
                                      tag: "tag${widget.data.id}",
                                      child: Image.asset(
                                        displayImage ?? widget.data.image,
                                        alignment: Alignment.center,
                                        height: 360,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: AnimatedContainer(
                decoration: BoxDecoration(
                    color: CustomTheme.lightColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    border: Border.all(color: colorTheme ?? widget.data.color)),
                margin: EdgeInsets.only(top: _padding),
                duration: const Duration(milliseconds: 700),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Container(
                                color: CustomTheme.gray,
                                width: 100,
                                height: 5,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetailWidget(
                                            data: widget.data,
                                          )),
                                );
                              },
                              icon: const Icon(Icons.close))
                        ],
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          widget.data.brand,
                          style: PoppinsTextStyles.titleLargeRegular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: colorTheme ?? widget.data.color,
                          ),
                        ),
                        subtitle: Text(
                          widget.data.title,
                          style: PoppinsTextStyles.bodyMediumRegular,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        trailing: Text(
                          widget.data.price,
                          style: PoppinsTextStyles.titleMediumRegular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: colorTheme ?? widget.data.color,
                          ),
                        ),
                      ),
                      Text(
                        "Description",
                        style: PoppinsTextStyles.bodyLargeRegular.copyWith(
                          color: colorTheme ?? widget.data.color,
                        ),
                      ),
                      SizedBox(height: 5.hp),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _textExpanded = !_textExpanded;
                          });
                        },
                        child: Text(
                          widget.data.desc,
                          maxLines: _textExpanded ? 4 : 15,
                          overflow: TextOverflow.ellipsis,
                          style: PoppinsTextStyles.bodySmallRegular.copyWith(
                              color: CustomTheme.darkColor.withOpacity(0.8)),
                        ),
                      ),
                      SizedBox(height: 10.hp),
                      Text(
                        "Size",
                        style: PoppinsTextStyles.bodyLargeRegular.copyWith(
                          color: colorTheme ?? widget.data.color,
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                          widget.data.sizeOptions.length,
                          (index) => InkWell(
                            onTap: () {
                              sizeIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              width: 70.wp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: colorTheme ?? widget.data.color),
                                  color: colorTheme ??
                                      widget.data.color.withOpacity(
                                          sizeIndex == index ? 0.5 : 0.1)),
                              padding: const EdgeInsets.all(12),
                              child: Text(widget.data.sizeOptions[index]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.hp),
                      Text(
                        "Recommended Use",
                        style: PoppinsTextStyles.bodyLargeRegular.copyWith(
                          color: colorTheme ?? widget.data.color,
                        ),
                      ),
                      SizedBox(height: 5.hp),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          widget.data.recommendedUse.length,
                          (index) => Text(
                            "* ${widget.data.recommendedUse[index]}",
                            style: PoppinsTextStyles.bodySmallRegular.copyWith(
                                color: CustomTheme.darkColor.withOpacity(0.8)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.hp),
                      Text(
                        "Material",
                        style: PoppinsTextStyles.bodyLargeRegular.copyWith(
                          color: colorTheme ?? widget.data.color,
                        ),
                      ),
                      SizedBox(height: 5.hp),
                      Text(
                        widget.data.material,
                        style: PoppinsTextStyles.bodySmallRegular.copyWith(
                            color: CustomTheme.darkColor.withOpacity(0.8)),
                      ),
                      SizedBox(height: 10.hp),
                      Text(
                        "Details",
                        style: PoppinsTextStyles.bodyLargeRegular.copyWith(
                          color: colorTheme ?? widget.data.color,
                        ),
                      ),
                      SizedBox(height: 20.hp),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Gender",
                          value: widget.data.gender),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Warranty",
                          value: widget.data.weight),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Weight",
                          value: widget.data.weight),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Width",
                          value: widget.data.width),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Sole Material",
                          value: widget.data.soleMaterial),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Closure Type",
                          value: widget.data.closureType),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "insole",
                          value: widget.data.insole),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Lining Material",
                          value: widget.data.liningMaterial),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Toe Style",
                          value: widget.data.toeStyle),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Heel Height",
                          value: widget.data.heelHeight),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Activity Type",
                          value: widget.data.activityType),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Arch Type",
                          value: widget.data.archType),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Weight Per Pair",
                          value: widget.data.weightPerPair),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Country Of Manufacture",
                          value: widget.data.countryOfManufacture),
                      KeyValueTile(
                          valueCOlor:
                              colorTheme ?? widget.data.color.withOpacity(0.8),
                          title: "Packaging",
                          value: widget.data.packaging),
                      SizedBox(height: 10.hp),
                      Text(
                        "Care Instructions",
                        style: PoppinsTextStyles.bodyLargeRegular.copyWith(
                          color: colorTheme ?? widget.data.color,
                        ),
                      ),
                      SizedBox(height: 5.hp),
                      Text(
                        widget.data.careInstructions,
                        style: PoppinsTextStyles.bodySmallRegular.copyWith(
                            color: CustomTheme.darkColor.withOpacity(0.8)),
                      ),
                      SizedBox(height: 10.hp),
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
}
