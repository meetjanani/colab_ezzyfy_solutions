import 'package:flutter/material.dart';

class ColabLoaderWidget extends StatelessWidget {
  final bool loading;
  final Widget child;

  const ColabLoaderWidget(
      {required this.child, required this.loading, super.key});

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : child;
  }
}
