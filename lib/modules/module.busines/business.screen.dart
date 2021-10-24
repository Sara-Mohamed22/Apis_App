import 'package:apisecond/layout/news-app/cubit/cubit.dart';
import 'package:apisecond/layout/news-app/cubit/states.dart';
import 'package:apisecond/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<  NewCubit ,NewsStates   >(
      listener: (context , state ){},
      builder: (context , state){
        var list = NewCubit.get(context).business ;
        return ConditionalBuilder(

        condition: state is! NewsGetBusinessLoadingState ,
        builder: (context) => ListView.separated(
          //to remove color appear at scroll
          physics: BouncingScrollPhysics(),
      itemBuilder: (context , index)=> buildArticalItem(list[index] , context ),
      separatorBuilder: (context , index)=> MyDivider(),
      itemCount: list.length),

    fallback: (context)=> Center(child: CircularProgressIndicator()),
    );
    },

    );}
}
