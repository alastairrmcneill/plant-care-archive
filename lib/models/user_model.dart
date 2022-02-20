import 'models.dart';

class AppUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String? profilePictureURL;

  AppUser({
    this.uid = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.profilePictureURL,
  });

  Map<String, Object?> toJSON() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profilePicutreURL': profilePictureURL,
    };
  }

  AppUser copy({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    String? profilePicutreURL,
    List<Plant>? plants,
  }) =>
      AppUser(
        uid: uid ?? this.uid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        profilePictureURL: profilePictureURL ?? this.profilePictureURL,
      );
}
