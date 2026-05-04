import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/example_model/employe_model.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/example_model/source_employe.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab_widget.dart';
import 'package:b_selfcare/src/views/widgets/info_flotte_card.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class MyFlotteScreen extends StatefulWidget {
  const MyFlotteScreen({super.key});

  @override
  State<MyFlotteScreen> createState() => _MyFlotteScreenState();
}

class _MyFlotteScreenState extends State<MyFlotteScreen> {
  static final _employes = [
    const EmployeModel(
      name: 'Aminata NDIAYE',
      group: 'DIRECTION',
      phone: '+221 76 490 74 94',
      product: 'Premium Fleet',
      status: 'ACTIF',
    ),
    const EmployeModel(
      name: 'Kana S. GUEYE',
      group: 'RH',
      phone: '+221 76 987 65 43',
      product: 'Forfait Eco',
      status: 'SUSPENDU',
    ),
    const EmployeModel(
      name: 'Pape Samba NDOUR',
      group: 'COMMERCIAL',
      phone: '+221 76 123 45 67',
      product: 'Forfait Standard',
      status: 'ACTIF',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return ListView(
      padding: EdgeInsets.only(bottom: 50.rh),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.textHighlight(
                  s.myFlotte,
                  highlight: s.flotte,
                  fontSize: 22.rsp,
                  highlightColor: Colors.green,
                  fontFamily: FontFamily.syne,
                ),
                SizedBox(height: 8.rh),
                AppText(
                  "1 240 MSISDN . 8 GROUPES . 1 150 EMPLOYÉS",
                  fontSize: 11.rsp,
                  color: AppColors.textMuted,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                AppButton(
                  text: s.simSwap,
                  type: AppButtonType.outline,
                  icon: Icons.swap_horiz,
                  width: 130.rw,
                  height: 38.rh,
                  fontSize: 13.rsp,
                  onPressed: () {},
                ),
                SizedBox(width: 10.rw),
                AppButton(
                  text: "+ Employé",
                  type: AppButtonType.secondary,
                  width: 130.rw,
                  height: 38.rh,
                  fontSize: 13.rsp,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 30.rh),
        FilterTabsWidget(
          tabs: const [
            FilterTab(label: 'Tous', count: 1240),
            FilterTab(label: 'Actifs'),
            FilterTab(label: 'Groupes'),
            FilterTab(label: 'Sans produit'),
          ],
          onTabChanged: (model) {
            // Filtrer la liste selon l'index
            print('Tab sélectionné : $model');
            print(model.label);
          },
        ),
        SizedBox(height: 20.rh),
        LayoutBuilder(
          builder: (context, constraints) {
            final totalWidth = constraints.maxWidth;
            final crossAxisCount = totalWidth > 900 ? 3 : totalWidth > 550 ? 2 : 1;
            final spacing = 12.rw;
            final cardWidth = (totalWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;
            final cards = [
              InfoFlotteCard(
                name: "Ousman Adda NAPAL",
                department: "DIRECTION",
                forfait: "Forfait Standard",
                phone: "+221764203333",
                status: true,
              ),
              InfoFlotteCard(
                name: "Ousman Adda NAPAL",
                department: "Commercial",
                forfait: "Forfait Standard",
                phone: "+221764203333",
                status: true,
              ),
              InfoFlotteCard(
                name: "Ousman ZARA",
                department: "RH",
                forfait: "Forfait Eco",
                phone: "+221764203333",
                status: false,
              ),
              InfoFlotteCard(
                name: "Ousman Adda NAPAL",
                department: "DIRECTION",
                forfait: "Forfait Standard",
                phone: "+221764203333",
                status: true,
              ),
              InfoFlotteCard(
                name: "Ousman Adda NAPAL",
                department: "Commercial",
                forfait: "Forfait Standard",
                phone: "+221764203333",
                status: true,
              ),
              InfoFlotteCard(
                name: "Ousman ZARA",
                department: "RH",
                forfait: "Forfait Eco",
                phone: "+221764203333",
                status: false,
              ),
            ];
            return Wrap(
              spacing: spacing,
              runSpacing: 12.rh,
              children: cards
                  .map((card) => SizedBox(width: cardWidth, child: card))
                  .toList(),
            );
          },
        ),
        SizedBox(height: 20.rh),
        AppTable(
          title: s.flotteComplete,
          source: SourceEmployes(rows: _employes),
        ),
      ],
    );
  }
}
