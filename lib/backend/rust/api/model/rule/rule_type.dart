// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// These types are ignored because they are not used by any `pub` functions: `MatchingMethod`, `RuleCharacteristic`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `fmt`
// These functions are ignored (category: IgnoreBecauseExplicitAttribute): `is_supported_rule`, `new`

enum RuleType {
  /// JSONPATH
  jsonPath,

  /// 正则
  regex,

  /// Jsoup default
  jsoupDefault,

  /// Jsoup css
  jsoupCss,

  /// js
  js,

  /// xPath
  xPath,

  /// Unknown
  unknown,
  ;
}