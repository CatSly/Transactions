import 'package:fluttertoast/fluttertoast.dart';

mixin ToastMixin {
  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
    );
  }
}
