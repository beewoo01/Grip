import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 200,
      height: 200,
      child: SizedBox(
        height: 200.0,
        width: 200.0,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
