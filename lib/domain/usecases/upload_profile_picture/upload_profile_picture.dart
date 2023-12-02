import 'package:cineflix_id/data/repositories/user_repository.dart';
import 'package:cineflix_id/domain/entities/result/result.dart';
import 'package:cineflix_id/domain/entities/user/user.dart';
import 'package:cineflix_id/domain/usecases/upload_profile_picture/upload_profile_picture_param.dart';
import 'package:cineflix_id/domain/usecases/usecase.dart';

class UploadProfilePicture
    implements UseCase<Result<User>, UploadProfilePictureParam> {
  final UserRepository _userRepository;

  UploadProfilePicture({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<User>> call(UploadProfilePictureParam param) => _userRepository
      .uploadProfilePicture(user: param.user, imageFile: param.imageFile);
}
