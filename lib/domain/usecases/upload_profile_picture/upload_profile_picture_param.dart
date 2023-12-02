import 'dart:io';

import 'package:cineflix_id/domain/entities/user/user.dart';

class UploadProfilePictureParam {
  final File imageFile;
  final User user;

  UploadProfilePictureParam({required this.imageFile, required this.user});
}
