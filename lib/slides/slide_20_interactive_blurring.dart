import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'dart:math';
import 'dart:async';

class Slide20 extends FlutterDeckSlideWidget {
  const Slide20()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/20',
            title: '20',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return _SlideContent();
      },
    );
  }
}

class _SlideContent extends StatelessWidget {
  const _SlideContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('What is a blur', style: TextStyles.title),
        const SizedBox(height: 20),
        Expanded(child: InteractiveMarioPixelArt()),
      ],
    );
  }
}

class InteractiveMarioPixelArt extends StatefulWidget {
  final double size;

  const InteractiveMarioPixelArt({Key? key, this.size = 400}) : super(key: key);

  @override
  _InteractiveMarioPixelArtState createState() =>
      _InteractiveMarioPixelArtState();
}

class _InteractiveMarioPixelArtState extends State<InteractiveMarioPixelArt> {
  final int gridSize = 16;
  List<List<Color>> blurredPixels =
      List.generate(16, (_) => List.filled(16, Colors.transparent));
  List<List<double>> _gaussianKernel = [
    [1 / 16, 1 / 8, 1 / 16],
    [1 / 8, 1 / 4, 1 / 8],
    [1 / 16, 1 / 8, 1 / 16]
  ];
  double _sigma = 0;
  int? selectedX;
  int? selectedY;
  String blurDetails = '';
  bool isBlurring = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildControls(),
        SizedBox(height: 20),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: MarioPixelArt(
                  size: widget.size,
                  onPixelTap: _handlePixelTap,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    GaussianKernelWidget(
                      onKernelChanged: (kernel, sigma) {
                        setState(() {
                          _gaussianKernel = kernel;
                          _sigma = sigma;
                        });
                      },
                    ),
                    Expanded(child: _buildOperationList()),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: BlurredMario(blurredPixels: blurredPixels),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: isBlurring ? null : _startBlurAnimation,
          child: Text('Blur All Pixels'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: _resetAllPixels,
          child: Text('Reset All'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: _randomlyBlurAllElements,
          child: Text('Random Blur'),
        ),
      ],
    );
  }

  void _resetAllPixels() {
    setState(() {
      tracker = BlurAnimationTracker();
      for (int y = 0; y < gridSize; y++) {
        for (int x = 0; x < gridSize; x++) {
          blurredPixels[y][x] = Colors.transparent;
        }
      }
    });
  }

  Future<void> _randomlyBlurAllElements() async {
    final int totalPixels = gridSize * gridSize;
    List<bool> blurredStatus = List.generate(totalPixels, (_) => false);
    List<int> unblurredIndices = List.generate(totalPixels, (index) => index);

    for (int iteration = 0; iteration < 10; iteration++) {
      await Future.delayed(const Duration(milliseconds: 200));

      setState(() {
        // Calculate how many pixels to blur in this iteration
        int pixelsToBlur = (totalPixels / 10).ceil();
        if (iteration == 9) {
          // In the last iteration, blur all remaining pixels
          pixelsToBlur = unblurredIndices.length;
        }

        // Randomly select pixels to blur
        for (int i = 0; i < pixelsToBlur && unblurredIndices.isNotEmpty; i++) {
          int randomIndex = Random().nextInt(unblurredIndices.length);
          int pixelIndex = unblurredIndices[randomIndex];
          int x = pixelIndex % gridSize;
          int y = pixelIndex ~/ gridSize;

          Color originalColor = MarioPainterGrid.getPixelColor(x, y);
          blurredPixels[y][x] = _applyGaussianBlur(x, y, originalColor);

          blurredStatus[pixelIndex] = true;
          unblurredIndices.removeAt(randomIndex);
        }
      });
    }
  }

  BlurAnimationTracker tracker = BlurAnimationTracker();

  void _startBlurAnimation() {
    setState(() {
      isBlurring = true;
    });

    int currentX = 0;
    int currentY = 0;

    Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (currentY >= gridSize) {
        timer.cancel();
        setState(() {
          isBlurring = false;
        });
        return;
      }

      setState(() {
        Color originalColor =
            MarioPainterGrid.getPixelColor(currentX, currentY);
        tracker.addSampling();

        blurredPixels[currentY][currentX] =
            _applyGaussianBlur(currentX, currentY, originalColor);
      });

      currentX++;
      if (currentX >= gridSize) {
        currentX = 0;
        currentY++;
      }
    });
  }

  // void _startBlurAnimation() {
  //   setState(() {
  //     isBlurring = true;
  //   });

  //   int currentX = 0;
  //   int currentY = 0;

  //   Timer.periodic(Duration(milliseconds: 10), (timer) {
  //     if (currentY >= gridSize) {
  //       timer.cancel();
  //       setState(() {
  //         isBlurring = false;
  //       });
  //       return;
  //     }

  //     setState(() {
  //       Color originalColor =
  //           MarioPainterGrid.getPixelColor(currentX, currentY);
  //       blurredPixels[currentY][currentX] =
  //           _applyGaussianBlur(currentX, currentY, originalColor);
  //     });

  //     currentX++;
  //     if (currentX >= gridSize) {
  //       currentX = 0;
  //       currentY++;
  //     }
  //   });
  // }

  void _handlePixelTap(int x, int y, Color originalColor) {
    setState(() {
      selectedX = x;
      selectedY = y;
      blurredPixels[y][x] = _applyGaussianBlur(x, y, originalColor);
    });
  }

  // Color _applyGaussianBlur(int x, int y, Color originalColor) {
  //   double redSum = 0;
  //   double greenSum = 0;
  //   double blueSum = 0;
  //   double alphaSum = 0;
  //   int operationCount = 0;
  //   int sigmaCount = 0;
  //   String details = '';

  //   for (int i = -1; i <= 1; i++) {
  //     for (int j = -1; j <= 1; j++) {
  //       int newX = x + i;
  //       int newY = y + j;

  //       if (newX >= 0 && newX < gridSize && newY >= 0 && newY < gridSize) {
  //         Color neighborColor = MarioPainterGrid.getPixelColor(newX, newY);
  //         double kernelValue = _gaussianKernel[i + 1][j + 1];

  //         redSum += neighborColor.red * kernelValue;
  //         greenSum += neighborColor.green * kernelValue;
  //         blueSum += neighborColor.blue * kernelValue;
  //         alphaSum += neighborColor.alpha * kernelValue;

  //         details += 'Pixel ($newX, $newY):\n';
  //         details +=
  //             '  R: ${neighborColor.red} * $kernelValue = ${neighborColor.red * kernelValue}\n';
  //         details +=
  //             '  G: ${neighborColor.green} * $kernelValue = ${neighborColor.green * kernelValue}\n';
  //         details +=
  //             '  B: ${neighborColor.blue} * $kernelValue = ${neighborColor.blue * kernelValue}\n';
  //         details +=
  //             '  A: ${neighborColor.alpha} * $kernelValue = ${neighborColor.alpha * kernelValue}\n';
  //         details += '  Sigma: $_sigma\n\n';

  //         operationCount += 4; // 4 multiplications per channel
  //         sigmaCount++;
  //       }
  //     }
  //   }

  //   details += 'Sum of weighted values:\n';
  //   details +=
  //       '  R: $redSum\n  G: $greenSum\n  B: $blueSum\n  A: $alphaSum\n\n';
  //   details += 'Final color (after rounding and clamping):\n';
  //   details += '  R: ${redSum.round().clamp(0, 255)}\n';
  //   details += '  G: ${greenSum.round().clamp(0, 255)}\n';
  //   details += '  B: ${blueSum.round().clamp(0, 255)}\n';
  //   details += '  A: ${alphaSum.round().clamp(0, 255)}\n\n';
  //   details +=
  //       'Total operations: $operationCount multiplications, 4 additions, 4 rounding, 4 clamping\n';
  //   details += 'Total sigma count: $sigmaCount\n';
  //   details += 'Sigma value: $_sigma';

  //   setState(() {
  //     blurDetails = details;
  //   });

  //   return Color.fromARGB(
  //     alphaSum.round().clamp(0, 255),
  //     redSum.round().clamp(0, 255),
  //     greenSum.round().clamp(0, 255),
  //     blueSum.round().clamp(0, 255),
  //   );
  // }

  Color _applyGaussianBlur(int x, int y, Color originalColor) {
    double redSum = 0;
    double greenSum = 0;
    double blueSum = 0;
    double alphaSum = 0;
    int operationCount = 0;
    int sigmaCount = 0;
    String details = '';

    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        int newX = x + i;
        int newY = y + j;

        if (newX >= 0 && newX < gridSize && newY >= 0 && newY < gridSize) {
          Color neighborColor = MarioPainterGrid.getPixelColor(newX, newY);
          tracker.addSampling(); // Track sampling operation

          double kernelValue = _gaussianKernel[i + 1][j + 1];

          redSum += neighborColor.red * kernelValue;
          greenSum += neighborColor.green * kernelValue;
          blueSum += neighborColor.blue * kernelValue;
          alphaSum += neighborColor.alpha * kernelValue;

          tracker.addMultiply(); // Track 4 multiplication operations
          tracker.addMultiply();
          tracker.addMultiply();
          tracker.addMultiply();

          details += 'Pixel ($newX, $newY):\n';
          details +=
              '  R: ${neighborColor.red} * $kernelValue = ${neighborColor.red * kernelValue}\n';
          details +=
              '  G: ${neighborColor.green} * $kernelValue = ${neighborColor.green * kernelValue}\n';
          details +=
              '  B: ${neighborColor.blue} * $kernelValue = ${neighborColor.blue * kernelValue}\n';
          details +=
              '  A: ${neighborColor.alpha} * $kernelValue = ${neighborColor.alpha * kernelValue}\n';
          details += '  Sigma: $_sigma\n\n';

          operationCount += 4; // 4 multiplications per channel
          sigmaCount++;
        }
      }
    }

    tracker.addSum(); // Track sum operation for each channel
    tracker.addSum();
    tracker.addSum();
    tracker.addSum();

    details += 'Sum of weighted values:\n';
    details +=
        '  R: $redSum\n  G: $greenSum\n  B: $blueSum\n  A: $alphaSum\n\n';
    details += 'Final color (after rounding and clamping):\n';
    details += '  R: ${redSum.round().clamp(0, 255)}\n';
    details += '  G: ${greenSum.round().clamp(0, 255)}\n';
    details += '  B: ${blueSum.round().clamp(0, 255)}\n';
    details += '  A: ${alphaSum.round().clamp(0, 255)}\n\n';
    details +=
        'Total operations: $operationCount multiplications, 4 additions, 4 rounding, 4 clamping\n';
    details += 'Total sigma count: $sigmaCount\n';
    details += 'Sigma value: $_sigma';

    setState(() {
      blurDetails = details;
    });

    // Track divide operations for final color calculation
    tracker.addDivide();
    tracker.addDivide();
    tracker.addDivide();
    tracker.addDivide();

    return Color.fromARGB(
      alphaSum.round().clamp(0, 255),
      redSum.round().clamp(0, 255),
      greenSum.round().clamp(0, 255),
      blueSum.round().clamp(0, 255),
    );
  }

  Widget _buildOperationList() {
    return ListView.builder(
      itemCount: tracker.operations.length,
      itemBuilder: (context, index) {
        BlurOperation operation = tracker.operations[index];
        return ListTile(
          title: Text('${operation.type}: ${operation.count}'),
          subtitle: Text(
              'Kernel Size: ${operation.kernelSize}x${operation.kernelSize}'),
        );
      },
    );
  }
}

