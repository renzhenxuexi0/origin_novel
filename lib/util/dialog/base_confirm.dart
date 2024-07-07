part of 'dialog_utils.dart';

/// 确认弹窗
/// [title] 标题 默认为提示
/// [builder] 内容 默认为 Container()
/// [confirmText] 确认按钮文本 默认为确定
/// [cancelText] 取消按钮文本 默认为取消
/// [confirmHandle] 确认按钮回调
/// [cancelHandle] 取消按钮回调
/// [isDanger] 是否是危险操作 默认为 false
class BaseConfirm extends StatelessWidget {
  const BaseConfirm({
    required this.title,
    required this.builder,
    required this.confirmText,
    required this.cancelText,
    required this.confirmHandle,
    required this.cancelHandle,
    required this.isDanger,
    super.key,
  });

  final String? title;
  final Widget Function(BuildContext context) builder;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback confirmHandle;
  final VoidCallback cancelHandle;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    const double bottomActionButtonWidth =
        MyDialogTheme.dialogWidth / 2 - MyDialogTheme.dialogDividerWidth / 2;

    return ConstrainedBox(
      constraints:
          const BoxConstraints.tightFor(width: MyDialogTheme.dialogWidth),
      child: Material(
        borderRadius: BorderRadius.circular(MyDialogTheme.radius),
        color: context.theme.colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(MyDialogTheme.padding),
              child: Align(
                child: Text(
                  title ??
                      (isDanger ? S.of(context).warning : S.of(context).tips),
                  style: context.theme.textTheme.titleMedium,
                ),
              ),
            ),
            const Divider(
              height: MyDialogTheme.dialogDividerWidth,
              indent: 0.0,
              endIndent: 0.0,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MyDialogTheme.dialogContentMinHeight,
                maxHeight: context.height / 2,
              ),
              child: SingleChildScrollView(
                // padding: AppTheme.confirmDialogContextPadding,
                child: DefaultTextStyle(
                  style: context.theme.textTheme.titleSmall!,
                  child: builder.call(context),
                ),
              ),
            ),
            const Divider(
              height: MyDialogTheme.dialogDividerWidth,
              indent: 0.0,
              endIndent: 0.0,
            ),
            Row(
              children: <Widget>[
                Ink(
                  width: bottomActionButtonWidth,
                  height: MyDialogTheme.dialogBottomActionHeight,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(MyDialogTheme.radius),
                    ),
                  ),
                  child: InkWell(
                    onTap: cancelHandle,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(MyDialogTheme.radius),
                    ),
                    child: Align(
                      child: Text(
                        cancelText ?? S.of(context).cancel,
                        style: context.theme.textTheme.titleMedium!.copyWith(
                          color: context.theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MyDialogTheme.dialogDividerWidth,
                  height: MyDialogTheme.dialogBottomActionHeight,
                  child: VerticalDivider(
                    width: MyDialogTheme.dialogDividerWidth,
                    // thickness: AppTheme.dividerTheme.thickness,
                    indent: 0.0,
                    endIndent: 0.0,
                    color: context.theme.dividerColor,
                  ),
                ),
                Ink(
                  width: bottomActionButtonWidth,
                  height: MyDialogTheme.dialogBottomActionHeight,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(MyDialogTheme.radius),
                    ),
                  ),
                  child: InkWell(
                    onTap: confirmHandle,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(MyDialogTheme.radius),
                    ),
                    child: Align(
                      child: Text(
                        confirmText ??
                            (isDanger
                                ? S.of(context).delete
                                : S.of(context).ok),
                        style: context.theme.textTheme.titleMedium!.copyWith(
                          color: isDanger
                              ? context.theme.colorScheme.error
                              : context.theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
