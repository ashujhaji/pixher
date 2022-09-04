import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pixer/bloc/dashboard_bloc.dart';

import '../../model/categories.dart';
import '../../model/template.dart';
import '../../repository/dashboard_repo.dart';
import '../../widget/CustomShimmerWidget.dart';
import '../stories.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardRepo _repo = DashboardRepo.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(FeatherIcons.menu,color: Theme.of(context).textSelectionTheme.selectionColor,),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Pixher',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => DashboardBloc(InitialState(), _repo)
          ..add(FetchDashboardCategories()),
        child: BlocConsumer<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (_repo.categories != null) {
              return _categoriesList(context, _repo.categories, (category) {
                BlocProvider.of<DashboardBloc>(context)
                    .add(FetchTemplatesByCategory(category));
              });
            }
            return _placeholderWidget(context);
          },
          listener: (context, state) {
            if (state is CategoriesFetchedState) {
              if (state.categories != null) {
                _repo.categories = state.categories!;
              }
            } else if (state is TemplatesFetchedState) {
              state.category.templates = state.templates;
            }
          },
          buildWhen: (context, state) {
            return state is CategoriesFetchedState ||
                state is TemplatesFetchedState;
          },
        ),
      ),
    );
  }

  Widget _placeholderWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
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
      ),
    );
  }

  Widget _categoriesList(BuildContext context, List<Category> list,
      ValueChanged<Category> callForTemplate) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (list[index].templates == null) {
          callForTemplate(list[index]);
        }
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          title: Row(
            children: [
              Text(
                list[index].name.toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
              if(list[index].featured)
              Container(
                child: Text(
                  'Featured',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).highlightColor
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          subtitle: SizedBox(
            height: 220,
            child: list[index].templates == null
                ? _templatePlaceholderWidget(context)
                : _templateWidget(context, list[index]),
          ),
        );
      },
      itemCount: list.length,
      physics: const BouncingScrollPhysics(),
    );
  }

  Widget _templatePlaceholderWidget(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: CustomShimmerWidget(
            shimmerType: ShimmerType.story,
            enable: true,
          ),
        );
      },
      itemCount: 4,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget _templateWidget(BuildContext context, Category category) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: InkWell(
            child: AspectRatio(
              child: ClipRRect(
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      imageUrl:
                          category.templates![index].featuredMedia.toString(),
                    ),
                    if (category.templates![index].isNew)
                      Container(
                        child: Text(
                          'New',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontSize: 8,color: Colors.white,),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            /*color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.7),*/
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),),
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(2),
                      )
                  ],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              aspectRatio: category.templateDimension!.width! /
                  category.templateDimension!.height!,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(StoriesPage.tag, arguments: [category, index]);
            },
          ),
        );
      },
      itemCount: category.templates!.length,
      scrollDirection: Axis.horizontal,
    );
  }
}
