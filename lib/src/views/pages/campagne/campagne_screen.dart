import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/campagne/widgets/source_campagne.dart';
import 'package:b_selfcare/src/views/pages/campagne/widgets/source_historique_campagne.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_field.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:b_selfcare/src/views/widgets/table/title_table.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../my_flotte/widgets/employe_model.dart';

@RoutePage()
class CampagneScreen extends StatefulWidget {
  const CampagneScreen({super.key});

  @override
  State<CampagneScreen> createState() => _CampagneScreenState();
}

class _CampagneScreenState extends State<CampagneScreen> {
  final TextEditingController _nameController = TextEditingController();
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

  static const _historiqueFilters = <TableFilter>[
    (label: 'Tous', value: 'tous'),
    (label: 'Succès', value: 'succes'),
    (label: 'Erreur', value: 'erreur'),
  ];

  String _selectedHistoriqueFilter = 'tous';

  List<EmployeModel> get _filteredHistorique {
    return switch (_selectedHistoriqueFilter) {
      'succes' => _employes.where((e) => e.status == 'Succès').toList(),
      'erreur' => _employes.where((e) => e.status == 'Echec').toList(),
      _ => _employes,
    };
  }

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
                  s.myCampagne,
                  highlight: s.campagne,
                  fontSize: 22.rsp,
                  highlightColor: AppColors.warning,
                  fontFamily: FontFamily.syne,
                ),
                SizedBox(height: 8.rh),
                AppText(
                  "Provisioning automatique - CBS - DAILY / WEEKLY / MONTHLY",
                  fontSize: 11.rsp,
                  color: AppColors.textMuted,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                AppButton(
                  text: "+ ${s.campagne}",
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
        Container(
          height: 370.rh,
          padding: EdgeInsets.all(12.rw),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.rr),
            border: Border.all(color: AppColors.gray),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "Créer une campagne",
                fontSize: 18.rsp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              SizedBox(height: 20.rh),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppInput(
                      labelText: s.nameCampagne,
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      hintText: "Ex:Dotation mensuelle Direction",
                    ),
                  ),
                  SizedBox(width: 16.rw),
                  Expanded(
                    child: SelectField<String>(
                      label: 'Fréquence',
                      placeholder: 'Choisir une fréquence',
                      options: const [
                        SelectOptionModel(label: 'DAILY - Quotidien',      value: 'daily'),
                        SelectOptionModel(label: 'WEEKLY - Hebdomadaire',  value: 'weekly'),
                        SelectOptionModel(label: 'MONTHLY - Mensuel',      value: 'monthly'),
                      ],
                      onChanged: (opt) => debugPrint(opt.value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.rh),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SelectField<String>(
                      label: 'Fréquence',
                      placeholder: 'Choisir une fréquence',
                      options: const [
                        SelectOptionModel(label: 'DAILY - Quotidien',      value: 'daily'),
                        SelectOptionModel(label: 'WEEKLY - Hebdomadaire',  value: 'weekly'),
                        SelectOptionModel(label: 'MONTHLY - Mensuel',      value: 'monthly'),
                      ],
                      onChanged: (opt) => debugPrint(opt.value),
                    ),
                  ),
                  SizedBox(width: 16.rw),
                  Expanded(
                    child: SelectField<String>(
                      label: 'Ciblage',
                      placeholder: 'Choisir un ciblage',
                      options: const [
                        SelectOptionModel(label: 'DAILY - Quotidien',      value: 'daily'),
                        SelectOptionModel(label: 'WEEKLY - Hebdomadaire',  value: 'weekly'),
                        SelectOptionModel(label: 'MONTHLY - Mensuel',      value: 'monthly'),
                      ],
                      onChanged: (opt) => debugPrint(opt.value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.rh),
              SizedBox(
                width: 250.rw,
                child: AppButton(
                  text: s.planingCampagne,
                  onPressed: () {
                  },
                  type: AppButtonType.secondary
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.rh),
        AppTable(
          title: s.myCampagne,
          source: SourceCampagne(rows: _employes),
        ),
        SizedBox(height: 30.rh),
        AppTable(
          title: s.historique,
          source: SourceHistoriqueCampagne(rows: _employes),
          filters: _historiqueFilters,
          selectedFilter: _selectedHistoriqueFilter,
          onFilterChanged: (value) {
            debugPrint('Napal $value');
            setState(() {
              _selectedHistoriqueFilter = value;
            });
          },
        ),
      ],
    );
  }
}
