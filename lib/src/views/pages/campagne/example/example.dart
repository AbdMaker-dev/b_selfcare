/*
// 1. Fréquence (simple)
SelectField<String>(
label: 'Fréquence',
placeholder: 'Choisir une fréquence',
options: const [
SelectOption(label: 'DAILY - Quotidien', value: 'daily'),
SelectOption(label: 'WEEKLY - Hebdomadaire', value: 'weekly'),
SelectOption(label: 'MONTHLY - Mensuel', value: 'monthly'),
],
onChanged: (opt) => print(opt.value),
),

// 2. Produit avec subtitle (depuis API)
SelectField<int>(
label: 'Produit associé',
placeholder: 'Sélectionner un forfait',
options: produits.map((p) => SelectOption(
label: p.nom,
value: p.id,
subtitle: '${p.prix} FCFA',
)).toList(),
onChanged: (opt) => cubit.setProduit(opt.value),
),

// 3. Ciblage avec enum
SelectField<CiblageType>(
label: 'Ciblage',
options: [
SelectOption(
label: 'GROUPE - Tous les membres',
value: CiblageType.groupe,
),
SelectOption(
label: 'INDIVIDUEL - Par numéro',
value: CiblageType.individuel,
),
],
onChanged: (opt) => setState(() => _ciblage = opt.value),
),*/
