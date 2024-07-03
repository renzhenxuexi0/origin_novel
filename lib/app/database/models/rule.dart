part of 'models.dart';

/// 书籍信息页规则结构定义
@embedded
class RuleBookInfo extends rust_rule_book_info.RuleBookInfo {
  RuleBookInfo({
    super.author,
    super.coverUrl,
    super.init,
    super.intro,
    super.kind,
    super.lastChapter,
    super.name,
    super.tocUrl,
    super.wordCount,
    super.downloadUrl,
    super.canReName,
  });

  // 父类转子类
  factory RuleBookInfo.fromRustModel(
      rust_rule_book_info.RuleBookInfo? ruleBookInfo) {
    if (ruleBookInfo == null) {
      return RuleBookInfo();
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
class RuleContent extends rust_rule_content.RuleContent {
  RuleContent({
    super.content,
    super.replaceRegex,
    super.title,
    super.nextContentUrl,
    super.webJs,
    super.sourceRegex,
    super.imageStyle,
    super.payAction,
  });

  // 父类转子类
  factory RuleContent.fromRustModel(
      rust_rule_content.RuleContent? ruleContent) {
    if (ruleContent == null) {
      return RuleContent();
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
class RuleExplore extends rust_rule_explore.RuleExplore {
  RuleExplore({
    super.author,
    super.bookList,
    super.bookUrl,
    super.coverUrl,
    super.lastChapter,
    super.intro,
    super.name,
    super.wordCount,
    super.kind,
  });

  // 父类转子类
  factory RuleExplore.fromRustModel(
      rust_rule_explore.RuleExplore? ruleExplore) {
    if (ruleExplore == null) {
      return RuleExplore();
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
class RuleReview extends rust_rule_view.RuleReview {
  RuleReview({
    super.reviewUrl,
    super.avatarRule,
    super.contentRule,
    super.postTimeRule,
    super.reviewQuoteUrl,
    super.voteUpUrl,
    super.voteDownUrl,
    super.postReviewUrl,
    super.postQuoteUrl,
    super.deleteUrl,
  });

  // 父类转子类
  factory RuleReview.fromRustModel(rust_rule_view.RuleReview? ruleReview) {
    if (ruleReview == null) {
      return RuleReview();
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
class RuleSearch extends rust_rule_search.RuleSearch {
  RuleSearch({
    super.author,
    super.bookList,
    super.bookUrl,
    super.coverUrl,
    super.intro,
    super.name,
    super.wordCount,
    super.kind,
  });

  // 父类转子类
  factory RuleSearch.fromRustModel(rust_rule_search.RuleSearch? ruleSearch) {
    if (ruleSearch == null) {
      return RuleSearch();
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
class RuleToc extends rust_rule_toc.RuleToc {
  RuleToc({
    super.chapterList,
    super.chapterName,
    super.chapterUrl,
    super.isVolume,
    super.preUpdateJson,
    super.formatJs,
    super.isVip,
    super.isPay,
    super.nextTocUrl,
    super.updateTime,
  });

  // 父类转子类
  factory RuleToc.fromRustModel(rust_rule_toc.RuleToc? ruleToc) {
    if (ruleToc == null) {
      return RuleToc();
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
