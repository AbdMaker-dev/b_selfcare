class SelectOptionModel<T> {
  final String label;
  final T value;
  final String? subtitle;

  const SelectOptionModel({
    required this.label,
    required this.value,
    this.subtitle,
  });
}