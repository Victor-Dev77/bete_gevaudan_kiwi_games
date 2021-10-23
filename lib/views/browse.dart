import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/shared/shared.dart';

class Browse extends StatelessWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: MediaQuery.of(context).size.width <= 1250.0,
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          const LandingCarourel(),
          const HeightSpacer(30.0),
          const GameRowList(),
          const HeightSpacer(50.0),
          if (screenWidth > 774) const BottomBar(),
        ],
      ),
    );
  }
}

class LandingCarourel extends GetView<TabBarController> {
  const LandingCarourel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: Get.width,
      height: screenWidth <= 600 ? Get.width : Get.height * 0.75,
      child: TabBarView(
        controller: controller.tabController,
        children: const [
          CarouselSlide(),
          CarouselSlide(),
          CarouselSlide(),
        ],
      ),
    );
  }
}

class CarouselSlide extends StatelessWidget {
  const CarouselSlide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      fit: StackFit.expand,
      children: const [
        CustomNetworkImage(
          url: 'https://source.unsplash.com/random',
        ),
        SlideText(),
      ],
    );
  }
}

class SlideText extends StatelessWidget {
  const SlideText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600.0),
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'game name',
              style: Get.textTheme.headline5,
            ),
            const HeightSpacer(10.0),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut malesuada quam sit amet sodales elementum. Praesent dapibus mi turpis, quis blandit nunc venenatis in. Suspendisse viverra lectus a ullamcorper tincidunt.',
              maxLines: 10,
            ),
            const HeightSpacer(25.0),
            ElevatedButton(
              child: Text('play'.tr),
              onPressed: () => print('play game'),
            ),
          ],
        ),
      ),
    );
  }
}

class GameRowList extends StatelessWidget {
  const GameRowList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (_, index) => GameRow(title: 'Row number $index'),
      separatorBuilder: (_, __) => const HeightSpacer(30.0),
    );
  }
}

class GameRow extends StatelessWidget {
  final String title;

  const GameRow({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Get.textTheme.headline6),
          const HeightSpacer(15.0),
          Expanded(
            child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              separatorBuilder: (_, __) => const WidthSpacer(20.0),
              itemBuilder: (context, index) {
                return const Game(
                  name: 'Game name',
                  imageUrl: 'https://source.unsplash.com/random',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Game extends StatelessWidget {
  final String name;
  final String imageUrl;

  static final BorderRadius borderRadius = BorderRadius.circular(5.0);
  static final List<Shadow> textShadow = [
    Shadow(
      offset: Offset.zero,
      blurRadius: 5.0,
      color: textShadowColor.color,
    ),
  ];

  static final List<BoxShadow> boxShadow = [
    BoxShadow(
      offset: const Offset(0, 10.0),
      blurRadius: 20.0,
      color: gameShadowColor.color,
    ),
  ];

  const Game({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double aspectRatio = MediaQuery.of(context).size.width <= 600 ? 1 : 16 / 9;
    return InkWell(
      onTap: () => print('selcted game'),
      borderRadius: borderRadius,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: boxShadow,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              name,
              style: Get.textTheme.headline6?.copyWith(shadows: textShadow),
            ),
          ),
        ),
      ),
    );
  }
}
