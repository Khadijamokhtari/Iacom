import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import '../sidebar/menu_item.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
          right: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Colors.pink,
                      alignment: Alignment.centerRight,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color:  Colors.pink,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
                      ListTile(
                        title: Text(
                          "IΛCOM", textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900,fontFamily: "Champagne&LimousinesBold"),
                        ),
                        subtitle: Text(
                          "Expert en stratégie digitale",textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),

                      ),
                      Divider(
                        height: 40,
                        thickness: 0.5,
                        color: Colors.white,
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.person,
                        title: "Mon espace",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.LoginClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: "Accueil",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.BodyClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.format_list_bulleted,
                        title: "Nos Services",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.ServiceListScreenClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.work,
                        title: "Nos Packs",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.PackListScreenClickedEvent);
                        },
                      ),
                      MenuItem(
                        icon: Icons.blur_on,
                        title: "Actualités",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.ActualiteListScreenClickedEvent);
                        },
                      ),

                      MenuItem(
                        icon: Icons.near_me,
                        title: "Contact",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.ContactClickedEvent);
                        },
                      ),
                      Divider(
                        height: 40,
                        thickness: 0.5,
                        color: Colors.white,
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app,
                        title: "Quitter",
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(width, 0);
    path.quadraticBezierTo(width, 8, width -10, 16);
    path.quadraticBezierTo( 1, height / 2 - 20, 0, height / 2);
    path.quadraticBezierTo(- 1, height / 2 + 20, width-10, height - 16);
    path.quadraticBezierTo(width, height - 8, width, height);
    path.close();
    /*path.moveTo(width, 0);
    path.quadraticBezierTo(width, 8, 10, 16);
    path.quadraticBezierTo(0, height / 2 , width, height / 2);
    path.quadraticBezierTo(0, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(width, height - 8, width, height);*/
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
