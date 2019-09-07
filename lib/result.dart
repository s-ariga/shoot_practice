// 結果表示ページ
import 'package:flutter/material.dart';
import 'shots.dart';

class ResultPage extends StatelessWidget {
  static const routeName = '/resultPage';

  @override
  Widget build(BuildContext context) {
    final Shots shots = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('結果! 　${shots.results.length}発'),
      ),
      body: new Row(
          children: <Widget> [
            Expanded(
            child: ListView.builder(
            itemCount: shots.results.length,
            itemBuilder: (context, index) {
              return ListTile(
            title: Text("${index+1}発目  ${shots.results[index].toString()}"),
          );
        }
      ),
            ),
            Expanded(
                child: new Column(
                    children: <Widget> [
                      new Text('点数的中 ${(shots.scoreAtari()*100).toStringAsFixed(1)}%'),
                      new Text('矢印的中 ${(shots.dirAtari()*100).toStringAsFixed(1)}%'),
                      new Text('合計 ${shots.totalScore()}'),
                      new Text('平均 ${(shots.totalScore()/shots.results.length).toStringAsFixed(1)}')
                    ]
                )
            ),
        ],
      )
      /*
      body: new Row(
        children: <Widget> [
          ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text("$index"),
              );
            },
          ),
          new Column(
            children: <Widget> [
              new Text('\%'),
              new Text('点'),
              new Text('点')
            ]
          )
        ]
      )
        */
    );
  }
}