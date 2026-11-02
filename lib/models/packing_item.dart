class PackingItem {
  final String id;
  final String name;
  bool isChecked;

  PackingItem({
    required this.id,
    required this.name,
    this.isChecked = false,
  });
}

