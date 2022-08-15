import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pixer/bloc/create_bloc.dart';
import 'package:pixer/repository/create_repo.dart';
import 'package:pixer/widget/expanded_section.dart';
import 'package:rich_text_controller/rich_text_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/theme_preference.dart';
import '../../widget/CustomShimmerWidget.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key? key}) : super(key: key);
  late ValueChanged<File> onFileChanged;
  File? file;

  @override
  State<StatefulWidget> createState() => _CreatePageState();

  void getLabels(File file) {
    this.file = file;
  }
}

class _CreatePageState extends State<CreatePage> {
  late CreateRepo _repo;
  late CreateBloc _bloc;
  bool loading = false;
  bool editing = false;
  RichTextController? textEditingController;
  final Map<String, bool> tags = {};
  Map<RegExp, TextStyle> patternHashtag = {
    RegExp("#[a-zA-Z]+"):
        const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)
  };
  String defaultCaption = 'write your caption here';
  bool switchState = false;
  SharedPreferences? preferences;

  @override
  void initState() {
    _repo = CreateRepo();
    SharedPreferences.getInstance().then((pref) {
      preferences = pref;
      switchState = pref.getBool(DarkThemePreference.CAPTION_ENABLE) ?? false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textEditingController ??= RichTextController(
      patternMatchMap: {
        RegExp("#[a-zA-Z]+"): Theme.of(context).textTheme.headline5!.copyWith(
              color: Theme.of(context)
                  .textSelectionTheme
                  .selectionColor!
                  .withOpacity(0.5),
            ),
        RegExp("myusername"): Theme.of(context).textTheme.headline5!.copyWith(
              color: Theme.of(context)
                  .textSelectionTheme
                  .selectionColor!
                  .withOpacity(0.5),
            ),
      },
      onMatch: (List<String> matches) {},
      deleteOnBack: false,
    );
    return BlocProvider(
      create: (context) {
        _bloc = CreateBloc(InitialState(), _repo);
        if (widget.file != null) {
          tags.clear();
          loading = true;
          editing = false;
          _bloc.add(GenerateLabelEvent(widget.file!));
        }
        return _bloc;
      },
      child: BlocConsumer<CreateBloc, CreateState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 3 / 7,
                      height: MediaQuery.of(context).size.width * 3 / 7,
                      child: widget.file == null
                          ? InkWell(
                              child: Container(
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 60,
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                                color: Colors.grey.withOpacity(0.4),
                              ),
                              onTap: () {
                                imgFromGallery().then((xFile) {
                                  if (xFile != null) {
                                    setState(() {
                                      widget.file = File(xFile.path);
                                    });
                                    _bloc.add(GenerateLabelEvent(widget.file!));
                                  }
                                }).onError((error, stackTrace) {
                                  debugPrint(error.toString());
                                });
                              },
                            )
                          : Container(
                              child: Stack(
                                children: [
                                  Center(
                                    child: Image.file(widget.file!),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: InkWell(
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            widget.file = null;
                                            editing = false;
                                            loading = false;
                                            tags.clear();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              color: Colors.grey.withOpacity(0.4),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  loading
                      ? _placeholderWidget(context)
                      : ExpandedSection(
                          expand: !editing,
                          child: tags.keys.isNotEmpty
                              ? _hashtagList(context, tags.keys.toList())
                              : Center(
                                  child: Padding(
                                  child: Text(
                                    '\n\n\n\nChoose your photo and get the top hashtags for you. Increase number of followers instantly',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: Colors.grey),
                                    textAlign: TextAlign.center,
                                  ),
                                  padding: const EdgeInsets.all(20),
                                )),
                        ),
                  ExpandedSection(
                    expand: editing,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: _editorWidget(context),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Visibility(
              child: _floatingButton(context),
              visible: tags.values.any(
                (element) => element == true,
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is LabelState) {
            loading = true;
            BlocProvider.of<CreateBloc>(context)
                .add(FetchCaption(state.labels));
            BlocProvider.of<CreateBloc>(context)
                .add(FetchTagsEvent(state.labels));
          } else if (state is TagsFetched) {
            loading = false;
            tags.addAll(state.tags);
          } else if (state is CaptionFetched) {
            if (state.caption.isNotEmpty) {
              _repo.captionList = state.caption.toString();
            }
          }
        },
      ),
    );
  }

  Widget _placeholderWidget(BuildContext context) {
    return CircularProgressIndicator();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        CustomShimmerWidget(
          enable: true,
          shimmerType: ShimmerType.shortText,
        ),
        SizedBox(
          height: 24,
        ),
        CustomShimmerWidget(
          enable: true,
          shimmerType: ShimmerType.longText,
        ),
        SizedBox(
          height: 24,
        ),
        CustomShimmerWidget(
          enable: true,
          shimmerType: ShimmerType.longLargeText,
        ),
        SizedBox(
          height: 24,
        ),
        CustomShimmerWidget(
          enable: true,
          shimmerType: ShimmerType.shortText,
        ),
        SizedBox(
          height: 24,
        ),
        CustomShimmerWidget(
          enable: true,
          shimmerType: ShimmerType.longText,
        ),
        SizedBox(
          height: 24,
        ),
        CustomShimmerWidget(
          enable: true,
          shimmerType: ShimmerType.longLargeText,
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }

  Widget _hashtagList(BuildContext context, List<dynamic> options) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pick from popular hashtags',
          style: theme.textTheme.subtitle1?.copyWith(
              color: theme.textTheme.subtitle1?.color?.withOpacity(0.7)),
        ),
        const SizedBox(
          height: 14,
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 16,
          children: options.map((item) {
            final index = options.indexOf(item);
            return InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: tags[item]! ? theme.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      color: tags[item]!
                          ? theme.primaryColor
                          : theme.primaryColor.withOpacity(0.4),
                      width: 2),
                ),
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Text(
                    item,
                    style: theme.textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: tags[item]!
                            ? Colors.white
                            : theme.bottomNavigationBarTheme.selectedItemColor),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  tags[item] = !tags[item]!;
                });
              },
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _editorWidget(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: CircleAvatar(
            child: CachedNetworkImage(
              imageUrl:
                  'https://gravatar.com/avatar/5cbd1bacf4212ff48c20ef30d3b1d420?s=400&d=robohash&r=x',
            ),
          ),

          /*Icon(
            FeatherIcons.user,
            color: Colors.white,
          ),*/
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: TextField(
            maxLines: 100,
            controller: textEditingController,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
          ),
        ),
      ],
    );
  }

  Widget _floatingButton(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 0,
            ),
            title: Text(
              editing
                  ? 'Post it on instagram now'
                  : 'Suggest me random caption',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
            ),
            leading: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (child, anim) => ScaleTransition(
                scale: child.key == const ValueKey('calender')
                    ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                    : Tween<double>(begin: 0.75, end: 1).animate(anim),
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: editing
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FeatherIcons.calendar,
                        key: ValueKey('calender'),
                        size: 22,
                      ),
                    )
                  : Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value: switchState,
                        onChanged: (value) {
                          setState(() {
                            switchState = value;
                          });
                          preferences?.setBool(
                              DarkThemePreference.CAPTION_ENABLE, value);
                        },
                        activeColor: Theme.of(context).unselectedWidgetColor,
                        thumbColor: switchState
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
            ),
            trailing: IconButton(
              onPressed: () {
                if (editing) {
                  //Copy text on clipboard
                  return;
                }
                tags.removeWhere((key, value) => value == false);
                textEditingController?.text =
                    'myusername  ${switchState ? _repo.captionList : defaultCaption}'
                    '\n.'
                    '\n.'
                    '\n.'
                    '\n.'
                    '\n.'
                    '\n.'
                    '\n${tags.keys.toList().join(' ')}';

                //tags.keys.toList().join(' ');
                setState(() {
                  editing = true;
                });
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: child.key == const ValueKey('icon1')
                      ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                      : Tween<double>(begin: 0.75, end: 1).animate(anim),
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: !editing
                    ? const Icon(
                        Icons.chevron_right,
                        key: ValueKey('icon1'),
                        size: 28,
                      )
                    : const Icon(
                        Icons.done,
                        key: ValueKey('icon2'),
                        size: 28,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<XFile?> imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    return image;
  }

  @override
  void dispose() {
    textEditingController?.dispose();
    super.dispose();
  }
}
