import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///toast属于一种轻量级的反馈，常常以小弹框的形式出现，一般出现1到2秒会自动消失，
///可以出现在屏幕上中下任意位置，但同个产品会模块尽量使用同一位置，让用户产生统一认知。

///Snackbar继承了toast的所有特性，即：为小弹窗的形式，会自动消失。
///有三个差异化：①可以出现0到1个操作，不包含取消按钮；
///②点击Snackbar以外的区域，Snackbar会消失；
///③一般只出现在屏幕底部。

///如果Toast和Snackbar两种形式都不足以达到你需要的反馈强度，则推荐你使用Dialog的形式，即对话框提示。
///

class ToastContent extends StatefulWidget {
  final List<Widget> children;

  ToastContent({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  ToastContentState createState() => ToastContentState();
}

class ToastContentState extends State<ToastContent>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    ///Builder 可以穿透点击消失手势
    /// Material 可以Text 没有黄色下划线 必须在Center内部,不然不能被点击空白消失

    return Builder(builder: (BuildContext context) {
      return SafeArea(
        child: Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  ///尽可能的小尺寸
                  mainAxisSize: MainAxisSize.min,
                  children: widget.children),
            ),
          ),
        ),
      );
    });
  }
}

class LoadingDialog extends StatefulWidget {
  final String text;

  LoadingDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    ///Builder 可以穿透点击消失手势
    /// Material 可以Text 没有黄色下划线

    return SafeArea(
      child: Builder(builder: (BuildContext context) {
        return Center(
          //保证控件居中效果
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                ///尽可能的小尺寸
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ///进度条
                  CircularProgressIndicator(

                      /// 动画颜色
                      valueColor: ColorTween(
                    begin: Colors.orange,
                    end: Colors.black,
                  ).animate(
                    CurvedAnimation(
                      parent: AnimationController(
                        duration: Duration(seconds: 10),

                        /// 是否消耗其他资源
                        vsync: this,
                      ),
                      curve: Interval(
                        0.1,
                        0.75,
//                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
                    ),
                  )),

                  /// 菊花
//                  CupertinoActivityIndicator(),
                  SizedBox(height: 20),
                  Text(widget.text,
                      style: TextStyle(fontSize: 14.0, color: Colors.black)),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
