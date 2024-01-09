//global objects
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/database/interface/database_core_interface.dart';

class Globals {
  static late DatabaseCoreInterface appDatabase;
  static late SharedPreferences sharedPreferences;
  static late Dio api;
  static late String appDirPath;
  static late InternetConnection connection ;
}
