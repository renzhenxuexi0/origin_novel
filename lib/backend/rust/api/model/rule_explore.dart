// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'rule_type.dart';

// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `fmt`
// These functions are ignored (category: IgnoreBecauseExplicitAttribute): `set_rule_type`

/// 发现规则结构定义
class RuleExplore {
  final String? author;
  final String? bookList;
  final String? bookUrl;
  final String? coverUrl;
  final String? lastChapter;
  final String? intro;
  final String? name;
  final String? wordCount;
  final String? kind;
  final RuleType? ruleType;

  const RuleExplore({
    this.author,
    this.bookList,
    this.bookUrl,
    this.coverUrl,
    this.lastChapter,
    this.intro,
    this.name,
    this.wordCount,
    this.kind,
    this.ruleType,
  });

  @override
  int get hashCode =>
      author.hashCode ^
      bookList.hashCode ^
      bookUrl.hashCode ^
      coverUrl.hashCode ^
      lastChapter.hashCode ^
      intro.hashCode ^
      name.hashCode ^
      wordCount.hashCode ^
      kind.hashCode ^
      ruleType.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuleExplore &&
          runtimeType == other.runtimeType &&
          author == other.author &&
          bookList == other.bookList &&
          bookUrl == other.bookUrl &&
          coverUrl == other.coverUrl &&
          lastChapter == other.lastChapter &&
          intro == other.intro &&
          name == other.name &&
          wordCount == other.wordCount &&
          kind == other.kind &&
          ruleType == other.ruleType;
}