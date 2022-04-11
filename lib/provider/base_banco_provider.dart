import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseBancoProvider extends ChangeNotifier {
  late Database db;

  onCreate(Database db) async {}

  onInit(Database db) {}
}
