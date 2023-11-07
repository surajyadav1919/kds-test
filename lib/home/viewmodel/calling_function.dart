import 'package:get/get.dart';

import '../../db/db_helper.dart';

RxList thoughtsList = [].obs;
fetchUser() async {
  final db = await instance.database;
  final List<Map<String, dynamic>> maps = await db.query('users');
  thoughtsList.value = maps;
}