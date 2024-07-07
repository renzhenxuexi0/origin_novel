part of 'dialog_utils.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({
    super.key,
    required this.msg,
    required this.title,
    required this.iKnowCallback,
  });

  final String msg;
  final String title;
  final VoidCallback iKnowCallback;

  @override
  Widget build(BuildContext context) {
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
                  S.of(context).help,
                  style: context.theme.textTheme.titleMedium,
                ),
              ),
            ),
            const Divider(
              height: MyDialogTheme.dialogDividerWidth,
              indent: 0.0,
              endIndent: 0.0,
            ),
            // 帮助内容
            Padding(
              padding: const EdgeInsets.all(MyDialogTheme.padding),
              child: Text(
                msg,
                style: context.theme.textTheme.bodyMedium,
              ),
            ),
            const Divider(
              height: MyDialogTheme.dialogDividerWidth,
              indent: 0.0,
              endIndent: 0.0,
            ),
            // 底部操作
            Row(
              children: <Widget>[
                Expanded(
                  child: Ink(
                    width: MyDialogTheme.dialogWidth,
                    height: MyDialogTheme.dialogBottomActionHeight,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(MyDialogTheme.radius),
                      ),
                    ),
                    child: InkWell(
                      onTap: iKnowCallback,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(MyDialogTheme.radius),
                      ),
                      child: Align(
                        child: Text(
                          S.of(context).iKnow,
                          style: context.theme.textTheme.titleMedium!.copyWith(
                            color: context.theme.primaryColor,
                          ),
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
