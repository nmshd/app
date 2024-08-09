import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timeago/timeago.dart' as timeago;

import '/core/core.dart';
import 'info_container.dart';

enum TypeOfNews { newFuncion, information, problem }

class NewsContainer extends StatefulWidget {
  final List<News> news;
  const NewsContainer({required this.news, super.key});

  factory NewsContainer.debugPrefilled() {
    final news = [
      const News(
        typeOfNews: TypeOfNews.newFuncion,
        description: 'kurzer Beschreibungstext zur neuen Funktion',
        dateTime: '2023-07-13T12:34:56Z',
      ),
      const News(
        typeOfNews: TypeOfNews.information,
        description: 'kurzer Beschreibungstext zur allgemeinen Information',
        dateTime: '2023-07-12T12:34:56Z',
      ),
      const News(
        typeOfNews: TypeOfNews.problem,
        description: 'kurzer Beschreibungstext zum Ausfall oder zum Problem',
        dateTime: '2023-07-11T12:34:56Z',
      ),
    ];
    return NewsContainer(news: news);
  }

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(context.l10n.home_news, style: Theme.of(context).textTheme.titleLarge),
            TextButton(
              onPressed: () => showNotImplementedDialog(context),
              child: Text(context.l10n.home_seeAll),
            ),
          ],
        ),
        Gaps.h8,
        InfoContainer(
          child: Column(
            children: [
              SizedBox(
                height: 80,
                width: double.infinity,
                child: PageView(
                  controller: _pageController,
                  physics: const ClampingScrollPhysics(),
                  children: widget.news,
                ),
              ),
              Gaps.h16,
              SmoothPageIndicator(
                controller: _pageController,
                count: widget.news.length,
                effect: SlideEffect(dotHeight: 8, dotWidth: 8, activeDotColor: Theme.of(context).colorScheme.primary),
                onDotClicked: (index) => _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn),
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => showNotImplementedDialog(context),
                    child: Text(context.l10n.home_notNow),
                  ),
                  Gaps.w8,
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      side: BorderSide(color: Theme.of(context).colorScheme.outline),
                    ),
                    onPressed: () => showNotImplementedDialog(context),
                    child: Text(context.l10n.home_discoverNow),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class News extends StatelessWidget {
  final TypeOfNews typeOfNews;
  final String description;
  final String dateTime;
  const News({required this.typeOfNews, required this.description, required this.dateTime, super.key});

  @override
  Widget build(BuildContext context) {
    final icon = switch (typeOfNews) {
      TypeOfNews.newFuncion =>
        IconContainer(color: Theme.of(context).colorScheme.primary, icon: Icon(Icons.lightbulb, color: Theme.of(context).colorScheme.onPrimary)),
      TypeOfNews.information =>
        IconContainer(color: Theme.of(context).colorScheme.primary, icon: Icon(Icons.info, color: Theme.of(context).colorScheme.onPrimary)),
      TypeOfNews.problem =>
        IconContainer(color: Theme.of(context).colorScheme.error, icon: Icon(Icons.warning_rounded, color: Theme.of(context).colorScheme.onPrimary)),
    };

    final title = switch (typeOfNews) {
      TypeOfNews.newFuncion => context.l10n.home_newFunction,
      TypeOfNews.information => context.l10n.home_generalInformation,
      TypeOfNews.problem => context.l10n.home_problem,
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        Gaps.w16,
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.left),
                  Text(
                    timeago.format(DateTime.parse(dateTime), locale: Localizations.localeOf(context).languageCode),
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
              Gaps.h4,
              Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}

class IconContainer extends StatelessWidget {
  final Color color;
  final Icon icon;
  const IconContainer({required this.color, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: icon,
    );
  }
}
