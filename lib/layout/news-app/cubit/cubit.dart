
import 'package:apisecond/layout/news-app/cubit/states.dart';
import 'package:apisecond/modules/module.busines/business.screen.dart';
import 'package:apisecond/modules/module.science/science.screen.dart';
import 'package:apisecond/modules/module.settings/settings.screen.dart';
import 'package:apisecond/modules/module.sports/sport.screen.dart';
import 'package:apisecond/network/local/cash_helper.dart';
import 'package:apisecond/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCubit extends Cubit<NewsStates> {
  NewCubit() :super (NewsInitialState());

  static NewCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business
        ),
        label: 'Business'

    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports
        ),
        label: 'Sports'

    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science
        ),
        label: 'Science'

    ),

    // BottomNavigationBarItem(
    //     icon: Icon(Icons.settings
    //     ),
    //     label: 'Settings'
    //
    // ),

  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    SciencesScreen(),
    // SettingsScreen()
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    // if (index == 0) getBusiness() ;
    if (index == 1) getSports();
    if (index == 2) getScience();

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
///////////////////////////////////
  void getBusiness() {

    emit(NewsGetBusinessLoadingState());

     // if (business.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country': 'eg',
            'category': 'business',
            'apiKey': '0e2c0cf6512f4a7693d6a206df0efb51'
          })!.then((value) {
        business = value.data['articles'];
        print('businesssssss');
        print(business[0]['title']);
        print(value.data['totalResults'].toString());
        emit(NewsGetBusinessSucessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error: error.toString()));
      });
    // }
    // else
    //   {
    //     emit(NewsGetBusinessSucessState());
    //   }
  }


  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country': 'eg',
            'category': 'sports',
            'apiKey': '0e2c0cf6512f4a7693d6a206df0efb51'
          })!.then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        print(value.data['totalResults'].toString());
        emit(NewsGetSportsSucessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error: error.toString()));
      });
    }
    else {
      emit(NewsGetSportsSucessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country': 'eg',
            'category': 'science',
            'apiKey': '0e2c0cf6512f4a7693d6a206df0efb51'
          })!.then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        print(value.data['totalResults'].toString());
        emit(NewsGetScienceSucessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error: error.toString()));
      });
    }

    else {
      emit(NewsGetScienceSucessState());
    }
  }


  bool isDark = false;

  ThemeMode appMode = ThemeMode.dark;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    }
    else {
      isDark = !isDark;
      CachHelper.putData(key: 'isDark', value: isDark).
      then((value) {
        print(CachHelper.getData(key: 'isDark'));
        emit(AppChangeModeState());
      });
    }
  }



   List<dynamic> search = [] ;

   void getSearch(String value)
  {
    search=[] ;
    emit(NewsGetSearchLoadingState()) ;

    if(search.length ==0 )
    {
      DioHelper.getData(
          url:'v2/everything',
          query:
          {
            'q':'${value}' ,
            'apiKey':'0e2c0cf6512f4a7693d6a206df0efb51'
          })!.then((value){
            print('data search::: ${value}');
        search = value.data['articles'] ;
        print(search[0]['title']);
        print(value.data['totalResults'].toString());

        emit(NewsGetSearchSucessState());
      }).catchError((error){
        print('error in search');
        print(error.toString());
        emit(NewsGetSearchErrorState(error: error.toString() ));
      });

    }
  }


}