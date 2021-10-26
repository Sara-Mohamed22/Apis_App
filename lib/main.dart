
import 'dart:io';

import 'package:apisecond/layout/news-app/cubit/cubit.dart';
import 'package:apisecond/layout/news-app/cubit/states.dart';
import 'package:apisecond/layout/news-app/news_layout.dart';
import 'package:apisecond/network/local/cash_helper.dart';
import 'package:apisecond/network/remote/dio_helper.dart';
import 'package:apisecond/shared/components/observer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


void main() async
{
  //method use when main is async
  WidgetsFlutterBinding.ensureInitialized() ;
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = MyBlocObserver();
  DioHelper.init() ;
   await CachHelper.init() ;

   var isdark = CachHelper.getData(key:'isDark');

  return runApp(MyApp(isdark));
}

class MyApp extends StatelessWidget {

  final bool? isDark ;
  MyApp(this.isDark) ;

  @override
  Widget build(BuildContext context) {
    return
    BlocProvider(create: (BuildContext context)=> NewCubit()..changeAppMode(fromShared:isDark)..getBusiness(),
      // MultiBlocProvider(
      //   providers: [
      //     BlocProvider(create: (context)=> NewCubit()..getBusiness() ),
      //     BlocProvider(
      //      create: (BuildContext context)=> NewCubit()..changeAppMode(fromShared:isDark) ,)
      //   ],
          child: BlocConsumer<NewCubit , NewsStates>
            (
            listener: (context , state){},
            builder: (context , state){
              return MaterialApp(
                  theme: ThemeData(
                      primarySwatch: Colors.deepOrange ,
                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                          backgroundColor: Colors.deepOrange
                      ),
                      appBarTheme: AppBarTheme(
                          titleSpacing: 20.0,
                          iconTheme: IconThemeData(color: Colors.black ),
                          backwardsCompatibility: false,
                          systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: Colors.white,
                            statusBarIconBrightness: Brightness.dark,


                          ),
                          backgroundColor: Colors.white ,
                          elevation: 0.0 ,
                          titleTextStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold ,
                              fontSize: 20.0
                          )

                      ) ,
                      scaffoldBackgroundColor: Colors.white ,
                      bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        type: BottomNavigationBarType.fixed ,
                        selectedItemColor: Colors.deepOrange ,
                        unselectedItemColor: Colors.grey ,
                        elevation: 20.0 ,
                        backgroundColor: Colors.white ,


                      ) ,

                      textTheme: TextTheme(
                          bodyText1: TextStyle(
                              fontWeight: FontWeight.w600 ,
                              fontSize: 18.0 ,
                              color: Colors.black
                          )
                      )


                  ),
                  debugShowCheckedModeBanner: false ,

                  darkTheme: ThemeData(
                      scaffoldBackgroundColor: HexColor('333739'),
                      primarySwatch: Colors.deepOrange ,
                      floatingActionButtonTheme: FloatingActionButtonThemeData(
                          backgroundColor: Colors.deepOrange
                      ),
                      appBarTheme: AppBarTheme(
                        titleSpacing: 20.0,
                          iconTheme: IconThemeData(color: Colors.white  ),
                          backwardsCompatibility: false,
                          systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: HexColor('333739') ,
                            statusBarIconBrightness: Brightness.light ,


                          ),
                          backgroundColor: HexColor('333739') ,
                          elevation: 0.0 ,
                          titleTextStyle: TextStyle(
                              color: Colors.white ,
                              fontWeight: FontWeight.bold ,
                              fontSize: 20.0
                          )

                      ) ,
                      bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        type: BottomNavigationBarType.fixed ,
                        selectedItemColor: Colors.deepOrange ,
                        unselectedItemColor: Colors.grey ,
                        elevation: 20.0 ,
                        backgroundColor: HexColor('333739'),

                      ),
                      textTheme: TextTheme(
                          bodyText1: TextStyle(
                              fontWeight: FontWeight.w600 ,
                              fontSize: 18.0 ,
                              color: Colors.white
                          )
                      )

                  ),


                  themeMode: NewCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light ,
                  home: NewsLayout()

                // Directionality(
                //    textDirection: TextDirection.rtl,
                //     child: NewsLayout()),
              );
            },

          ),

        );

  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}