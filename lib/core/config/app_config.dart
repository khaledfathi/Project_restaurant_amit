import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core_export.dart' as core;

class AppConfig {
  //apply config
  Future<void> apply() async {
    _initFlutter();
    await _initAppPath();
    await _initDB();
    await _initSharedPreference();
    await _initOrientationsProtraitUp();
    _initDio();
  }

  //flutter required
  void _initFlutter() {
    WidgetsFlutterBinding.ensureInitialized();
    debugPrint('AppConfig : Flutter ensureInitialized [OK]');
  }

  //get device application apth 
  Future<void> _initAppPath() async {
    await getApplicationDocumentsDirectory()
        .then((direcrory) => core.appDirPath = direcrory.path);
      debugPrint('AppConfig : device path initilaizing  [OK]');
  }
  
  //database initilization
  Future<void> _initDB() async {
        core.appDatabase = core.DatabaseSqlite();
        debugPrint('AppConfig : Database sqlflite initilizing [OK]');
  }

  //init shared preference
  Future<void> _initSharedPreference() async {
    core.sharedPreferences = await SharedPreferences.getInstance();
    debugPrint('AppConfig : Shared Preferences initilaizing  [OK]');    
  }

  //init DIO
  void _initDio() {
    core.api = Dio();
    debugPrint('AppConfig : Dio (http communications) initilaizing  [OK]');
  }

  //set device orientations
  Future<void> _initOrientationsProtraitUp ()async{
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    debugPrint('AppConfig : Device orientation set to Portrait up  [OK]');
  }

}
