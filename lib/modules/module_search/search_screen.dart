import 'package:apisecond/layout/news-app/cubit/cubit.dart';
import 'package:apisecond/layout/news-app/cubit/states.dart';
import 'package:apisecond/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewCubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state){

        var list = NewCubit.get(context).search ;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  onChanged: (value){

                    NewCubit.get(context).getSearch(value);
                  },
                  controller: searchController ,
                  keyboardType: TextInputType.text ,
                  style: TextStyle(color: NewCubit.get(context).isDark?  Colors.white : Colors.black ),
                  decoration: InputDecoration(
                      // fillColor: Colors.blue ,
                      // Colors.black38  ,
                      enabledBorder: OutlineInputBorder(),
                      focusColor:
                       Colors.black38 ,
                      focusedBorder: OutlineInputBorder(

                      ),
                      label: Text('Search'),
                      prefixIcon: Icon(Icons.search),
                      prefixStyle: TextStyle(color: Colors.grey )


                  ),
                  validator: ( value)
                  {
                    if(value!.isEmpty) return 'This is Field required !' ;
                    return null ;
                  },
                ),
              ) ,
              Expanded(child: ConditionalBuilder(

              condition: state is! NewsGetSearchLoadingState ,
              builder: (context) => ListView.separated(
              //to remove color appear at scroll
              physics: BouncingScrollPhysics(),
              itemBuilder: (context , index)=> buildArticalItem(list[index] , context ),
              separatorBuilder: (context , index)=> MyDivider(),
              itemCount: list.length),

              fallback: (context)=> Center(child: CircularProgressIndicator()),
              )
              // ListView.separated(
              //   //to remove color appear at scroll
              //     physics: BouncingScrollPhysics(),
              //     itemBuilder: (context , index)=> buildArticalItem(list[index] , context ),
              //     separatorBuilder: (context , index)=> MyDivider(),
              //     itemCount: list.length),
              // buildArticalItem(list , context)
              ) ,
            ],
          ),
        )   ;
      },

    );
  }
}
