import 'dart:io';

import 'package:isar/isar.dart';
import 'package:origin_novel/util/log_utils.dart';
import 'package:path_provider/path_provider.dart';

import 'model/models.dart';

class AppDatabase {
  late Isar _isar;

  static AppDatabase? _instance;

  AppDatabase._internal({required Directory dir}) {
    _isar = Isar.open(
      schemas: <IsarGeneratedSchema>[
        BookInfoSchema,
        BookSearchInfoSchema,
        BookSourceSchema,
        BookReadSettingSchema,
        BookChapterContentSchema
      ],
      directory: dir.path,
    );
  }

  static Isar get isarInstance {
    if (_instance == null) {
      throw Exception('在使用AppDatabase.instance之前必须调用init');
    }
    return _instance!._isar;
  }

  static Future<void> init() async {
    final Directory dir = await getApplicationSupportDirectory();
    _instance = AppDatabase._internal(dir: dir);
    LogUtils.d('Isar数据库初始化完成');
  }
}
