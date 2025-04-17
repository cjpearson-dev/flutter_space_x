import 'package:flutter/material.dart';

class MinHeightScrollableBody extends StatelessWidget {
  final Widget child;

  final bool centreChild;

  const MinHeightScrollableBody({
    super.key,
    required this.child,
    this.centreChild = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: centreChild ? Center(child: child) : child,
          ),
        );
      },
    );
  }
}
