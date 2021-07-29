import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List list = HomeCubit.get(context).searchList;
        return Scaffold(
            appBar: AppBar(
              title: Text('Search'),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      onChange: (value) {
                        HomeCubit.get(context).getSearch(q: value);
                      },
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'search must not be empty';
                        }
                        return null;
                      },
                      label: 'Search',
                      prefix: Icons.search),
                ),
                Expanded(
                    child: articlesBuilder(
                        list: list, context: context, isSearch: true)),
              ],
            ));
      },
    );
  }
}