class BlurredMario extends StatelessWidget {
  const BlurredMario({
    super.key,
    required this.blurredPixels,
  });

  final List<List<Color>> blurredPixels;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        itemCount: blurredPixels.length * blurredPixels[0].length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: blurredPixels.length,
        ),
        itemBuilder: (context, index) {
          int row = index ~/ blurredPixels.length;
          int col = index % blurredPixels.length;
          return Container(
            color: blurredPixels[row][col],
          );
        },
      ),
    );
  }
}

class MarioPixelArt extends StatelessWidget {
  final double size;
  final Function(int, int, Color) onPixelTap;

  const MarioPixelArt({
    super.key,
    required this.size,
    required this.onPixelTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: MarioPainterGrid(
        onTapGrid: onPixelTap,
      ),
    );
  }
}

class MarioPainterGrid extends StatelessWidget {
  static const int gridSize = 16;
  static const Map<int, Color> colorMapping = {
    0: Colors.white,
    1: Colors.black,
    2: Colors.red,
    3: Colors.brown,
    4: Colors.blue,
    5: Colors.yellow,
    6: Color(0xFFFFD700),
  };

  final Function(int x, int y, Color color)? onTapGrid;

  static Color getPixelColor(int x, int y) {
    if (x < 0 || x >= gridSize || y < 0 || y >= gridSize) {
      return Colors.transparent;
    }
    int index = y * gridSize + x;
    return colorMapping[pixelPattern[index]] ?? Colors.transparent;
  }

