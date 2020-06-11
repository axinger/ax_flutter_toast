
import 'package:ax_flutter_toast/src/toast_circle.dart';
import 'package:flutter/material.dart';

import 'toast_content.dart';

const double kIconSize = 50;
const Duration kDuration = const Duration(milliseconds: 150);
const Duration kPopDuration = const Duration(seconds: 2);

class Toast {
  BuildContext _context;

  ValueNotifier<double> _loadingProgressNotifier = ValueNotifier<double>(0);

  /// 显示 指定内容 2秒后消失
  static Future<T> showToast<T>({@required context, Widget child}) {
    return showDismissibleOfOverlayState(
      context: context,
      children: [child],
    );
  }

  /// 显示 √ 2秒后消失
  static Future<T> success<T>({@required context}) {
    return showToast(
      context: context,
      child: _icon(Icons.check_circle),
    );
  }

  /// 显示 × 2秒后消失
  static Future<T> failure<T>({@required context}) {
    return showToast(
      context: context,
      child: _icon(Icons.cancel),
    );
  }

  /// 显示 ! 2秒后消失
  static Future<T> error<T>({@required context}) {
    return showToast(
      context: context,
      child: _icon(Icons.error),
    );
  }

  /// loading 显示 进度,需要主动消失
  Toast.loading({@required BuildContext context, double progressValue = 0.0}) {
    _context = context;
    _showNotDismissible(
      context: context,
      children: [
        ValueListenableBuilder(
          builder: (BuildContext context, double value, Widget child) {
            return Column(
              children: <Widget>[
                CustomPaint(
                  painter: ToastCircle(progress: value),
                  size: Size(kIconSize, kIconSize),
                ),
                SizedBox(
                  height: 20,
                ),

                /// 截取2位
                Text(
                  '${(value * 100).toStringAsFixed(2)}%',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            );
          },
          valueListenable: _loadingProgressNotifier,
        ),
      ],
    );
  }

  /// loading 更新进度
  set loadingProgress(progress) {
    _loadingProgressNotifier.value = progress;
  }

  /// loading pop
  void loadingPop() {
    Navigator.pop(_context);
  }

  ///使用[OverlayState] 创建 层级最高(除iOS键盘),不影响子页面交互,用于toast 较好
  static Future<T> showDismissibleOfOverlayState<T>({
    @required BuildContext context,
    List<Widget> children,
  }) {
    OverlayEntry _overlayEntry = OverlayEntry(
        maintainState: true,
        builder: (BuildContext context) {
          return ToastContent(
            children: children,
          );
        });

    Overlay.of(context).insert(_overlayEntry);

    return Future.delayed(kPopDuration).whenComplete(() {
      _overlayEntry.remove();
    });
  }

  /// * 使用 [showGeneralDialog] 方式创建,影响子页面交互,但会强制收起键盘,是通过 push方式
  static Future<T> showDismissibleOfDialog<T>(
      {@required BuildContext context, List<Widget> children}) {
    _showDialog(
      context: context,
      barrierDismissible: false,
      children: children,
    );
    return Future.delayed(kPopDuration).whenComplete(() {
      Navigator.pop(context);
    });
  }

  static _showNotDismissible({@required context, List<Widget> children}) {
    _showDialog(
      context: context,
      barrierDismissible: false,
      children: children,
    );
  }

  static Icon _icon(IconData iconData) {
    return Icon(iconData, color: Colors.white, size: kIconSize);
  }

  ///[barrierColor] 背景色
  ///[barrierDismissible]是否点击空白消失
  static Future<T> _showDialog<T>(
      {@required context,
      Color barrierColor,
      bool barrierDismissible,
      List<Widget> children}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: '',
      transitionDuration: kDuration,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return ToastContent(
          children: children,
        );
      },
    );
  }
}
