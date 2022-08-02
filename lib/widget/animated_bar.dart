import 'package:flutter/material.dart';
import 'package:pixer/theme/theme.dart';
import 'package:provider/provider.dart';

class AnimatedBar extends StatelessWidget {
  final AnimationController? animController;
  int position;
  int currentIndex;

  AnimatedBar({
    Key? key,
    @required this.animController,
    this.position = 0,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.grey.withOpacity(0.8)
                      : Colors.grey.withOpacity(0.2),
                  context
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                  animation: animController!,
                  builder: (context, child) {
                    return _buildContainer(
                      constraints.maxWidth * animController!.value,
                        Colors.grey.withOpacity(0.8),context
                    );
                  },
                )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color,BuildContext context) {
    return Container(
      height: 3.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
