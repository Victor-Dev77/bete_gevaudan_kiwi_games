import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/shared/shared.dart';

class Browse extends StatelessWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: MediaQuery.of(context).size.width <= 1250.0,
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: const [
          LandingCarourel(),
          HeightSpacer(50.0),
          GameRowList(),
          HeightSpacer(50.0),
          // if (screenWidth > 774) const BottomBar(),
        ],
      ),
    );
  }
}

class LandingCarourel extends GetView<BrowseController> {
  const LandingCarourel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: Get.width,
      height: screenWidth <= 600 ? Get.height * 0.9 : Get.height * 0.75,
      child: Obx(() => TabBarView(
            controller: controller.tabController,
            children: controller.carouselSlides
                .map(
                  (slide) => CarouselSlide(
                    name: slide.name,
                    catchPhrase: slide.catchPhrase,
                    description: slide.description,
                    imagePath: slide.imagePath,
                    isAvailable: slide.isAvailable,
                    gamePath: slide.gamePath,
                  ),
                )
                .toList(),
          )),
    );
  }
}

class CarouselSlide extends StatelessWidget {
  final String name;
  final String catchPhrase;
  final String description;
  final String imagePath;
  final String? gamePath;
  final bool isAvailable;

  const CarouselSlide({
    Key? key,
    required this.name,
    required this.catchPhrase,
    required this.description,
    required this.imagePath,
    this.gamePath,
    required this.isAvailable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      fit: StackFit.expand,
      children: [
        Image.asset(imagePath, fit: BoxFit.cover),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, backGroundColor.color],
            ),
          ),
        ),
        SlideText(
          name: name,
          catchPhrase: catchPhrase,
          description: description,
          available: isAvailable,
          gamePath: gamePath,
        ),
      ],
    );
  }
}

class SlideText extends GetView<BrowseController> {
  final String name;
  final String catchPhrase;
  final String description;
  final String? gamePath;
  final bool available;

  const SlideText({
    Key? key,
    required this.name,
    required this.catchPhrase,
    required this.description,
    this.gamePath,
    required this.available,
  }) : super(key: key);

  void launchGame() {
    if (gamePath != null) {
      controller.launchGame(gamePath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomButton = available
        ? ElevatedButton(
            child: Text('play'.tr),
            onPressed: launchGame,
          )
        : ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.grey,
              BlendMode.saturation,
            ),
            child: ElevatedButton(
              onPressed: null,
              child: Text('soon_available'.tr),
            ),
          );
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600.0),
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
        child: ListView(
          shrinkWrap: true,
          physics: MediaQuery.of(context).size.width > 340
              ? const NeverScrollableScrollPhysics()
              : null,
          children: [
            Text(
              name,
              style: Get.textTheme.headline5,
            ),
            Text(
              catchPhrase,
              style: Get.textTheme.headline6,
            ),
            const HeightSpacer(10.0),
            Text(
              description,
              maxLines: 20,
            ),
            Align(alignment: Alignment.bottomLeft, child: bottomButton),
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
      itemCount: 1,
      itemBuilder: (_, __) => GameRow(title: 'famous_games'.tr),
      separatorBuilder: (_, __) => const HeightSpacer(30.0),
    );
  }
}

class GameRow extends GetView<BrowseController> {
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
              itemCount: controller.gameList.length,
              separatorBuilder: (_, __) => const WidthSpacer(20.0),
              itemBuilder: (context, index) {
                final game = controller.gameList[index];
                return Game(
                  name: game.name,
                  imagePath: game.imagePath,
                  isAvailable: game.isAvailable,
                  gamePath: game.gamePath,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Game extends GetView<BrowseController> {
  final String name;
  final String imagePath;
  final String? gamePath;
  final bool isAvailable;

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
    required this.imagePath,
    required this.gamePath,
    required this.isAvailable,
  }) : super(key: key);

  void launchGame() {
    if (gamePath != null) {
      controller.launchGame(gamePath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double aspectRatio = MediaQuery.of(context).size.width <= 600 ? 1 : 16 / 9;
    return InkWell(
      onTap: isAvailable ? launchGame : null,
      borderRadius: borderRadius,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: boxShadow,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              if (!isAvailable) ...[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.75),
                      borderRadius: borderRadius),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text('soon_available'.tr),
                )
              ],
              Align(
                alignment: Alignment.center,
                child: Text(
                  name,
                  style: Get.textTheme.headline6?.copyWith(shadows: textShadow),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
