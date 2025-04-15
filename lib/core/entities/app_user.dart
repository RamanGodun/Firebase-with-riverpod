import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable(explicitToJson: true)
class AppUser extends Equatable {
  final String id;
  final String name;
  final String email;

  const AppUser({this.id = '', this.name = '', this.email = ''});

  /// Factory method for Firebase snapshot
  factory AppUser.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return AppUser(
      id: doc.id,
      name: data?['name'] ?? '',
      email: data?['email'] ?? '',
    );
  }

  /// Factory method for JSON
  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  ///  Convert to JSON
  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  /// CopyWith
  AppUser copyWith({String? id, String? name, String? email}) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [id, name, email];
}
