// 1 provide the provider يعني اعرف الابلكيشن ان في بروفايدر موجود
// بعمل كلاس البروفيدر وبكتب فيه اكوادي
//notfylisner بتقول ان في تغير حصل
// consumer بيسمع للتغيرات

import 'package:flutter/material.dart';
import 'package:flutter_train/screens/post_details.dart';

class ChangeLikeProvider extends ChangeNotifier {
  bool isLike = false;

  changLike() {
    isLike = !isLike;
    notifyListeners();
  }


  
}
