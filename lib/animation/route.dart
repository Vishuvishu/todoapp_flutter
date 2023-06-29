import 'package:flutter/material.dart';

import '../screen/addpage.dart';

Route ScaleAni(child1) {
// final Widget child1; jo aa line lakhay to error aave

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child1,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: animation,
        child: child,
      );
    },
  );
}

Route NewAni1(child1) {
// final Widget child1; jo aa line lakhay to error aave

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child1,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // const begin = Offset(0.0, 1.0);
      // const end = Offset.zero;
      // final tween = Tween(begin: begin, end: end);
      // final offsetAnimation = animation.drive(tween);
      return SlideTransition(
          position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(1.5, 0.0),
      ).animate(animation));
    },
  );
}

// class ScaleAni1 extends PageRouteBuilder{
//   final Widget child1;

//   ScaleAni1(this.child1) : super(pageBuilder: (context,animation,secondaryAnimation)=>child1 );
//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

//     return 
//   }

  // ScaleAni1( {required super.pageBuilder, required this.child1});
  // uper pagebuilder tena pageroutebuilder nu chhe je tene jotu chhe
  // to aapde tene upar ni t=rite or niche ni rite


// }
// ^^^^^^
// both same but one return route and one extends and return 
// vvvvvv


// class ScaleAni extends PageRouteBuilder {
//   final Widget child;

//   ScaleAni({required this.child})
//       : super(
//             transitionDuration: Duration(seconds: 2),
//             pageBuilder: (context, animation, secondaryAnimation) => child);

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {
//     return ScaleTransition(
//       scale: animation,
//       child: child,
//     );
//   }
// }



