import 'package:flutter/material.dart';
import 'package:mvk/views/components/timer_cheap/timer_cheap_details.dart';

class TimerCheap extends StatelessWidget {
  const TimerCheap({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      child: SizedBox(
        height: 30,
        width: 50,
        child: Container(
          color: Colors.white,
          child: const Center(
            child: TimerCheapDetails(),
          ),
        ),
      ),
    );
  }
}
