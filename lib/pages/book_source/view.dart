import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:origin_novel/util/dialog/dialog_utils.dart';

import '../../app/l10n/generated/l10n.dart';
import 'logic.dart';

const _searchHeight = 30.0;

class BookSourcePage extends StatelessWidget {
  BookSourcePage({super.key});

  final logic = Get.find<BookSourceLogic>();
  final state = Get.find<BookSourceLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).bookSource(1),
        ),
        actions: [
          // 帮助按钮
          IconButton(
            icon: const Icon(Icons.help),
            tooltip: S.of(context).help,
            onPressed: () {
              DialogUtils.help(
                S.of(context).bookSourceHelp,
              );
            },
          ),
          // 刷新书源按钮
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: S.of(context).refreshBookSource,
            onPressed: logic.initBookSourcesFormNet,
          ),
        ],
      ),
      body: Column(
        children: [
          // 筛选栏
          Row(
            children: [
              // 全部、启用、禁用
              TextButton(
                onPressed: logic.showAllBookSources,
                child: Text(S.of(context).all),
              ),
              TextButton(
                onPressed: logic.showEnabledBookSources,
                child: Text(S.of(context).enabled),
              ),
              TextButton(
                onPressed: logic.showDisabledBookSources,
                child: Text(S.of(context).disabled),
              ),
            ],
          ),
          const Divider(),
          // 搜索输入框
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: _searchHeight,
            child: TextField(
              controller: state.searchController,
              onChanged: logic.onSearchChanged,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                contentPadding:
                    EdgeInsets.symmetric(vertical: _searchHeight / 2 - 14),
              ),
            ),
          ),
          const Divider(),
          // 书源列表
          Expanded(
            child: GetBuilder<BookSourceLogic>(builder: (logic) {
              return ListView.builder(
                itemBuilder: bookSourceItemBuilder,
                itemCount: state.showBookSources.length,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget bookSourceItemBuilder(BuildContext context, int index) {
    final bookSource = state.showBookSources[index];
    return ListTile(
      title: Row(
        children: [
          Text(bookSource.bookSourceName),
          const Spacer(),
          // 置顶、启用/禁用、删除
          Row(
            children: [
              // 置顶
              IconButton(
                onPressed: () => logic.topBookSource(bookSource),
                icon: const Icon(Icons.arrow_upward),
                tooltip: S.of(context).topping,
              ),
              // 启用/禁用
              Visibility(
                visible: bookSource.canEnable,
                child: IconButton(
                  onPressed: () => logic.enableOrDisableBookSource(bookSource),
                  icon: Icon(bookSource.enabled
                      ? Icons.visibility
                      : Icons.visibility_off),
                  tooltip: bookSource.enabled
                      ? S.of(context).disabled
                      : S.of(context).enabled,
                ),
              ),
              // 删除
              IconButton(
                onPressed: () => logic.deleteBookSource(bookSource),
                icon: const Icon(Icons.delete),
                tooltip: S.of(context).delete,
              ),
            ],
          )
        ],
      ),
      hoverColor: context.theme.hoverColor,
      onTap: () {
        // TODO: 查看书源详情
      },
    );
  }
}
