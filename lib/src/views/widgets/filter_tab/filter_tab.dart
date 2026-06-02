// Modèle générique pour un onglet de filtre



class FilterTab {
  final String label;
  final String? value;
  final int? count;
  const FilterTab({required this.label, this.value, this.count});
}