


import 'package:apisecond/modules/module_webview/webView_Screen.dart';
import 'package:flutter/material.dart';

Widget buildArticalItem( article , context ) => InkWell(
  onTap: (){
    NavigateTo(context, WebViewScreen(article['url']) );
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120.0,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10.0) ,

              image: DecorationImage(

                  image: NetworkImage('${article['urlToImage']}'),

                  fit: BoxFit.cover

              )

          ),

        ),

        SizedBox(width: 20.0,),



        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(

                  child: Text('${article['title']} ' ,

                    style: Theme.of(context).textTheme.bodyText1 ,

                    maxLines: 3 ,

                    overflow: TextOverflow.ellipsis ,),

                ) ,

                Text('${article['publishedAt']}',

                  style: TextStyle(

                      color: Colors.grey

                  ), )

              ],

            ),

          ),

        )

      ],

    ),

  ),
) ;


Widget MyDivider() => Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Divider(thickness: 1,
                        color: Colors.grey,),
);

void NavigateTo(context , widget)
{
  Navigator.push(context,
      MaterialPageRoute(builder: (context)=> widget ));
}