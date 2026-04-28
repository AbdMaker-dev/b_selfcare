import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/example_model/employe_model.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/example_model/source_employe.dart';
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
    return ListView(
      padding: EdgeInsets.only(bottom: 50.rh),
      children: [
        AppText.textHighlight(
          "Ma flotte",
          highlight: "flotte",
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
        SizedBox(height: 30.rh),
        FilterTabsWidget(
          tabs: const [
            FilterTab(label: 'Tous', count: 1240),
            FilterTab(label: 'Actifs'),
            FilterTab(label: 'Groupes'),
            FilterTab(label: 'Sans produit'),
          ],
          onTabChanged: (index) {
            // Filtrer la liste selon l'index
            print('Tab sélectionné : $index');
          },
        ),
        SizedBox(height: 20.rh),
        Row(
          spacing: 12.rw,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
        SizedBox(height: 20.rh),
        Row(
          spacing: 12.rw,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
        SizedBox(height: 20.rh),
        AppTable(
          title: 'Flotte complète',
          source: SourceEmployes(rows: _employes),
        ),
      ],
    );
  }
}
