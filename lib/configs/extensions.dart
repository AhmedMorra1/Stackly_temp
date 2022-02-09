// Extension for converting strings to bools
extension BoolParsing on String {
  bool parseBool() {
    return this.toLowerCase() == 'true';
    // return true if the string == true or else return false
  }
}
//Capitalize first letter
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
  String? convertToTitleCase() {
    if (this == null) {
      return null;
    }

    if (this.length <= 1) {
      return this.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = this.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }
}