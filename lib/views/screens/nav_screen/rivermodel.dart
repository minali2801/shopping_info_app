import 'package:rive/rive.dart';

class RiveModel {
  final String src, artboard, stateMachineName;
  late SMIBool? status;

  RiveModel({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
  });

  void setInput(SMIBool state) {
    status = state;
  }
  void triggerAnimation() {
    status?.change(true);
    Future.delayed(const Duration(seconds: 1),
    () {
     status?.change(false);
    }
    );
  }

  // set setState(SMIBool state) {
  //   status = state;
  // }
}
