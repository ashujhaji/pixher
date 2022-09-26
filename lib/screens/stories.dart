import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixer/screens/playground.dart';

import '../model/categories.dart';
import '../model/template.dart';
import '../widget/animated_bar.dart';

class StoriesPage extends StatefulWidget {
  static const tag = 'StoriesPage';

  final Category? category;
  int currentPage;

  StoriesPage({Key? key, @required this.category, this.currentPage = 0})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _StoriesPageState(category!.templates!);
}

class _StoriesPageState extends State<StoriesPage>
    with TickerProviderStateMixin {
  PageController? _pageController;
  final List<Template> templates;
  AnimationController? _animController;

  _StoriesPageState(this.templates);

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.currentPage);
    _animController = AnimationController(vsync: this);
    _animController?.duration = const Duration(seconds: 5);
    _animController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController?.stop();
        _animController?.reset();
        if (widget.category!.templates!.length - 1 > widget.currentPage) {
          //Pages remains in current story
          setState(() {
            widget.currentPage = widget.currentPage + 1;
          });
        } else {
          Navigator.of(context).pop();
        }
        _animController?.forward();
        _pageController?.animateToPage(widget.currentPage,
            duration: const Duration(milliseconds: 700),
            curve: Curves.fastOutSlowIn);
      }
    });
    _animController?.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details),
        onPanUpdate: (details) {
          if (details.delta.dy > 0) {
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: List<Widget>.generate(templates.length, (index) {
                return AspectRatio(
                  aspectRatio: widget.category!.templateDimension!.width! /
                      widget.category!.templateDimension!.height!,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 5),
                    child: CachedNetworkImage(
                      imageUrl: templates[index].featuredMedia.toString(),
                    ),
                  ),
                );
              }),
              onPageChanged: (index) {
                /*setState(() {
                  _currentPageIndex = index;
                });*/
              },
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 10.0,
              right: 10.0,
              child: Row(
                children: templates.map<Widget>((e) {
                  final i = templates.indexOf(e);
                  return AnimatedBar(
                    animController: _animController,
                    position: i,
                    currentIndex: widget.currentPage,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),),
          child: Text(
            'Use this template',
            style: Theme.of(context).textTheme.headline6?.copyWith(
              color: Colors.white
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(PlaygroundPage.tag,
          arguments: [
            widget.category?.templateDimension,
            templates[widget.currentPage],
          ]);
        },
      ),
    );
  }

  void _onTapDown(TapDownDetails tapDownDetails) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dx = tapDownDetails.globalPosition.dx;
    if (dx < screenWidth / 3) {
      //Left tap
      _animController?.stop();
      _animController?.reset();
      if (widget.currentPage > 0) {
        setState(() {
          widget.currentPage--;
        });
      } else {
        setState(() {
          widget.currentPage = 0;
        });
      }
      _pageController?.animateToPage(widget.currentPage,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
      _animController?.forward();
    } else if (dx > 2 * screenWidth / 3) {
      //Right tap
      _animController?.stop();
      _animController?.reset();
      if (widget.category!.templates!.length - 1 > widget.currentPage) {
        setState(() {
          widget.currentPage++;
        });
      } else {
        setState(() {
          widget.currentPage = 0;
        });
      }
      _pageController?.animateToPage(widget.currentPage,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
      _animController?.forward();
    } else {
      //Center tap
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _animController?.dispose();
    super.dispose();
  }
}
