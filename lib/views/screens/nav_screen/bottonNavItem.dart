import 'package:appforhelp/views/screens/nav_screen/rivermodel.dart';
//import 'package:rive/rive.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({required this.title, required this.rive});
}

List<NavItemModel> bottomNavItems = [

  NavItemModel(
    title: "Home",
    rive: RiveModel(
      src: "assets/gif/animated_icon_set_-_1_color.riv",
      artboard: "HOME",
      stateMachineName: "HOME_Interactivity",
    ),
  ),
  NavItemModel(
    title: "Search",
    rive: RiveModel(
      src: "assets/gif/animated_icon_set_-_1_color.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
    ),
  ),
  NavItemModel(
    title: "Timer",
    rive: RiveModel(
      src: "assets/gif/animated_icon_set_-_1_color.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
    ),
  ),
  NavItemModel(
    title: "Bell",
    rive: RiveModel(
      src: "assets/gif/animated_icon_set_-_1_color.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
    ),
  ),
  NavItemModel(
    title: "User",
    rive: RiveModel(
      src: "assets/gif/animated_icon_set_-_1_color.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
    ),
  ),
];
