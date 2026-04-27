
class AppUtilitaire {
  String getInitials(String name) {
    List<String> words = name.trim().split(' ');
    String initials = words
        .take(2)
        .map((word) => word[0].toUpperCase())
        .join();
    return initials;
  }
}