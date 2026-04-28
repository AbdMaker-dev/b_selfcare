import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/reset_password/widgets/change_password_form.dart';
import 'package:b_selfcare/src/views/widgets/auth_left_panel.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ChangePasswordScreen extends StatelessWidget {
  final String token;
  final String email;
   const ChangePasswordScreen({super.key,
     @QueryParam('token') this.token = '',
     @QueryParam('email') this.email = '',
   });

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
                    child: ChangePasswordForm(
                      email: email,
                      token: token,
                    ),
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
