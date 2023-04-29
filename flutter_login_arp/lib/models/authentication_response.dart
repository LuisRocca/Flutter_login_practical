class AuthenticationResponse {
  final String token;
  final int expiresIn;

  AuthenticationResponse({required this.token, required this.expiresIn});

  static AuthenticationResponse fromJson(Map<String, dynamic> json) {
    return AuthenticationResponse(
        token: json['token'], expiresIn: json['expiresIn']);
  }
}
