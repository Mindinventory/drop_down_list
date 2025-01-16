/// This is a model class used to represent an item in a selectable list
class SelectedListItem<T> {
  /// Indicates whether the item is selected
  /// Default Value: [false]
  bool isSelected;

  /// Tha data of the item
  final T data;

  final String description;

  SelectedListItem({
    required this.data,
    this.description = "",
    this.isSelected = false,
  });
}
