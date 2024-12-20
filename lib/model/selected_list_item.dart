/// This is a model class used to represent an item in a selectable list
class SelectedListItem {
  /// Indicates whether the item is selected
  /// Default Value: [false]
  bool isSelected;

  /// The name or label of the item
  String name;

  /// An optional value associated with the item
  String? value;

  SelectedListItem({
    required this.name,
    this.value,
    this.isSelected = false,
  });
}
