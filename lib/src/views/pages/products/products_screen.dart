import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/plan_card.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  static const _plans = [
    (
      name: 'Forfait Pro',
      status: PlanStatus.active,
      features: [
        PlanFeature(label: 'VOIX', value: '500', unit: 'min'),
        PlanFeature(label: 'DATA', value: '20', unit: 'Go'),
        PlanFeature(label: 'SMS', value: '200', unit: 'sms'),
        PlanFeature(label: 'COÛT/RUN', value: '30', unit: 'fcfa'),
      ],
    ),
    (
      name: 'Forfait Start',
      status: PlanStatus.archive,
      features: [
        PlanFeature(label: 'VOIX', value: '100', unit: 'min'),
        PlanFeature(label: 'DATA', value: '5', unit: 'Go'),
        PlanFeature(label: 'SMS', value: '50', unit: 'sms'),
        PlanFeature(label: 'COÛT/RUN', value: '7', unit: 'fcfa'),
      ],
    ),
    (
      name: 'Forfait Business',
      status: PlanStatus.archive,
      features: [
        PlanFeature(label: 'VOIX', value: '2000', unit: 'min'),
        PlanFeature(label: 'DATA', value: '100', unit: 'Go'),
        PlanFeature(label: 'SMS', value: '1000', unit: 'sms'),
        PlanFeature(label: 'COÛT/RUN', value: '90', unit: 'fcfa'),
      ],
    ),
    (
      name: 'Forfait Essentiel',
      status: PlanStatus.active,
      features: [
        PlanFeature(label: 'VOIX', value: '300', unit: 'min'),
        PlanFeature(label: 'DATA', value: '10', unit: 'Go'),
        PlanFeature(label: 'SMS', value: '100', unit: 'sms'),
        PlanFeature(label: 'COÛT/RUN', value: '15', unit: 'fcfa'),
      ],
    ),
    (
      name: 'Forfait Premium',
      status: PlanStatus.active,
      features: [
        PlanFeature(label: 'VOIX', value: '5000', unit: 'min'),
        PlanFeature(label: 'DATA', value: '200', unit: 'Go'),
        PlanFeature(label: 'SMS', value: '2000', unit: 'sms'),
        PlanFeature(label: 'COÛT/RUN', value: '120', unit: 'fcfa'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.rw, vertical: 20.rh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.textHighlight(
            "Mes produits",
            highlight: "produits",
            fontSize: 22.rsp,
            fontFamily: FontFamily.syne,
          ),
          SizedBox(height: 8.rh),
          AppText(
            "FORFAITS PERSONNALISÉS · COMPUTED_COST AUTO",
            fontSize: 11.rsp,
            color: AppColors.textMuted,
          ),
          SizedBox(height: 30.rh),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16.rw,
              mainAxisSpacing: 16.rh,
              childAspectRatio: 470 / 179,
            ),
            itemCount: _plans.length,
            itemBuilder: (_, i) => PlanCard(
              name: _plans[i].name,
              status: _plans[i].status,
              features: _plans[i].features,
            ),
          ),
        ],
      ),
    );
  }
}