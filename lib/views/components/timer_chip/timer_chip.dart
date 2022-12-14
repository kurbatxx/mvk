import 'package:flutter/material.dart';
import 'package:mvk/views/components/timer_chip/timer_chip_details.dart';

class TimerChip extends StatelessWidget {
  const TimerChip({super.key});

  @override
  Widget build(BuildContext context) {
    return const Chip(
      padding: EdgeInsets.all(2),
      backgroundColor: Colors.white,
      label: TimerCheapDetails(),
    );
  }
}
