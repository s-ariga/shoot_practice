import 'package:flutter/material.dart';
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
          canvasColor: const Color(0xFFfdf6e3),
          fontFamily: 'Genshin Gothic',
        ),
        home: new ShootHome(),
        routes: {
          ResultPage.routeName: (context) => ResultPage(),
        });
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
  final String _dirInit = "＊";

  _ShootHomeState() {
    _shots = new Shots();
    _scorePredict = this._scoreInit;
    _dirPredict = this._dirInit;
    _scoreActual = this._scoreInit;
    _dirActual = this._dirInit;
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffoldでページを返す
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('予告射撃'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // 丸数字
            Text('${_shots.shots + 1}発目',
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF002b36))),
            // 文字か画像
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('予告',
                      style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF002b36))),
                  SizedBox(width: 1),
                  Text('結果',
                      style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF002b36))),
                ]),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: 10),
                _buildScoreButtons(),
                SizedBox(width: 10),
                _buildActualScoreButtons(),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: 10),
                _buildDirectionButtons(),
                SizedBox(width: 10),
                _buildActualDirectionButtons(),
                SizedBox(width: 10),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('$_scorePredict',
                      style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF002b36))),
                  Text(_dirPredict,
                      style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF002b36))),
                  SizedBox(width: 10),
                  Text('$_scoreActual',
                      style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF002b36))),
                  Text(_dirActual,
                      style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF002b36))),
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton.icon(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 60,
                  ),
                  label: Text('つぎ!',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w600)),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: _nextPressed,
                ),
                RaisedButton.icon(
                  icon: Icon(
                    Icons.assessment,
                    color: Colors.white,
                    size: 60,
                  ),
                  label: Text('結果!',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w600)),
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
    if (_scoreActual != _scoreInit && _dirActual != _dirInit) {
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

  static const score = [10, 9, 8, 7, 6, 5];
  static const direction = ['↖', '↑', '↗', '←', '・', '→', '↙', '↓', '↘'];

  Widget _buildScoreButtons() {
    return Container(
      child: _buildScoreGridButtons(),
    );
  }

  Widget _buildDirectionButtons() {
    return Container(
      child: _buildDirectionGridButtons(),
    );
  }

  Widget _buildScoreGridButtons() {
    // GridViewで方向を並べて表示する
    return Expanded(
        child: GridView.count(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(score.length, (index) {
              return _buildScoreGridButton(score[index]);
            })));
  }

  Widget _buildScoreGridButton(int sc) {
    // ボタン作成
    return RaisedButton(
      child: Text(
        "$sc",
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
      ),
      color: const Color(0xFF2aa198),
      shape: CircleBorder(
        side: BorderSide(
          color: Colors.black,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      onPressed: () {
        setState(() => _scorePredict = sc);
      },
    );
  }

  Widget _buildDirectionGridButtons() {
    // GridViewで方向を並べて表示する
    return Expanded(
        child: GridView.count(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(direction.length, (index) {
              return _buildDirectionGridButton(direction[index]);
            })));
  }

  Widget _buildDirectionGridButton(String dir) {
    return RaisedButton(
      child: Text(
        dir,
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
      ),
      color: const Color(0xFF859900),
      shape: CircleBorder(
        side: BorderSide(
          color: const Color(0xFF002b36),
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      onPressed: () {
        setState(() => _dirPredict = dir);
      },
    );
  }

  Widget _buildActualScoreButtons() {
    return Container(
      child: _buildActualScoreGridButtons(),
    );
  }

  Widget _buildActualScoreGridButtons() {
    // GridViewで方向を並べて表示する
    return Expanded(
        child: GridView.count(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(score.length, (index) {
              return _buildActualScoreGridButton(score[index]);
            })));
  }

  Widget _buildActualScoreGridButton(int sc) {
    return RaisedButton(
      child: Text(
        "$sc",
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
      ),
      color: const Color(0xFF268bd2),
      shape: CircleBorder(
        side: BorderSide(
          color: const Color(0xFF002b36),
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      onPressed: () {
        setState(() => _scoreActual = sc);
      },
    );
  }

  Widget _buildActualDirectionButtons() {
    return Container(
      child: _buildActualDirectionGridButtons(),
    );
  }

  Widget _buildActualDirectionGridButtons() {
    // GridViewで方向を並べて表示する
    return Expanded(
        child: GridView.count(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(direction.length, (index) {
              return _buildActualDirectionGridButton(direction[index]);
            })));
  }

  Widget _buildActualDirectionGridButton(String dir) {
    return RaisedButton(
      child: Text(
        dir,
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
      ),
      color: const Color(0xFF6c71c4),
      shape: CircleBorder(
        side: BorderSide(
          color: const Color(0xFF002b36),
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      onPressed: () {
        setState(() => _dirActual = dir);
      },
    );
  }
}
