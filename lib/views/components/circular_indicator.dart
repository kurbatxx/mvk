import 'package:flutter/material.dart';
import 'package:mvk/constatnt/ui_constant.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox.square(
        dimension: UiConstant.circularProgressIndicatorSize,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
