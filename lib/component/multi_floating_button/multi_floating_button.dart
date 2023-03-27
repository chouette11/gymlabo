import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/component/multi_floating_button/component/camera_button.dart';
import 'package:flutter_template/component/multi_floating_button/component/keyboard_button.dart';
import 'package:flutter_template/utils/constants/color_constant.dart';
import 'package:flutter_template/providers/presentation_providers.dart';
import 'dart:math' as math;

class MultiFloatingButton extends ConsumerStatefulWidget {
  const MultiFloatingButton({Key? key}) : super(key: key);

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends ConsumerState<MultiFloatingButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _controller = ref.watch(animationControllerProvider(this));
    final _open = ref.watch(isOpenFloatingButtonProvider);
    final _expandAnimation = ref.watch(expandAnimationProvider(_controller));
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          ..._buildExpandingActionButtons(this, _expandAnimation),
          AnimatedContainer(
            transformAlignment: Alignment.center,
            transform: Matrix4.rotationZ(_open ? -(0.5 * math.pi) : 0),
            duration: const Duration(milliseconds: 250),
            curve: const Interval(0.0, 0.5),
            child: AnimatedOpacity(
              opacity: _open ? 0.9 : 1.0,
              curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
              duration: const Duration(milliseconds: 250),
              child: SizedBox(
                height: 64,
                width: 64,
                child: FloatingActionButton(
                  backgroundColor: ColorConstant.purple40,
                  onPressed: () async {
                    ref
                        .read(isOpenFloatingButtonProvider.notifier)
                        .update((state) => !state);
                    if (_open) {
                      _controller.reverse();
                    } else {
                      _controller.forward();
                    }
                  },
                  child: Icon(_open ? Icons.close : Icons.add, size: 28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons(TickerProvider ticker, _expandAnimation) {
    final children = <Widget>[];
    final List<Widget> child = [KeyboardButton(ticker), CameraButton(ticker)];
    final count = child.length;
    for (var i = 0; i < count; i++,) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: 90,
          maxDistance: i == 0 ? 80 : 76 * (i + 1),
          progress: _expandAnimation,
          child: child[i],
        ),
      );
    }
    return children;
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 8.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
