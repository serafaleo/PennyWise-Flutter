extension NullableStringExtensions on String? {
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  bool isNotNullOrEmpty() {
    return !isNullOrEmpty();
  }
}

extension StringExtensions on String {
  String toTitleCase() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
