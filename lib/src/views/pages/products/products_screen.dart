import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/data/models/products_model.dart';
import 'package:b_selfcare/src/views/pages/products/cubit/products_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_empty.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/confirm_dialog.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab_widget.dart';
import 'package:b_selfcare/src/views/widgets/plan_card.dart';
import 'package:b_selfcare/src/views/widgets/product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _cubit = getIt<ProductsCubit>();
  String _activeFilter = 'tous';

  @override
  void initState() {
    super.initState();
    _cubit.fetchProducts();
    _cubit.fetchWallets();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 20.rh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.textHighlight(
                    "Mes produits",
                    highlight: "produits",
                    fontSize: 24.rsp,
                    fontFamily: FontFamily.fraunces,
                    fontStyle: FontStyle.italic,
                    highlightColor: AppColors.warning,
                    fontWeight: FontWeight.w400,
                    highlightFontSize: 24.rsp,
                  ),
                  SizedBox(height: 8.rh),
                  AppText(
                    "FORFAITS PERSONNALISÉS · COMPUTED_COST AUTO",
                    fontSize: 16.rsp,
                    color: AppColors.inputBorderLight,
                  )
                ],
              ),

              AppButton(
                text: 'Produit',
                icon: Icons.add_circle_outline,
                type: AppButtonType.secondary,
                onPressed: () => ProductForm.show(context),
                width: 130.rw,
                height: 60.rh,
                fontSize: 15.rsp,
              ),


            ],
          ),
          SizedBox(height: 20.rh),
          FilterTabsWidget(
            tabs: const [
              FilterTab(label: 'Tous'),
              FilterTab(label: 'Actifs'),
              FilterTab(label: 'Archivés'),
            ],
            onTabChanged: (tab) => setState(() => _activeFilter = tab.label),
          ),
          SizedBox(height: 20.rh),
          BlocSelector<ProductsCubit, ProductsState, ProductsLoaded?>(
            bloc: _cubit,
            selector: (state) => state is ProductsLoaded ? ProductsLoaded() : null,
            builder: (context, state){
              final products = switch (_activeFilter) {
                'Actifs'   => _cubit.products.where((p) => p.isActive == true).toList(),
                'Archivés' => _cubit.products.where((p) => p.isActive != true).toList(),
                _          => _cubit.products,
              };
              if (products.isEmpty) {
                return const AppEmpty(
                  icon: Icons.inventory_2_outlined,
                  title: 'Aucun produit',
                  subtitle: 'Vous n\'avez pas encore de produits configurés.',
                );
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.rw,
                  mainAxisSpacing: 16.rh,
                  childAspectRatio: 470 / 210,
                ),
                itemCount: products.length,
                itemBuilder: (_, i) {
                  final product = products[i];
                  return PlanCard(
                    name: product.name ?? '—',
                    status: product.isActive == true ? PlanStatus.active : PlanStatus.archive,
                    price: product.price??00,
                    features: (product.quotas??[]).map((q)=> PlanFeature(label: q.name??"---", unit: q.unit??"---", value: '${q.quota??0}', price: q.price)).toList(),
                    onDuplicate: () => ProductForm.show(
                      context,
                      product: ProductsModel(
                        name: '${product.name ?? ''} (copie)',
                        description: product.description,
                        quotas: product.quotas
                        ?.map((q) => Quotas(
                          walletId: q.walletId,
                          quota: q.quota,
                          price: q.price,
                          category: q.category,
                          unit: q.unit,
                          name: q.name,
                          code: q.code,
                        ))
                        .toList(),
                      ),
                    ),
                    onEdit: product.isActive == true ? () => ProductForm.show(context, product: product) : null,
                    onArchive: product.id != null && product.isActive == true
                    ? () => AppConfirmDialog.show(
                      context: context,
                      title: 'Archiver le produit',
                      message: 'Le produit "${product.name ?? ''}" sera archivé et ne sera plus disponible. Cette action est irréversible.',
                      confirmLabel: 'Archiver',
                      cancelLabel: 'Annuler',
                      isDanger: true,
                      onConfirm: () => _cubit.archiveProduct(product.id!),
                    )
                    : null,
                  );
                },
              );
            }
          ),
        ],
      ),
    );
  }
}
