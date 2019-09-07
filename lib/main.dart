import 'package:flutter/material.dart';
import 'dart:async';
import 'shots.dart';
import 'result.dart';

void main() {
  // アプリ起動
  runApp(new ShootApp());
}
class ShootApp extends StatelessWidget {
// アプリのセットアップ
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // 画面遷移を定義

      // その他の変数を設定
      title: 'Shooting App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new ShootHome(),
      routes: {
        ResultPage.routeName: (context) => ResultPage(),
      }
    );
  }
}

class ShootHome extends StatefulWidget {
  ShootHome({Key key}) : super(key: key);
  @override
  _ShootHomeState createState() => new _ShootHomeState();
}

class _ShootHomeState extends State<ShootHome> {

  Shots _shots;
  int _scorePredict;
  String _dirPredict;
  int _scoreActual;
  String _dirActual;

  final int _scoreInit = 0;
  final String _dirInit = "*";

  _ShootHomeState() {
    _shots = new Shots();
    _scorePredict = this._scoreInit;
    _dirPredict = this._dirInit;
    _scoreActual = this._scoreInit;
    _dirActual = this._dirInit;
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ResultPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    // return Scaffoldでページを返す
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('予告射撃'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // 丸数字
            Text('${_shots.shots+1}発目',
            style: new TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600
            )
            ),
            // 文字か画像
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('予告'),
                Text('結果'),
              ]
            ),
            Row(
              children: <Widget>[
                _buildScoreButtons(),
                _buildDirectionButtons(),
                _buildActualScoreButtons(),
                _buildActualDirectionButtons(),
              ]
            ),
            Row(
              children: <Widget>[
                Text('$_scorePredict'),
                Text(_dirPredict),
                Text('$_scoreActual'),
                Text(_dirActual),
              ]
            ),
            Row(
              children: <Widget>[
                RaisedButton.icon(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  ),
                  label: Text('つぎ!'),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: _nextPressed,
                ),
                RaisedButton.icon(
                  icon: Icon(
                    Icons.assessment,
                    color: Colors.white,
                  ),
                  label: Text('結果!'),
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      ResultPage.routeName,
                      arguments: _shots,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _nextPressed() {
    if(_scoreActual != 0 && _dirActual != "?") {
      setState(() {
        _shots.shots++;
        _shots.pushResult(_scorePredict, _dirPredict, _scoreActual, _dirActual);
        _scorePredict = this._scoreInit;
        _dirPredict = this._dirInit;
        _scoreActual = this._scoreInit;
        _dirActual = this._dirInit;
      });
    }
  }

  static const score = [10, 9, 8, 7, 6];
  static const direction = ['↑','↗','→','↘','↓','↙','←','↖'];

  Widget _buildScoreButtons() {
    return Column(
      children: _buildScoreButton(),
    );
  }

  List<Widget> _buildScoreButton() {
    List<Widget> buttons = [];
    for (var s in score) {
      buttons.add(
          RaisedButton(
            child: Text("$s"),
            color: Colors.white,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
            onPressed: () {
              setState(() => _scorePredict = s);
            },
          )
      );
    }
    return buttons;
  }

  Widget _buildDirectionButtons() {
    return Column(
      children: _buildDirectionButton(),
    );
  }

  List<Widget> _buildDirectionButton() {
    List<Widget> buttons = [];
    for (var dir in direction) {
      buttons.add(RaisedButton(
        child: Text(dir),
        color: Colors.white,
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        onPressed: () {
          setState(() => _dirPredict = dir);
        },
      ));
    }
    return buttons;
  }

  Widget _buildActualScoreButtons() {
    return Column(
      children: _buildActualScoreButton(),
    );
  }

  List<Widget> _buildActualScoreButton() {
    List<Widget> buttons = [];
    for (var s in score) {
      buttons.add(
          RaisedButton(
            child: Text("$s"),
            color: Colors.white,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
            onPressed: () {
              setState(() => _scoreActual = s);
            },
          )
      );
    }
    return buttons;
  }

  Widget _buildActualDirectionButtons() {
    return Column(
      children: _buildActualDirectionButton(),
    );
  }

  List<Widget> _buildActualDirectionButton() {
    List<Widget> buttons = [];
    for (var dir in direction) {
      buttons.add(RaisedButton(
        child: Text(dir),
        color: Colors.white,
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        onPressed: () {
          setState(() => _dirActual = dir);
        },
      ));
    }
    return buttons;
  }
}



