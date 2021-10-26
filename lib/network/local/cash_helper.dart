import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper
{
  static SharedPreferences? sharedPre ;

  ///method to create object from sharedPreference

  static init() async
  {
     sharedPre = await SharedPreferences.getInstance() ;
  }

  static Future<bool>  putData({
    @required String? key ,
    @required var value
    }) async
   {

   return await sharedPre!.setBool('isDark', value );

   }


  static bool? getData({@required String? key})
  {

    return  sharedPre!.getBool( key! );

  }





}