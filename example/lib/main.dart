import 'dart:async';

import 'package:ax_flutter_toast/ax_flutter_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'ax_flutter_toast'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _flatButton(String text, VoidCallback callback) {
    return FlatButton(
      child: Text(text),
      splashColor: Colors.red,
      color: Colors.green,
      textColor: Colors.white,
      onPressed: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(),
              _flatButton("Toast.success", () {
                Toast.success(
                    context: context,
                    dismissDuration: Duration(seconds: 10),
                    callBack: () {
                      print('Toast.success');
                    });
              }),
              _flatButton("Toast.failure", () {
                Toast.failure(
                    context: context,
                    dismissDuration: Duration(seconds: 3),
                    callBack: () {
                      print('Toast.failure');
                    });
              }),
              _flatButton("Toast.error", () {
                Toast.error(
                    context: context,
                    callBack: () {
                      print('Toast.error');
                    });
              }),
              _flatButton("Toast.showToast-1", () {
                Toast toast = Toast.showToast(
                    context: context,
                    child: Text('showToast-1'),
                    autoDismiss: false,
                    callBack: () {
                      print('Toast.success');
                    });

                Future.delayed(Duration(seconds: 3)).whenComplete(() {
                  toast.dismissToast();
                });
              }),
              _flatButton("Toast.showToast-2", () {
                Toast toast = Toast.showToast(
                    context: context,
                    child: Text('showToast-2'),
                    autoDismiss: false,
                    callBack: () {
                      print('Toast.success');
                    });

                Future.delayed(Duration(seconds: 4)).whenComplete(() {
                  toast.dismissToast();
                });
              }),

              _flatButton("Toast.loading", () {
                Toast toast = Toast.loading(context: context);
                double current = 0;
                Timer.periodic(Duration(milliseconds: 100), (timer) {
                  current += 1;
                  var progress = current / 100;
                  print('progress= $progress');
                  toast.loadingProgress = progress;
                  if (progress == 1) {
                    toast.loadingPop();
                    timer.cancel();
                  }
                });
              }),
            ],
          ),
        ));
  }
}
