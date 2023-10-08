import 'package:flutter/material.dart';

import '../widget/all_widget.dart';

class ComingSoonPageForTab extends StatelessWidget {
  const ComingSoonPageForTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: text('Coming Soon...', Colors.black, 18, FontWeight.w600),
    ));
  }
}

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: text('Coming Soon...', Colors.black, 18, FontWeight.w600),
          )),
    );
  }
}


