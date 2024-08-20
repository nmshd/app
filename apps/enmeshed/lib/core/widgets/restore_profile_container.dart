import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'restore_profile.dart';

class RestoreProfileContainer extends StatefulWidget {
  final List<LocalAccountDTO> accountsInDeletion;
  const RestoreProfileContainer({required this.accountsInDeletion, super.key});

  @override
  State<RestoreProfileContainer> createState() => _RestoreProfileContainerState();
}

class _RestoreProfileContainerState extends State<RestoreProfileContainer> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: CustomPaint(
          painter: _BackgroundPainter(
            backgroundColor: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.05),
            leftTriangleColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.3),
            rightTriangleColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const ClampingScrollPhysics(),
                    itemCount: widget.accountsInDeletion.length,
                    itemBuilder: (context, index) => RestoreProfile(
                      accountInDeletion: widget.accountsInDeletion[index],
                    ),
                  ),
                ),
                const Divider(),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: widget.accountsInDeletion.length,
                  effect: SlideEffect(dotHeight: 8, dotWidth: 8, activeDotColor: Theme.of(context).colorScheme.primary),
                  onDotClicked: (index) => _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final Color backgroundColor;
  final Color leftTriangleColor;
  final Color rightTriangleColor;

  _BackgroundPainter({
    required this.backgroundColor,
    required this.leftTriangleColor,
    required this.rightTriangleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final paint1 = Paint()
      ..color = leftTriangleColor
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = rightTriangleColor
      ..style = PaintingStyle.fill;

    final path1 = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height * 0.9)
      ..lineTo(0, size.height * 0.3)
      ..close();

    final path2 = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height * 0.9)
      ..lineTo(size.width, size.height * 0.3)
      ..close();

    canvas
      ..drawRect(Rect.fromLTRB(0, 0, size.width, size.height), backgroundPaint)
      ..drawPath(path1, paint1)
      ..drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
