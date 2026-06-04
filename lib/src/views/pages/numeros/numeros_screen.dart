import 'package:b_selfcare/src/views/pages/numeros/numeros_content.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class NumerosScreen extends StatelessWidget {
  const NumerosScreen({super.key});

  @override
  Widget build(BuildContext context) => const NumerosContent();
}
