import 'dart:ui';

import 'package:a_closer_look_at_the_blur_effect/slides/slide_30_box_blur.dart';
import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class Slide17 extends FlutterDeckSlideWidget {
  const Slide17()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/17',
            title: '17',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    const code = '''
class _AppCardState extends State<AppCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        onEnter: (event) => setState(() => isHovering = true),
        onExit: (event) => setState(() => isHovering = false),
        child: Card(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned.fill(
                child: Image.network(
                  widget.dataModel.url,
                  width: double.infinity,
                  height: 250.0,
                  fit: BoxFit.cover,
                ),
              ),
              if (isHovering) // Show blur only on hover
                Positioned(
                  bottom: -95,
                  left: 0,
                  right: 0,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.compose(
                      outer: ImageFilter.blur(
                        sigmaY: 20,
                        sigmaX: 20,
                        tileMode: TileMode.decal,
                      ),
                      inner: ImageFilter.blur(
                        sigmaX: 20 + 50,
                        sigmaY: 10 + 50,
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 0.2,
                          child: Image.network(
                            widget.dataModel.url,
                            height: 250.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.dataModel.title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      widget.dataModel.desc,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}''';
    return FlutterDeckSlide.custom(
      builder: (context) {
        // return const _SlideContent();
        return ShowCustomBlur(
          title: "Smoth edge blur",
          codeWidget: SyntaxView(
            code: code,
            syntax: Syntax.DART,
            syntaxTheme: SyntaxTheme.vscodeDark(),
            fontSize: 22.0,
            withZoom: false,
            expanded: true,
            selectable: false,
          ),
          shaderWidget: const CombineBlurs(),
        );
      },
    );
  }
}

// class _SlideContent extends StatelessWidget {
//   const _SlideContent();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text('Smooth Edges', style: TextStyles.title),
//         const SizedBox(height: 20),
//         ShaderWidget(name: name)
//         Expanded(child: CombineBlurs())
//       ],
//     );
//   }
// }

class CombineBlurs extends StatefulWidget {
  const CombineBlurs({super.key});

  @override
  State<CombineBlurs> createState() => _CombineBlursState();
}

class _CombineBlursState extends State<CombineBlurs> {
  List<DataModel> dummyDataList = [
    DataModel(
        title: 'Modern Artistic Living Room',
        desc:
            'A white contemporary sofa adorned with earth-toned cushions, bold abstract wall art, a sleek black marble fireplace, and an eclectic collection of sculptural pieces in a sophisticated living space.',
        url: 'https://i.imgur.com/sHuAqc7.png'),
    DataModel(
        title: 'Elegant Gift Tower',
        desc:
            'A stack of glittering gold and deep red gift boxes tied with satin ribbons against a soft glowing light backdrop, symbolizing luxury and festivity.',
        url: 'https://i.imgur.com/u8KRGK2.png'),
    DataModel(
        title: 'Assorted Tartlets Platter',
        desc:
            'A delectable assortment of tartlets with flaky crusts, topped with chocolate ganache, fresh berries, and powdered sugar, offering a tempting variety of flavors.',
        url: 'https://i.imgur.com/SohsdwI.png'),
    DataModel(
        title: 'Citrus Symphony',
        desc:
            'An up-close display of citrus slices with water droplets, showcasing the fresh pulp and vibrant colors of limes, oranges, and lemons arranged in a pleasing pattern.',
        url: 'https://i.imgur.com/REutjjm.png')
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 10, // Space between columns
        mainAxisSpacing: 10, // Space between rows
        childAspectRatio: 1.7,
      ),
      itemCount: dummyDataList.length,
      itemBuilder: (context, index) {
        final item = dummyDataList[index];
        return AppCard(dataModel: item);
      },
    );
  }
}

class DataModel {
  final String title;
  final String desc;
  final String url;

  DataModel({required this.title, required this.desc, required this.url});
}

class AppCard extends StatefulWidget {
  const AppCard({
    Key? key,
    required this.dataModel,
  }) : super(key: key);

  final DataModel dataModel;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        onEnter: (event) => setState(() => isHovering = true),
        onExit: (event) => setState(() => isHovering = false),
        child: Card(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned.fill(
                child: Image.network(
                  widget.dataModel.url,
                  width: double.infinity,
                  height: 250.0,
                  fit: BoxFit.cover,
                ),
              ),
              if (isHovering) // Show blur only on hover
                Positioned(
                  bottom: -95,
                  left: 0,
                  right: 0,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.compose(
                      outer: ImageFilter.blur(
                        sigmaY: 20,
                        sigmaX: 20,
                        tileMode: TileMode.decal,
                      ),
                      inner: ImageFilter.blur(
                        sigmaX: 20 + 50,
                        sigmaY: 10 + 50,
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 0.2,
                          child: Image.network(
                            widget.dataModel.url,
                            height: 250.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.dataModel.title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      widget.dataModel.desc,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
