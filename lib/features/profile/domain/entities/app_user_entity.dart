import 'package:equatable/equatable.dart';

/// 👤 [AppUser] — domain entity that represents an authenticated user

class AppUser extends Equatable {
  ///---------------------------

  final String id;
  final String name;
  final String email;

  const AppUser({required this.id, required this.name, required this.email});

  /// 🔁 Copy with updated fields
  AppUser copyWith({String? id, String? name, String? email}) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [id, name, email];

  //
}
