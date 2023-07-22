import 'dart:io';

import 'package:flutter/services.dart';

abstract class FileService{
  String path = ""; //"assets/csv/34003A000C503341.csv";
  Future<String> getFile();
}

class SystemFileService extends FileService{
  SystemFileService(String path){
    this.path = path;
  }

  @override
  Future<String> getFile() async {
    return await File(path).readAsString();
  }
}

class AssetFileService extends FileService{
  AssetFileService(){
    path = "assets/csv/34003A000C503341.csv";
  }

  @override
  Future<String> getFile() async {
    return await rootBundle.loadString(path);
  }
}