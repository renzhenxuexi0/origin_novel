// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'rule_type.dart';

// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `fmt`
// These functions are ignored (category: IgnoreBecauseExplicitAttribute): `set_rule_type`

/// 书籍信息页规则结构定义
class RuleBookInfo {
  final String? author;
  final String? coverUrl;
  final String? init;
  final String? intro;
  final String? kind;
  final String? lastChapter;
  final String? name;
  final String? tocUrl;
  final String? wordCount;
  final String? downloadUrl;
  final String? canReName;
  final RuleType? ruleType;

  const RuleBookInfo({
    this.author,
    this.coverUrl,
    this.init,
    this.intro,
    this.kind,
    this.lastChapter,
    this.name,
    this.tocUrl,
    this.wordCount,
    this.downloadUrl,
    this.canReName,
    this.ruleType,
  });

  @override
  int get hashCode =>
      author.hashCode ^
      coverUrl.hashCode ^
      init.hashCode ^
      intro.hashCode ^
      kind.hashCode ^
      lastChapter.hashCode ^
      name.hashCode ^
      tocUrl.hashCode ^
      wordCount.hashCode ^
      downloadUrl.hashCode ^
      canReName.hashCode ^
      ruleType.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuleBookInfo &&
          runtimeType == other.runtimeType &&
          author == other.author &&
          coverUrl == other.coverUrl &&
          init == other.init &&
          intro == other.intro &&
          kind == other.kind &&
          lastChapter == other.lastChapter &&
          name == other.name &&
          tocUrl == other.tocUrl &&
          wordCount == other.wordCount &&
          downloadUrl == other.downloadUrl &&
          canReName == other.canReName &&
          ruleType == other.ruleType;
}