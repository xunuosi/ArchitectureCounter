class CounterBean {
  String exportPath;
  // 前尺常数
  double frontConstant;
  // 后尺常数
  double backConstant;
  // 后视点号
  double backPointNum;
  // 后视距离
  double backPointDistance;
  // 后视黑面读数
  double backBlackNum;
  // 后视红面读数
  double backRedNum;
  // 前视点号
  double frontPointNum;
  // 前视距离
  double frontPointDistance;
  // 前视黑面读数
  double frontBlackNum;
  // 前视红面读数
  double frontRedNum;

  void reset() {
    backPointNum = 0;
    backPointDistance = 0;
    backBlackNum = 0;
    backRedNum = 0;
    frontPointNum = 0;
    frontPointDistance = 0;
    frontBlackNum = 0;
    frontRedNum = 0;
  }

  @override
  String toString() {
    return 'CounterBean{exportPath: $exportPath, frontConstant: $frontConstant, backConstant: $backConstant, backPointNum: $backPointNum, backPointDistance: $backPointDistance, backBlackNum: $backBlackNum, backRedNum: $backRedNum, frontPointNum: $frontPointNum, frontPointDistance: $frontPointDistance, frontBlackNum: $frontBlackNum, frontRedNum: $frontRedNum}';
  }
}