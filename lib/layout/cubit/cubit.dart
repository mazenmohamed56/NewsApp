import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/shared/Network/remote/DioHelper.dart';

import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/modules/sports/sports.dart';

import 'package:news_app/modules/science/science.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(label: 'Business', icon: Icon(Icons.business)),
    BottomNavigationBarItem(
        label: 'Sports', icon: Icon(Icons.sports_soccer_outlined)),
    BottomNavigationBarItem(label: 'Science', icon: Icon(Icons.science)),
  ];
  List<Widget> screens = [BusinesScreen(), SportScreen(), ScienceScreen()];
  void changeBottomNavBar(index) {
    currentIndex = index;
    if (index == 1)
      getdata(category: 'sports');
    else if (index == 2) getdata(category: 'science');
    emit(ChangeBottomNavState());
  }

  List<dynamic> list;
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  void getdata({String category = 'business'}) {
    if ((category == 'sports' && sports.length == 0) ||
        (category == 'science' && science.length == 0) ||
        (category == 'business' && business.length == 0)) {
      emit(LoadindDataFromApiState());
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'gb',
        'category': '$category',
        'apiKey': 'a8952493d0cd479b8b2342b5767e7304'
      }).then((value) {
        list = value.data['articles'];
        if (category == 'sports')
          sports = list;
        else if (category == 'science')
          science = list;
        else
          business = list;

        print(list[0]['title']);
        print(value.data['totalResults']);
        emit(GetDataFromApiSuccessState());
      }).catchError((error) {
        print(error);
        emit(GetDataFromApiErrorState());
      });
    } else
      emit(GetDataFromApiSuccessState());
  }

  List<dynamic> searchList = [];
  void getSearch({String q}) {
    emit(LoadindDataFromApiState());
    DioHelper.getData(
            url: 'v2/everything',
            query: {'q': '$q', 'apiKey': 'a8952493d0cd479b8b2342b5767e7304'})
        .then((value) {
      searchList = value.data['articles'];

      emit(GetSearchedDataFromApiSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetSearchedDataFromApiErrorState());
    });

    emit(GetSearchedDataFromApiSuccessState());
  }
}
