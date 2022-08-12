import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pixer/bloc/create_bloc.dart';
import 'package:pixer/repository/create_repo.dart';
import 'package:pixer/util/events.dart';
import 'package:pixer/widget/image_widget.dart';

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
  late TextEditingController textEditingController;
  final tags = [];

  @override
  void initState() {
    _repo = CreateRepo();

    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _bloc = CreateBloc(InitialState(), _repo);
        if (widget.file != null) {
          _bloc.add(GenerateLabelEvent(widget.file!));
        }
        return _bloc;
      },
      child: BlocConsumer<CreateBloc, CreateState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 3 / 5,
                    height: MediaQuery.of(context).size.width * 3 / 5,
                    child: ImageWidget(
                      file: widget.file,
                      onFileChanged: (file) {
                        widget.file = file;
                        _bloc.add(GenerateLabelEvent(widget.file!));
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                loading ? _placeholderWidget(context) : _hashtagList(context)
                /*SizedBox(
                        child: TextField(
                          maxLines: 100,
                          controller: textEditingController,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),*/
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is LabelState) {
            loading = true;
            BlocProvider.of<CreateBloc>(context)
                .add(FetchTagsEvent(state.labels));
          } else if (state is TagsFetched) {
            loading = false;
            tags.add(state.tags);
          }
        },
      ),
    );
  }

  Widget _placeholderWidget(BuildContext context) {
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

  Widget _hashtagList(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                ),
                color: Theme.of(context).backgroundColor.withOpacity(0.2)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                ListTile(
                  title: Text(
                    tags[index],
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      FeatherIcons.copy,
                      size: 20,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white.withOpacity(0.5)),
                  ),
                ),
              ],
            ));
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 20,
        );
      },
      itemCount: tags.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
