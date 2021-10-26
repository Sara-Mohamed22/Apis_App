import 'package:apisecond/layout/news-app/cubit/cubit.dart';
import 'package:apisecond/layout/news-app/cubit/states.dart';
import 'package:apisecond/modules/module_search/search_screen.dart';
import 'package:apisecond/network/remote/dio_helper.dart';
import 'package:apisecond/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

        return
          // BlocProvider(
          // create: (context)=> NewCubit()..getBusiness(),
          // child:
          BlocConsumer<NewCubit , NewsStates>(
            listener: ( context ,state  ){},
            builder: ( context , state ){
              return Scaffold(
                appBar: AppBar(
                  title: Text('News App'),
                  actions: [
                    IconButton(
                        onPressed: ()
                        {
                          NavigateTo(context, SearchScreen());
                        },
                        icon: Icon(Icons.search)) ,

                    IconButton(
                        onPressed: (){
                          NewCubit.get(context).changeAppMode();

                        },
                        icon: Icon(Icons.brightness_4_outlined ))
                  ],
                ),

                body: NewCubit.get(context).screens[NewCubit.get(context).currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: NewCubit.get(context).currentIndex ,
                  items: NewCubit.get(context).bottomItems ,
                  onTap: (index){
                    print('bottom index');
                    print(index);
                    NewCubit.get(context).changeBottomNavBar(index);
                  },
                ),

              ) ;
            },

          );


  }
}