  const MarioPainterGrid({super.key, this.onTapGrid});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridSize,
      ),
      itemCount: gridSize * gridSize,
      itemBuilder: (context, index) {
        final int x = index % gridSize;
        final int y = index ~/ gridSize;
        final Color color = getPixelColor(x, y);

        return GestureDetector(
          onTap: () {
            if (onTapGrid != null) {
              onTapGrid!(x, y, color);
            }
          },
          child: Container(color: color),
        );
      },
    );
  }
}

const List<int> pixelPattern = [
  0,
  0,
  0,
  0,
  0,
  2,
  2,
  2,
  2,
  2,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  2,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  3,
  3,
  3,
  6,
  6,
  3,
  6,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  3,
  6,
  3,
  6,
  6,
  6,
  3,
  6,
  6,
  6,
  0,
  0,
  0,
  0,
  0,
  0,
  3,
  6,
  3,
  3,
  6,
  6,
  6,
  3,
  6,
  6,
  6,
  0,
  0,
  0,
  0,
  3,
  3,
  6,
  6,
  6,
  6,
  3,
  3,
  3,
  3,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  6,
  6,
  6,
  6,
  6,
  6,
  6,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  2,
  2,
  4,
  2,
  2,
  2,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  2,
  2,
  2,
  4,
  2,
  2,
  4,
  2,
  2,
  2,
  0,
  0,
  0,
  0,
  0,
  2,
  2,
  2,
  2,
  4,
  4,
  4,
  4,
  2,
  2,
  2,
  2,
  0,
  0,
  0,
  0,
  6,
  6,
  2,
  4,
  5,
  4,
  4,
  5,
  4,
  2,
  6,
  6,
  0,
  0,
  0,
  0,
  6,
  6,
  6,
  4,
  4,
  4,
  4,
  4,
  4,
  6,
  6,
  6,
  0,
  0,
  0,
  0,
  6,
  6,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  4,
  6,
  6,
  0,
  0,
  0,
  0,
  0,
  0,
  4,
  4,
  4,
  0,
  0,
  4,
  4,
  4,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  3,
  3,
  3,
  0,
  0,
  0,
  0,
  3,
  3,
  3,
  0,
  0,
  0,
  0,
  0,
  3,
  3,
  3,
  3,
  0,
  0,
  0,
  0,
  3,
  3,
  3,
  3,
  0,
  0,
  0,
];

