import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import 'package:origin_novel/backend/rust/api/model/rule/rule_toc.dart'
    as rust_rule_toc;
import 'package:origin_novel/backend/rust/api/model/rule/rule_content.dart'
    as rust_rule_content;
import 'package:origin_novel/backend/rust/api/model/rule/rule_book_info.dart'
    as rust_rule_book_info;
import 'package:origin_novel/backend/rust/api/model/rule/rule_search.dart'
    as rust_rule_search;
import 'package:origin_novel/backend/rust/api/model/rule/rule_explore.dart'
    as rust_rule_explore;
import 'package:origin_novel/backend/rust/api/model/rule/rule_type.dart';
import 'package:origin_novel/backend/rust/api/model/rule/rule_review.dart'
    as rust_rule_review;

part 'book_info.dart';

part 'book_read_setting.dart';

part 'book_search_info.dart';

part 'book_source.dart';

part 'models.freezed.dart';

part 'models.g.dart';

part 'rule.dart';

part 'book_content.dart';
