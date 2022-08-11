import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixer/bloc/create_bloc.dart';
import 'package:pixer/repository/create_repo.dart';
import 'package:pixer/util/events.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key? key}) : super(key: key);
  late ValueChanged<File> onFileChanged;
  late File file;

  @override
  State<StatefulWidget> createState() => _CreatePageState();

  void getLabels(File file) {
    this.file = file;
  }
}

class _CreatePageState extends State<CreatePage> {
  late CreateRepo _repo;
  late CreateBloc _bloc;

  @override
  void initState() {
    _repo = CreateRepo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _bloc = CreateBloc(InitialState(), _repo);
        if (widget.file != null) {
          _bloc.add(GenerateLabelEvent(widget.file));
        }
        return _bloc;
      },
      child: BlocConsumer<CreateBloc, CreateState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
