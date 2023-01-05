import 'package:flutter/material.dart';
import 'package:mvk/constatnt/ui_constant.dart';
import 'package:mvk/views/components/music_list/music_items_list.dart';
import 'package:mvk/views/components/panel/music_panel.dart';
import 'package:mvk/views/components/slider_component.dart';

class MusicItemsListWithPanel extends StatelessWidget {
  const MusicItemsListWithPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: const [
            MusicItemsList(),
            MusicPanel(),
          ],
        ),
        Positioned(
          bottom: UiConstant.panelSize - UiConstant.sliderHeight / 2,
          width: MediaQuery.of(context).size.width,
          child: const SliderWidget(),
        ),
      ],
    );
  }
}
