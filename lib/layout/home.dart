import 'package:flutter/material.dart';
import 'package:news_app/modules/search/searchScreen.dart';
import 'package:news_app/shared/Network/local/sharedPreferences.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 20,
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  }),
              IconButton(
                  icon: Icon(
                    Icons.brightness_4_outlined,
                  ),
                  onPressed: () {
                    AppCubit.get(context).changeThemeMode();
                  })
            ],
            title: Text('News App'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (value) => cubit.changeBottomNavBar(value),
            items: HomeCubit.get(context).bottomNavBarItems,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
