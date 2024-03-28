import 'package:catapp/app.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Dialog.fullscreen(
          backgroundColor: Colors.grey.withOpacity(0.4),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}

void showLoadingDialog() {
  showDialog(
    context: navigatorKey.currentContext!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const LoadingDialog();
    },
  );
}

void hideLoadingDialog() {
  Navigator.pop(navigatorKey.currentContext!);
}
