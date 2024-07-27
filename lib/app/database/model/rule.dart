part of 'models.dart';

/// 书籍信息页规则结构定义
@embedded
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
  final String ruleTypes;

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
    required this.ruleTypes,
  });

  /// rust模型转dart模型
  factory RuleBookInfo.fromRustModel(
      rust_rule_book_info.RuleBookInfo? ruleBookInfo) {
    if (ruleBookInfo == null) {
      return const RuleBookInfo(ruleTypes: '');
    }

    return RuleBookInfo(
      wordCount: ruleBookInfo.wordCount,
      tocUrl: ruleBookInfo.tocUrl,
      name: ruleBookInfo.name,
      lastChapter: ruleBookInfo.lastChapter,
      kind: ruleBookInfo.kind,
      intro: ruleBookInfo.intro,
      init: ruleBookInfo.init,
      coverUrl: ruleBookInfo.coverUrl,
      author: ruleBookInfo.author,
      downloadUrl: ruleBookInfo.downloadUrl,
      canReName: ruleBookInfo.canReName,
      // 转为json字符串存储
      ruleTypes: jsonEncode(
        Map.fromEntries(
          ruleBookInfo.ruleTypes.entries.map(
            (entry) => MapEntry(entry.key.toString(), entry.value.toString()),
          ),
        ),
      ),
    );
  }
}

/// 正文页规则结构定义
@embedded
class RuleContent {
  final String? content;
  final String? replaceRegex;
  final String? title;
  final String? nextContentUrl;
  final String? webJs;
  final String? sourceRegex;
  final String? imageStyle;
  final String? payAction;
  final String ruleTypes;

  const RuleContent({
    this.content,
    this.replaceRegex,
    this.title,
    this.nextContentUrl,
    this.webJs,
    this.sourceRegex,
    this.imageStyle,
    this.payAction,
    required this.ruleTypes,
  });

  /// rust模型转dart模型
  factory RuleContent.fromRustModel(
      rust_rule_content.RuleContent? ruleContent) {
    if (ruleContent == null) {
      return const RuleContent(ruleTypes: '');
    }
    return RuleContent(
      content: ruleContent.content,
      replaceRegex: ruleContent.replaceRegex,
      title: ruleContent.title,
      nextContentUrl: ruleContent.nextContentUrl,
      webJs: ruleContent.webJs,
      sourceRegex: ruleContent.sourceRegex,
      imageStyle: ruleContent.imageStyle,
      payAction: ruleContent.payAction,
      // 转为json字符串存储
      ruleTypes: jsonEncode(
        Map.fromEntries(
          ruleContent.ruleTypes.entries.map(
            (entry) => MapEntry(entry.key.toString(), entry.value.toString()),
          ),
        ),
      ),
    );
  }
}

/// 发现规则结构定义
@embedded
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
  final String ruleTypes;

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
    required this.ruleTypes,
  });

  /// rust模型转dart模型
  factory RuleExplore.fromRustModel(
      rust_rule_explore.RuleExplore? ruleExplore) {
    if (ruleExplore == null) {
      return const RuleExplore(ruleTypes: '');
    }
    return RuleExplore(
      wordCount: ruleExplore.wordCount,
      name: ruleExplore.name,
      intro: ruleExplore.intro,
      lastChapter: ruleExplore.lastChapter,
      coverUrl: ruleExplore.coverUrl,
      bookUrl: ruleExplore.bookUrl,
      bookList: ruleExplore.bookList,
      author: ruleExplore.author,
      kind: ruleExplore.kind,
      // 转为json字符串存储
      ruleTypes: jsonEncode(
        Map.fromEntries(
          ruleExplore.ruleTypes.entries.map(
            (entry) => MapEntry(entry.key.toString(), entry.value.toString()),
          ),
        ),
      ),
    );
  }
}

/// 段评规则结构定义
@embedded
class RuleReview {
  /// 段评URL
  final String? reviewUrl;

  /// 段评发布者头像规则
  final String? avatarRule;

  /// 段评内容规则
  final String? contentRule;

  /// 段评发布时间规则
  final String? postTimeRule;

  /// 获取段评回复URL
  final String? reviewQuoteUrl;

  /// 点赞URL
  final String? voteUpUrl;

  /// 点踩URL
  final String? voteDownUrl;

  /// 发送回复URL
  final String? postReviewUrl;

  /// 发送回复段评URL
  final String? postQuoteUrl;

  /// 删除段评URL
  final String? deleteUrl;
  final String ruleTypes;

