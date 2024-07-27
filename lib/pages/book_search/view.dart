import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/constants/assets.dart';
import '../../app/database/model/models.dart';
import '../../widget/gap.dart';
import 'logic.dart';

class BookSearchPage extends StatelessWidget {
  BookSearchPage({super.key});

  final logic = Get.find<BookSearchLogic>();
  final state = Get.find<BookSearchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('搜索书籍'),
      ),
      body: Column(
        children: [
          _buildSearchInput(),
          const Divider(),
          Expanded(child: _buildSearchResultList()),
        ],
      ),
    );
  }

  Widget _buildSearchInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 40,
        child: TextField(
          textInputAction: TextInputAction.search,
          onSubmitted: logic.bookSearch,
          decoration: const InputDecoration(
            hintText: '请输入书名或作者名',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultList() {
    return GetBuilder<BookSearchLogic>(builder: (logic) {
      return ListView.separated(
        itemBuilder: (context, index) {
          return _SearchBookItem(searchBook: state.bookSearchInfos[index]);
        },
        itemCount: logic.state.bookSearchInfos.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1.0,
          );
        },
      );
    });
  }
}

class _SearchBookItem extends StatelessWidget {
  const _SearchBookItem({required this.searchBook});

  final BookSearchInfo searchBook;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Todo 跳转到书籍详情页
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            _buildCover(searchBook.coverUrl),
            const Gap.hn(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    searchBook.name ?? '未知',
                    style: context.textTheme.titleMedium,
                  ),
                  const Gap.vn(),
                  Text(
                    '天地间，有万相。而我李洛，终将成为这万相之王。继《斗破苍穹》《武动乾坤》《大主宰》《元尊》之后，天蚕土豆又一部玄幻力作。',
                    style: context.textTheme.labelMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  const Gap.vs(),
                  Text(
                    searchBook.author ?? '未知',
                    style: context.textTheme.labelMedium
                        ?.copyWith(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCover(String? coverUrl) {
    return coverUrl == null
        ? Image.asset(
            Assets.defaultBook,
            width: 60,
            height: 80,
            fit: BoxFit.cover,
          )
        : FastCachedImage(
            width: 60,
            height: 80,
            fit: BoxFit.cover,
            url: coverUrl,
          );
  }
}
