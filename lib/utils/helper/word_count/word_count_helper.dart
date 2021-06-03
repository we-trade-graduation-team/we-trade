class WordCountHelper {
  WordCountHelper._();

  static Map<String, int> countWords(String sentence) {
    final words = RegExp(r"\w+(\'\w+)?");

    return words
        .allMatches(sentence)
        .map((item) => item.group(0)!.toLowerCase())
        .fold(<String, int>{}, (wordCounts, word) {
      if (wordCounts.containsKey(word)) {
        wordCounts[word] = wordCounts[word]! + 1;
      } else {
        wordCounts[word] = 1;
      }
      return wordCounts;
    });
  }
}
