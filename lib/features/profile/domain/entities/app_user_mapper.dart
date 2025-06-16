import '../../data/data_transfer_objects/app_user_dto.dart';
import 'app_user_entity.dart';

/// 🔁 Mapping from DTO → Entity
extension AppUserDtoMapper on AppUserDto {
  AppUser toDomain() => AppUser(id: id, name: name, email: email);
}

/// 🔁 Mapping from Entity → DTO
extension AppUserEntityMapper on AppUser {
  AppUserDto toDto() => AppUserDto(id: id, name: name, email: email);
}
