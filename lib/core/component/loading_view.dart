import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/constant/colors.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/constant/style.dart';

// class LoadingView extends StatefulWidget {
//   LoadingController loadingController;

//   LoadingView({Key key, @required this.loadingController});

//   @override
//   LoadingViewState createState() => LoadingViewState();
// }

class LoadingView extends StatelessWidget {
  LoadingController loadingController;

  LoadingView({Key? key, required this.loadingController}) : super(key: key);

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.loadingController != null) {
  //     controller = widget.loadingController;
  //   }
  // }

  // @override
  // void setState(fn) {
  //  if (mounted) {
  //     super.setState(fn);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(),
      child: Visibility(
        visible: loadingController._isShowLoading,
        child: Container(
          padding: const EdgeInsets.all(15),
          alignment: Alignment.center,
          color: loadingController._color,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: (!loadingController._isError &&
                    !loadingController._isMessageOnly &&
                    !loadingController._isEmpty),
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.colorPrimary),
                ),
              ),
              Visibility(
                  visible: loadingController._isEmpty,
                  child: Center(
                    child:
                        Text(Strings.norecords, style: Style.text14spBlackBold),
                  )),
              Visibility(
                visible: loadingController._isError ||
                    loadingController._isMessageOnly,
                child: Column(children: <Widget>[
                  Text(
                    loadingController._msg,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: loadingController._isError
                          ? Colors.red
                          : Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Visibility(
                      visible: loadingController._isError,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: ButtonRed(
                            title: Strings.reload,
                            onPressed: () => loadingController._reload),
                      )),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingController {
  bool _isShowLoading = false;
  String _msg = "Error msg";
  bool _isMessageOnly = false;
  bool _isError = false;
  bool _isEmpty = false;
  Function? _reload;
  Color _color = Colors.white;

  void setColor(Color color) {
    _color = color;
  }

  void showMsgOnly(String msg) {
    _msg = msg;
    _isMessageOnly = true;
    _isShowLoading = true;
    _isEmpty = false;
  }

  void showLoading() {
    _isError = false;
    _isMessageOnly = false;
    _isEmpty = false;
    _isShowLoading = true;
  }

  void isEmpty() {
    _isError = false;
    _isMessageOnly = false;
    _isEmpty = true;
    _isShowLoading = true;
  }

  void hideLoading() {
    _isShowLoading = false;
    _isEmpty = false;
  }

  void showError(String msg, Function reload) {
    _msg = msg;
    _reload = reload;
    _isError = true;
    _isEmpty = false;
  }
}
