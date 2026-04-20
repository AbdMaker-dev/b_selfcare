import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/reset_password/widgets/reset_password_form.dart';
import 'package:b_selfcare/src/views/widgets/auth_left_panel.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0.0.rw),
          child: Row(
            children: [
              Expanded(child: AuthLeftPanel()),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 531.rw,
                    child: ResetPasswordForm(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
