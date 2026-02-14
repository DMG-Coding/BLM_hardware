// Service d'authentification simple (en mémoire)
class AuthService {
  // Liste des utilisateurs (en mémoire - sera perdu au redémarrage)
  static List<Map<String, String>> _users = [];

  // Inscription
  static void signup(String email, String password) {
    _users.add({
      'email': email,
      'password': password,
    });
  }

  // Connexion
  static bool login(String email, String password) {
    return _users.any(
      (user) => user['email'] == email && user['password'] == password,
    );
  }

  // Vérifier si un email existe déjà
  static bool emailExists(String email) {
    return _users.any((user) => user['email'] == email);
  }

  // Obtenir le nombre d'utilisateurs (pour debug)
  static int getUserCount() {
    return _users.length;
  }
}
