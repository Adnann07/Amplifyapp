import 'package:flutter/material.dart';
import 'subscription_gate.dart';

class SubscriptionWrapper extends StatelessWidget {
  final Widget child;
  final String featureName;

  const SubscriptionWrapper({
    super.key,
    required this.child,
    required this.featureName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SubscriptionGate(
            featureName: featureName,
            child: child,
          ),
        );
      },
      child: AbsorbPointer(child: child), // Disable interactions until subscribed
    );
  }
}
