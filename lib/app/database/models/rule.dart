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
      canReName.hashCode;

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
          canReName == other.canReName;

  // 父类转子类
  factory RuleBookInfo.fromRustModel(
      rust_rule_book_info.RuleBookInfo? ruleBookInfo) {
    if (ruleBookInfo == null) {
      return const RuleBookInfo();
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

  const RuleContent({
    this.content,
    this.replaceRegex,
    this.title,
    this.nextContentUrl,
    this.webJs,
    this.sourceRegex,
    this.imageStyle,
    this.payAction,
  });

  @override
  int get hashCode =>
      content.hashCode ^
      replaceRegex.hashCode ^
      title.hashCode ^
      nextContentUrl.hashCode ^
      webJs.hashCode ^
      sourceRegex.hashCode ^
      imageStyle.hashCode ^
      payAction.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuleContent &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          replaceRegex == other.replaceRegex &&
          title == other.title &&
          nextContentUrl == other.nextContentUrl &&
          webJs == other.webJs &&
          sourceRegex == other.sourceRegex &&
          imageStyle == other.imageStyle &&
          payAction == other.payAction;

  // 父类转子类
  factory RuleContent.fromRustModel(
      rust_rule_content.RuleContent? ruleContent) {
    if (ruleContent == null) {
      return const RuleContent();
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
      kind.hashCode;

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
          kind == other.kind;

  // 父类转子类
  factory RuleExplore.fromRustModel(
      rust_rule_explore.RuleExplore? ruleExplore) {
    if (ruleExplore == null) {
      return const RuleExplore();
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
  });

  @override
  int get hashCode =>
      reviewUrl.hashCode ^
      avatarRule.hashCode ^
      contentRule.hashCode ^
      postTimeRule.hashCode ^
      reviewQuoteUrl.hashCode ^
      voteUpUrl.hashCode ^
      voteDownUrl.hashCode ^
      postReviewUrl.hashCode ^
      postQuoteUrl.hashCode ^
      deleteUrl.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuleReview &&
          runtimeType == other.runtimeType &&
          reviewUrl == other.reviewUrl &&
          avatarRule == other.avatarRule &&
          contentRule == other.contentRule &&
          postTimeRule == other.postTimeRule &&
          reviewQuoteUrl == other.reviewQuoteUrl &&
          voteUpUrl == other.voteUpUrl &&
          voteDownUrl == other.voteDownUrl &&
          postReviewUrl == other.postReviewUrl &&
          postQuoteUrl == other.postQuoteUrl &&
          deleteUrl == other.deleteUrl;

  // 父类转子类
  factory RuleReview.fromRustModel(rust_rule_view.RuleReview? ruleReview) {
    if (ruleReview == null) {
      return const RuleReview();
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

  const RuleSearch({
    this.author,
    this.bookList,
    this.bookUrl,
    this.coverUrl,
    this.intro,
    this.name,
    this.wordCount,
    this.kind,
  });

  @override
  int get hashCode =>
      author.hashCode ^
      bookList.hashCode ^
      bookUrl.hashCode ^
      coverUrl.hashCode ^
      intro.hashCode ^
      name.hashCode ^
      wordCount.hashCode ^
      kind.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuleSearch &&
          runtimeType == other.runtimeType &&
          author == other.author &&
          bookList == other.bookList &&
          bookUrl == other.bookUrl &&
          coverUrl == other.coverUrl &&
          intro == other.intro &&
          name == other.name &&
          wordCount == other.wordCount &&
          kind == other.kind;

  // 父类转子类
  factory RuleSearch.fromRustModel(rust_rule_search.RuleSearch? ruleSearch) {
    if (ruleSearch == null) {
      return const RuleSearch();
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
  });

  @override
  int get hashCode =>
      chapterList.hashCode ^
      chapterName.hashCode ^
      chapterUrl.hashCode ^
      isVolume.hashCode ^
      preUpdateJson.hashCode ^
      formatJs.hashCode ^
      isVip.hashCode ^
      isPay.hashCode ^
      nextTocUrl.hashCode ^
      updateTime.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuleToc &&
          runtimeType == other.runtimeType &&
          chapterList == other.chapterList &&
          chapterName == other.chapterName &&
          chapterUrl == other.chapterUrl &&
          isVolume == other.isVolume &&
          preUpdateJson == other.preUpdateJson &&
          formatJs == other.formatJs &&
          isVip == other.isVip &&
          isPay == other.isPay &&
          nextTocUrl == other.nextTocUrl &&
          updateTime == other.updateTime;

  // 父类转子类
  factory RuleToc.fromRustModel(rust_rule_toc.RuleToc? ruleToc) {
    if (ruleToc == null) {
      return const RuleToc();
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
    );
  }
}
