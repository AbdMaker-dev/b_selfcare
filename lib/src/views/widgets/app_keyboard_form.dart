import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppKeyboardForm extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final VoidCallback onSubmit;
  final Widget child;

  const AppKeyboardForm({
    super.key,
    this.formKey,
    required this.onSubmit,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final body = formKey != null ? Form(key: formKey, child: child) : child;
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.enter) {
          onSubmit();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: body,
    );
  }
}
