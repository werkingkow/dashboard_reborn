import 'package:dashboard_reborn/utils/colors.dart';
import 'package:dashboard_reborn/utils/page_transformer.dart';
import 'package:dashboard_reborn/utils/text_styles.dart';
import 'package:dashboard_reborn/utils/ui_helpers.dart';
import 'package:dashboard_reborn/widgets/parallax_cards.dart';
import 'package:dashboard_reborn/widgets/swiping_cards.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

List<String> swipingCardImages = [
  'assets/music/album6.jpg',
  'assets/music/album5.jpg',
  'assets/music/album4.jpg',
  'assets/music/album3.jpg',
  'assets/music/album2.jpg',
  'assets/music/album1.jpg',
];

List<String> swipingCardTitles = [
  'Random Access Memories',
  'Voicenotes',
  'Stargazing',
  'Night Visions',
  'In A Perfect World',
  'Native',
];

class ParallaxCardItem {
  ParallaxCardItem({
    required this.title,
    required this.body,
    required this.imagePath,
  });

  final String title;
  final String body;
  final String imagePath;
}

final parallaxCardItemsList = <ParallaxCardItem>[
  ParallaxCardItem(
    title: 'Blurryface',
    body: 'Twenty One Pilots',
    imagePath: 'assets/music/album8.jpg',
  ),
  ParallaxCardItem(
    title: 'Free Spirit',
    body: 'Khalid',
    imagePath: 'assets/music/album7.jpg',
  ),
  ParallaxCardItem(
    title: 'Overexposed',
    body: 'Maroon 5',
    imagePath: 'assets/music/album9.jpg',
  ),
];

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;
var gradientStartColor;
var gradientEndColor;
PageController controller =
    PageController(initialPage: swipingCardImages.length - 1);
var i = swipingCardImages.length - 1;

class MyGradientsPage extends StatefulWidget {
  @override
  _MyGradientsPageState createState() => _MyGradientsPageState();
}

class _MyGradientsPageState extends State<MyGradientsPage> {
  var currentPage = swipingCardImages.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(initialPage: swipingCardImages.length - 1);
    controller.addListener(
      () {
        setState(
          () {
            currentPage = controller.page!;
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              //gradient colors change according to set theme
              colors: isThemeCurrentlyDark(context)
                  ? [GradientColors.darkStart, GradientColors.darkEnd]
                  : [GradientColors.lightStart, GradientColors.lightEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  top: 50.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(EvaIcons.arrowIosBack),
                      tooltip: 'Go back',
                      color: isThemeCurrentlyDark(context)
                          ? MaterialColors.teal
                          : MyColors.light,
                      iconSize: 26.0,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    GradientText(
                      'Gradient Cards',
                      shaderRect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
                      gradient: isThemeCurrentlyDark(context)
                          ? Gradients.coldLinear
                          : Gradients
                              .haze, //gradient colors change according to set theme
                      style: isThemeCurrentlyDark(context)
                          ? TitleStylesDefault.white
                          : TitleStylesDefault.black,
                    ),
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  SwipingCards(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: swipingCardImages.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: SizedBox.fromSize(
                  size: Size.fromHeight(500.0),
                  child: PageTransformer(
                    pageViewBuilder: (context, visibilityResolver) {
                      return PageView.builder(
                        controller: PageController(viewportFraction: 0.85),
                        itemCount: parallaxCardItemsList.length,
                        itemBuilder: (context, index) {
                          final item = parallaxCardItemsList[index];
                          final pageVisibility =
                              visibilityResolver.resolvePageVisibility(index);

                          return ParallaxCards(
                            item: item,
                            pageVisibility: pageVisibility,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
