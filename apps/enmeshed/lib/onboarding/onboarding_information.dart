import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '/core/core.dart';
import 'widgets/red_shrinked_divider.dart';

class OnboardingInformation extends StatefulWidget {
  final VoidCallback goToOnboardingLegalTexts;

  const OnboardingInformation({required this.goToOnboardingLegalTexts, super.key});

  @override
  State<OnboardingInformation> createState() => _OnboardingInformationState();
}

class _OnboardingInformationState extends State<OnboardingInformation> {
  late PageController _pageController;
  int _currentPageIndex = 0;

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
    final pages = [
      _OnboardingPage(
        title: context.l10n.onboarding_info_titlePage1,
        description: context.l10n.onboarding_info_descriptionPage1,
        imagePath: 'assets/svg/onboarding1.svg',
        leftTriangleColor: Theme.of(context).colorScheme.secondary.withOpacity(0.04),
        rightTriangleColor: Theme.of(context).colorScheme.primary.withOpacity(0.04),
        bottomColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
      ),
      _OnboardingPage(
        title: context.l10n.onboarding_info_titlePage2,
        description: context.l10n.onboarding_info_descriptionPage2,
        imagePath: 'assets/svg/onboarding2.svg',
        leftTriangleColor: Theme.of(context).colorScheme.secondary.withOpacity(0.04),
        rightTriangleColor: Theme.of(context).colorScheme.primary.withOpacity(0.04),
        bottomColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
      ),
      _OnboardingPage(
        title: context.l10n.onboarding_info_titlePage3,
        description: context.l10n.onboarding_info_descriptionPage3,
        imagePath: 'assets/svg/onboarding3.svg',
        leftTriangleColor: Theme.of(context).colorScheme.secondary.withOpacity(0.04),
        rightTriangleColor: Theme.of(context).colorScheme.primary.withOpacity(0.04),
        bottomColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
      ),
    ];

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) => setState(() => _currentPageIndex = value),
              physics: const ClampingScrollPhysics(),
              children: pages,
            ),
          ),
          Container(
            height: 80,
            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
            child: Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 6, bottom: MediaQuery.viewInsetsOf(context).bottom + 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    visible: _currentPageIndex < pages.length - 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: widget.goToOnboardingLegalTexts,
                        child: Text(context.l10n.skip),
                      ),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: pages.length,
                    effect: SlideEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: Theme.of(context).colorScheme.primary,
                      dotColor: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    onDotClicked: (index) {
                      _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton(
                      onPressed: _currentPageIndex == pages.length - 1
                          ? widget.goToOnboardingLegalTexts
                          : () => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn),
                      child: Text(context.l10n.next),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color leftTriangleColor;
  final Color rightTriangleColor;
  final Color bottomColor;

  const _OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.leftTriangleColor,
    required this.rightTriangleColor,
    required this.bottomColor,
  });

  @override
  State<_OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<_OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final textWidth = _calculateTextWidth(widget.title, textStyle, screenWidth - 48);

    return Stack(
      children: [
        CustomPaint(
          painter: _BackgroundPainter(
            leftTriangleColor: widget.leftTriangleColor,
            rightTriangleColor: widget.rightTriangleColor,
            bottomColor: widget.bottomColor,
          ),
          size: Size.infinite,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight / 2,
                child: VectorGraphic(loader: AssetBytesLoader(widget.imagePath)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 56),
                    Text(widget.title, style: textStyle),
                    Gaps.h16,
                    RedShrinkedDivider(width: textWidth),
                    Gaps.h40,
                    Text(widget.description),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _calculateTextWidth(String text, TextStyle style, double maxWidth) {
    final words = text.split(' ');
    var lineWidth = 0.0;
    var maxLineWidth = 0.0;

    for (final word in words) {
      final wordWidth = _calculateWordWidth(word, style);

      if (lineWidth + wordWidth <= maxWidth) {
        lineWidth += wordWidth;
      } else {
        maxLineWidth = max(maxLineWidth, lineWidth);
        lineWidth = wordWidth;
      }
    }

    return max(maxLineWidth, lineWidth);
  }

  double _calculateWordWidth(String text, TextStyle style) {
    final textPainter = TextPainter(text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)..layout();
    return textPainter.size.width;
  }
}

class _BackgroundPainter extends CustomPainter {
  final Color leftTriangleColor;
  final Color rightTriangleColor;
  final Color bottomColor;

  _BackgroundPainter({
    required this.leftTriangleColor,
    required this.rightTriangleColor,
    required this.bottomColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = leftTriangleColor
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = rightTriangleColor
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = bottomColor
      ..style = PaintingStyle.fill;

    final path1 = Path()
      ..moveTo(0, size.height * 0.54)
      ..lineTo(size.width / 2, size.height * 0.475)
      ..lineTo(0, size.height * 0.41)
      ..close();

    final path2 = Path()
      ..moveTo(size.width, size.height * 0.54)
      ..lineTo(size.width / 2, size.height * 0.475)
      ..lineTo(size.width, size.height * 0.41)
      ..close();

    final path3 = Path()
      ..moveTo(0, size.height * 0.54)
      ..lineTo(size.width / 2, size.height * 0.475)
      ..lineTo(size.width, size.height * 0.54)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas
      ..drawPath(path1, paint1)
      ..drawPath(path2, paint2)
      ..drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
