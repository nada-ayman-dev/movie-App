class User {
  final String id;
  final String email;
  final String username;
  final String? token;

  const User({
    required this.id,
    required this.email,
    required this.username,
    this.token,
  });
}
