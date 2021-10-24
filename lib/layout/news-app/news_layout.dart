import 'package:apisecond/layout/news-app/cubit/cubit.dart';
import 'package:apisecond/layout/news-app/cubit/states.dart';
import 'package:apisecond/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

        var cubit = NewCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.search)) ,

              IconButton(
                  onPressed: (){
                    NewCubit.get(context).changeAppMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined ))
            ],
          ),

          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex ,
            items: cubit.bottomItems ,
            onTap: (index){
                  cubit.changeBottomNavBar(index);
            },
          ),

        );


  }
}
