import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/presentation/additional_widgets/slide_nav_buttons.dart';
import 'package:presentation/scale_notifier.dart';
import 'package:presentation/util/context_extensions.dart';
import 'package:window_manager/window_manager.dart';

class BlankCanvas extends ConsumerStatefulWidget {
  final Widget body;
  const BlankCanvas({super.key, required this.body});

  @override
  ConsumerState<BlankCanvas> createState() => _BlankCanvasState();
}

class _BlankCanvasState extends ConsumerState<BlankCanvas> {
  final _focusNode = FocusNode();
  final _controller = TransformationController();
  bool _isTitleBarVisible = true;

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onKeyEvent(KeyEvent event) async {
    // debugPrint("$event");
    if (event.isHKey) {
      _isTitleBarVisible = !_isTitleBarVisible;
      await windowManager.setTitleBarStyle(
        _isTitleBarVisible ? TitleBarStyle.normal : TitleBarStyle.hidden,
      );
    } else if (event.isLeftArrow) {
      context.previousSlide();
    } else if (event.isRightArrow) {
      context.nextSlide();
    } else if (event.isCharAdd) {
      ref.read(scaleProvider.notifier).increase();
    } else if (event.isChardMinus) {
      ref.read(scaleProvider.notifier).decrease();
    } else if (event.isSpace) {
      ref.read(scaleProvider.notifier).reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (node, event) {
        _onKeyEvent(event);
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const .fromLTRB(32.0, 16.0, 32.0, 16.0),
            child: InteractiveViewer(
              transformationController: _controller,
              child: widget.body,
            ),
          ),
        ),
        bottomNavigationBar: const SlideNavButtons(),
      ),
    );
  }
}
