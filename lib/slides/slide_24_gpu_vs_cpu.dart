import 'dart:math';

import 'package:a_closer_look_at_the_blur_effect/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide24 extends FlutterDeckSlideWidget {
  const Slide24()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/24',
            title: '24',
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
        Text('GPU vs CPU', style: TextStyles.title),
        const SizedBox(height: 20),
        Expanded(child: GPUvsCPUDemo()),
      ],
    );
  }
}

class GPUvsCPUDemo extends StatefulWidget {
  @override
  _GPUvsCPUDemoState createState() => _GPUvsCPUDemoState();
}

class _GPUvsCPUDemoState extends State<GPUvsCPUDemo>
    with TickerProviderStateMixin {
  final int gridSize = 10;
  List<List<Color>> gpuGrid = [];
  List<List<Color>> cpuGrid = [];
  late AnimationController _controller;
  int cpuCurrentRow = 0;
  int cpuCurrentCol = 0;

  @override
  void initState() {
    super.initState();
    _initializeGrids();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {
          _updateGrids();
        });
      });
    _controller.repeat();
  }

  void _initializeGrids() {
    gpuGrid = List.generate(
        gridSize, (_) => List.generate(gridSize, (_) => Colors.grey));
    cpuGrid = List.generate(
        gridSize, (_) => List.generate(gridSize, (_) => Colors.grey));
  }

  void _updateGrids() {
    // GPU: Update all cells simultaneously
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        gpuGrid[i][j] = _getRandomColor();
      }
    }

    // CPU: Update one cell at a time
    cpuGrid[cpuCurrentRow][cpuCurrentCol] = _getRandomColor();
    cpuCurrentCol++;
    if (cpuCurrentCol >= gridSize) {
      cpuCurrentCol = 0;
      cpuCurrentRow++;
      if (cpuCurrentRow >= gridSize) {
        cpuCurrentRow = 0;
      }
    }
  }

  Color _getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
        .withOpacity(1.0);
  }

  Widget _buildGrid(List<List<Color>> grid, String title) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ gridSize;
                int col = index % gridSize;
                return Container(color: grid[row][col]);
              },
              itemCount: gridSize * gridSize,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: _buildGrid(gpuGrid, 'GPU')),
                Expanded(child: _buildGrid(cpuGrid, 'CPU')),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'GPU updates all cells simultaneously,\nwhile CPU updates one cell at a time.',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
