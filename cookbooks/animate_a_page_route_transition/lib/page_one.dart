import 'package:animate_a_page_route_transition/page_two.dart';
import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  Route<void> get _routeToPageTwo {
    return PageRouteBuilder<void>(
      pageBuilder: (_, __, ___) => const PageTwo(),
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page one'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push<void>(context, _routeToPageTwo),
          child: const Text('Page two'),
        ),
      ),
    );
  }
}
