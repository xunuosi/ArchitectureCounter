class CounterBean {
  int _id;
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

class DbField {
  static final String KEY_ID = "_id";
  static final String KEY_FRONT_CONSTANT = "front_constant";
  static final String KEY_BACK_CONSTANT = "back_constant";
  static final String KEY_BACK_POINT_NUM = "back_pn";
  static final String KEY_BACK_POINT_DISTANCE = "back_pd";
  static final String KEY_BACK_BLACK_NUM = "back_bn";
  static final String KEY_BACK_RED_NUM = "back_rn";
  static final String KEY_FRONT_POINT_NUM = "front_pn";
  static final String KEY_FRONT_POINT_DISTANCE = "front_pd";
  static final String KEY_FRONT_BLACK_NUM = "front_bn";
  static final String KEY_FRONT_RED_NUM = "front_rn";
  static final String KEY_RESULT = "result";

}