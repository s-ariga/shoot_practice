// 成績データクラス
class Shots{
  int shots;
  List<Shot> results;

  Shots() {
    shots = 0;
    results = [];
  }

  int totalScore() {
    int sum = 0;
    results.forEach((Shot s) {sum += s.scoreActual;});
    return sum;
  }

  double scoreAtari() {
    double p = 0.0;
    results.forEach((Shot s) {if(s.scorePredict == s.scoreActual) {p++;}});
    return p/results.length;
  }

  double dirAtari() {
    double p = 0.0;
    results.forEach((Shot s) {if(s.dirPredict == s.dirActual) {p++;}});
    return p/results.length;
  }

  void pushResult(int sp, String dp, int sa, String da) {
    //結果をclass Shotとして保存する
    results.add(new Shot(sp, dp, sa, da));
  }
}

class Shot{
  int scorePredict;
  String dirPredict;
  int scoreActual;
  String dirActual;

  Shot(int sp, String dp, int sa, String da) {
    // 成績をセットして初期化
    this.scorePredict = sp;
    this.dirPredict = dp;
    this.scoreActual = sa;
    this.dirActual = da;
  }

  final dirString = ["↑","↗","→","↘","↓","↙","←","↖"];

  bool scoreHit() {
    if(scorePredict == scoreActual) {
      return true;
    }
    return false;
  }

  bool dirHit() {
    if(dirPredict == dirActual) {
      return true;
    }
    return false;
  }


  String toString() {
    // とりあえず、文字にして返す
    return "$scorePredict $dirPredict $scoreActual $dirActual";

  }

  String dirToString(int dir) {
    // 方向を番号から矢印に直す
    // parameters:
    // dir 方向。北を0として45°時計回りの8方向
    // returns:
    // 矢印
    if(dir < dirString.length) {
      return dirString[dir];
    }else {
      return "";
    }
  }
}