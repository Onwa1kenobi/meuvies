extension StringNullExtension on String? {
  String orDefault(String fallback) {
    if (this != null && this?.isNotEmpty == true) {
      return this!;
    } else {
      return fallback;
    }
  }

  String orEmpty() {
    if (this != null) {
      return this!;
    } else {
      return '';
    }
  }

  bool isNullOrEmpty() {
    return this == null || orEmpty().isEmpty;
  }

  bool isNotNullOrEmpty() {
    return this != null && orEmpty().isNotEmpty;
  }
}

List<String> stringList(List<dynamic> data) {
return data.map((e) => e as String).toList();
}