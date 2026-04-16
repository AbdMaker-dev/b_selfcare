import 'package:b_selfcare/src/views/pages/login/widgets/login_form.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/auth_left_panel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    child: LoginForm(),
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
