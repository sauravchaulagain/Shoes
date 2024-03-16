import 'package:flutter/material.dart';
import 'package:shoes/app/text_style.dart';
import 'package:shoes/common/shoes_data.dart';
import 'package:shoes/common/theme.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              stretch: true,
              elevation: 0,
              automaticallyImplyLeading: true,
              backgroundColor: Colors.transparent,
              expandedHeight: 360,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.blurBackground],
                background: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 60),
                      height: 360,
                      decoration: BoxDecoration(
                        color: widget.data.color,
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
                                widget.data.image,
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
            ),
            // SliverOverlapAbsorber(
            //   handle: SliverOverlapAbsorberHandle(),
            //   sliver: SliverAppBar(
            //     expandedHeight: 140.hp,
            //     elevation: 0,
            //     pinned: true,
            //     backgroundColor: Colors.transparent,
            //     flexibleSpace: FlexibleSpaceBar(
            //       background:
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: AnimatedContainer(
                decoration: BoxDecoration(
                    color: CustomTheme.lightColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    border: Border.all(color: widget.data.color)),
                margin: EdgeInsets.only(top: _padding),
                duration: const Duration(milliseconds: 700),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Column(
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
                                            builder: (context) =>
                                                ProductDetailWidget(
                                                  data: widget.data,
                                                )),
                                      );
                                    },
                                    icon: const Icon(Icons.close))
                              ],
                            ),
                            Text(
                              widget.data.brand,
                              style:
                                  PoppinsTextStyles.titleLargeRegular.copyWith(
                                fontWeight: FontWeight.w500,
                                color: CustomTheme.darkColor,
                              ),
                            ),
                            Text(
                              widget.data.title,
                              style: PoppinsTextStyles.bodyMediumRegular,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                            ),
                          ]),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        height: MediaQuery.of(context).size.height - 200,
                        child: ListView(
                          children: [
                            Text(
                              widget.data.desc,
                              style: PoppinsTextStyles.bodySmallRegular,
                            ),
                          ],
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
}
