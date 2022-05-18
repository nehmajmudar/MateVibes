import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:matevibes/res/app_string.dart';

void showConnectivityToastOnPress(ConnectivityResult result) {
  if (result == ConnectivityResult.none) {
    Fluttertoast.showToast(
        msg: AppString.txtnoInternetToast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: AppColors.colorRed,
        textColor: AppColors.colorWhite);
  } else {
    print(result.toString());
  }
}

void showConnectivityToast(ConnectivityResult result) {
  if (result == ConnectivityResult.none) {
    Fluttertoast.showToast(
        msg: AppString.txtnoInternetToast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: AppColors.colorRed,
        textColor: AppColors.colorWhite);
  }
  // Got a new connectivity status!
  // } else if (result == ConnectivityResult.mobile ||
  //     result == ConnectivityResult.wifi) {
  //   Fluttertoast.showToast(
  //       msg: AppString.txtConnectedinternetToast,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.SNACKBAR,
  //       backgroundColor: AppColors.greenColor,
  //       textColor: AppColors.colorWhite);
  // }
  else {
    print(result.toString());
  }
}