class GaussianKernelWidget extends StatefulWidget {
  final Function(List<List<double>>, double) onKernelChanged;

  const GaussianKernelWidget({Key? key, required this.onKernelChanged})
      : super(key: key);

  @override
  _GaussianKernelWidgetState createState() => _GaussianKernelWidgetState();
}

class _GaussianKernelWidgetState extends State<GaussianKernelWidget> {
  int _kernelSize = 3;
  double _sigma = 1.0;
  late List<List<double>> _kernel;

  @override
  void initState() {
    super.initState();
    _updateKernel();
  }

  void _updateKernel() async {
    _kernel = _generateGaussianKernel(_kernelSize, _sigma);
    await Future.delayed(const Duration(milliseconds: 10));
    widget.onKernelChanged(_kernel, _sigma);
  }

  List<List<double>> _generateGaussianKernel(int size, double sigma) {
    List<List<double>> kernel =
        List.generate(size, (_) => List<double>.filled(size, 0));
    double sum = 0.0;
    int center = size ~/ 2;

    for (int y = 0; y < size; y++) {
      for (int x = 0; x < size; x++) {
        double value = (1 / (2 * pi * sigma * sigma)) *
            exp(-((x - center) * (x - center) + (y - center) * (y - center)) /
                (2 * sigma * sigma));
        kernel[y][x] = value;
        sum += value;
      }
    }

    // Normalize the kernel
    for (int y = 0; y < size; y++) {
      for (int x = 0; x < size; x++) {
        kernel[y][x] /= sum;
      }
    }

    return kernel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: GridView.builder(
            itemCount: _kernelSize * _kernelSize,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _kernelSize,
            ),
            itemBuilder: (context, index) {
              int x = index % _kernelSize;
              int y = index ~/ _kernelSize;
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    _kernel[y][x].toStringAsFixed(4),
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        Text('Kernel Size: $_kernelSize'),
        Slider(
          value: _kernelSize.toDouble(),
          min: 3,
          max: 7,
          divisions: 2,
          label: _kernelSize.toString(),
          onChanged: (value) {
            setState(() {
              _kernelSize = value.toInt();
              _updateKernel();
            });
          },
        ),
        Text('Sigma: ${_sigma.toStringAsFixed(2)}'),
        Slider(
          value: _sigma,
          min: 0.1,
          max: 2.0,
          divisions: 19,
          label: _sigma.toStringAsFixed(2),
          onChanged: (value) {
            setState(() {
              _sigma = value;
              _updateKernel();
            });
          },
        ),
      ],
    );
  }
}

class BlurOperation {
  final String type;
  final int count;
  final int kernelSize;

  BlurOperation(this.type, this.count, this.kernelSize);
}

class BlurAnimationTracker {
  List<BlurOperation> operations = [];
  int samplingCount = 0;
  int multiplyCount = 0;
  int sumCount = 0;
  int divideCount = 0;
  int currentKernelSize = 3; // Default kernel size

  void setKernelSize(int size) {
    currentKernelSize = size;
  }

  void addSampling() {
    samplingCount++;
    _updateOperation('Sampling', samplingCount);
  }

  void addMultiply() {
    multiplyCount++;
    _updateOperation('Multiplying', multiplyCount);
  }

  void addSum() {
    sumCount++;
    _updateOperation('Summing', sumCount);
  }

  void addDivide() {
    divideCount++;
    _updateOperation('Dividing', divideCount);
  }

  void _updateOperation(String type, int count) {
    int index = operations.indexWhere((op) => op.type == type);
    if (index != -1) {
      operations[index] = BlurOperation(type, count, currentKernelSize);
    } else {
      operations.add(BlurOperation(type, count, currentKernelSize));
    }
  }
}
