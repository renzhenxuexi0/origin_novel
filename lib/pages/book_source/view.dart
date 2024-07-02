import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/l10n/generated/l10n.dart';
import '../../widget/gap.dart';
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
          // 刷新书源
          IconButton(
            icon: const Icon(Icons.refresh),
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
              TextButton(
                onPressed: () => logic.topBookSource(bookSource),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_upward),
                    const Gap.hs(),
                    Text(S.of(context).topping),
                  ],
                ),
              ),
              // 启用/禁用
              TextButton(
                onPressed: () => logic.enableOrDisableBookSource(bookSource),
                child: Row(
                  children: [
                    Icon(bookSource.enabled
                        ? Icons.visibility
                        : Icons.visibility_off),
                    const Gap.hs(),
                    Text(bookSource.enabled
                        ? S.of(context).disabled
                        : S.of(context).enabled),
                  ],
                ),
              ),
              // 删除
              TextButton(
                onPressed: () => logic.deleteBookSource(bookSource),
                child: Row(
                  children: [
                    const Icon(Icons.delete),
                    const Gap.hs(),
                    Text(S.of(context).delete),
                  ],
                ),
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