  const RuleReview({
    this.reviewUrl,
    this.avatarRule,
    this.contentRule,
    this.postTimeRule,
    this.reviewQuoteUrl,
    this.voteUpUrl,
    this.voteDownUrl,
    this.postReviewUrl,
    this.postQuoteUrl,
    this.deleteUrl,
    required this.ruleTypes,
  });

  /// rust模型转dart模型
  factory RuleReview.fromRustModel(rust_rule_review.RuleReview? ruleReview) {
    if (ruleReview == null) {
      return const RuleReview(ruleTypes: '');
    }
    return RuleReview(
      reviewUrl: ruleReview.reviewUrl,
      avatarRule: ruleReview.avatarRule,
      contentRule: ruleReview.contentRule,
      postTimeRule: ruleReview.postTimeRule,
      reviewQuoteUrl: ruleReview.reviewQuoteUrl,
      voteUpUrl: ruleReview.voteUpUrl,
      voteDownUrl: ruleReview.voteDownUrl,
      postReviewUrl: ruleReview.postReviewUrl,
      postQuoteUrl: ruleReview.postQuoteUrl,
      deleteUrl: ruleReview.deleteUrl,
      // 转为json字符串存储
      ruleTypes: jsonEncode(
        Map.fromEntries(
          ruleReview.ruleTypes.entries.map(
            (entry) => MapEntry(entry.key.toString(), entry.value.toString()),
          ),
        ),
      ),
    );
  }
}

/// 搜索规则结构定义
@embedded
class RuleSearch {
  final String? author;
  final String? bookList;
  final String? bookUrl;
  final String? coverUrl;
  final String? intro;
  final String? name;
  final String? wordCount;
  final String? kind;
  final String ruleTypes;

  const RuleSearch({
    this.author,
    this.bookList,
    this.bookUrl,
    this.coverUrl,
    this.intro,
    this.name,
    this.wordCount,
    this.kind,
    required this.ruleTypes,
  });

  // rust模型转dart模型
  factory RuleSearch.fromRustModel(rust_rule_search.RuleSearch? ruleSearch) {
    if (ruleSearch == null) {
      return const RuleSearch(ruleTypes: '');
    }
    return RuleSearch(
      wordCount: ruleSearch.wordCount,
      name: ruleSearch.name,
      intro: ruleSearch.intro,
      coverUrl: ruleSearch.coverUrl,
      bookUrl: ruleSearch.bookUrl,
      bookList: ruleSearch.bookList,
      kind: ruleSearch.kind,
      author: ruleSearch.author,
      // 转为json字符串存储
      ruleTypes: jsonEncode(
        Map.fromEntries(
          ruleSearch.ruleTypes.entries.map(
            (entry) => MapEntry(entry.key.toString(), entry.value.toString()),
          ),
        ),
      ),
    );
  }
}

/// 目录页规则结构定义
@embedded
class RuleToc {
  final String? chapterList;
  final String? chapterName;
  final String? chapterUrl;
  final String? isVolume;
  final String? preUpdateJson;
  final String? formatJs;
  final String? isVip;
  final String? isPay;
  final String? nextTocUrl;
  final String? updateTime;
  final String ruleTypes;

  const RuleToc({
    this.chapterList,
    this.chapterName,
    this.chapterUrl,
    this.isVolume,
    this.preUpdateJson,
    this.formatJs,
    this.isVip,
    this.isPay,
    this.nextTocUrl,
    this.updateTime,
    required this.ruleTypes,
  });

  // rust模型转dart模型
  factory RuleToc.fromRustModel(rust_rule_toc.RuleToc? ruleToc) {
    if (ruleToc == null) {
      return const RuleToc(ruleTypes: '');
    }
    return RuleToc(
      chapterList: ruleToc.chapterList,
      chapterName: ruleToc.chapterName,
      chapterUrl: ruleToc.chapterUrl,
      isVolume: ruleToc.isVolume,
      preUpdateJson: ruleToc.preUpdateJson,
      formatJs: ruleToc.formatJs,
      isVip: ruleToc.isVip,
      isPay: ruleToc.isPay,
      nextTocUrl: ruleToc.nextTocUrl,
      updateTime: ruleToc.updateTime,
      // 转为json字符串存储
      ruleTypes: jsonEncode(
        Map.fromEntries(
          ruleToc.ruleTypes.entries.map(
            (entry) => MapEntry(entry.key.toString(), entry.value.toString()),
          ),
        ),
      ),
    );
  }
}
