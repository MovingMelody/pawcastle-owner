class Language {
  final String languageId;
  final String name;
  final String text;
  final bool isSelected;

  Language({
    required this.languageId,
    required this.name,
    required this.text,
    this.isSelected = false,
  });

  Language copyWith({
    String? languageId,
    String? name,
    String? text,
    bool? isSelected,
  }) {
    return Language(
      languageId: languageId ?? this.languageId,
      name: name ?? this.name,
      text: text ?? this.text,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
