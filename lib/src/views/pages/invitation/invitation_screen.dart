import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/invitation/widgets/invitation_form.dart';
import 'package:b_selfcare/src/views/widgets/auth_left_panel.dart';
import 'package:flutter/material.dart';

@RoutePage()
class InvitationScreen extends StatelessWidget {
  final String token;

  const InvitationScreen({
    super.key,
    @PathParam('token') required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(child: AuthLeftPanel()),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 531.rw,
                  child: InvitationForm(token: token),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
