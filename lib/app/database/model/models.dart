import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import '../../../backend/rust/api/model/rule_toc.dart' as rust_rule_toc;
import '../../../backend/rust/api/model/rule_content.dart' as rust_rule_content;
import '../../../backend/rust/api/model/rule_book_info.dart'
    as rust_rule_book_info;
import '../../../backend/rust/api/model/rule_search.dart' as rust_rule_search;
import '../../../backend/rust/api/model/rule_explore.dart' as rust_rule_explore;
import '../../../backend/rust/api/model/rule_type.dart';
import '../../../backend/rust/api/model/rule_view.dart' as rust_rule_view;

part 'book_info.dart';

part 'book_read_setting.dart';

part 'book_search_info.dart';

part 'book_source.dart';

part 'models.freezed.dart';

part 'models.g.dart';

part 'rule.dart';

part 'book_content.dart';
