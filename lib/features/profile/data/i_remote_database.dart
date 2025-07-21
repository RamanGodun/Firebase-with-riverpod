import 'data_transfer_objects/_user_dto.dart';

/// 📡 [IProfileRemoteDataSource] — abstraction for remote user profile access
/// 🧼 Defines contract for reading or creating user profile from database
//
abstract interface class IProfileRemoteDataSource {
  ///---------------------------------------------
  //
  /// 📥 Fetches existing user doc or creates one if missing
  Future<UserDTO> fetchOrCreateUser(String uid);
  //
}
