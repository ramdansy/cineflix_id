import 'package:cineflix_id/data/repositories/authentication.dart';
import 'package:cineflix_id/domain/entities/result/result.dart';
import 'package:cineflix_id/domain/usecases/usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final Authentication _authentication;

  Logout({required Authentication authentication})
      : _authentication = authentication;

  @override
  Future<Result<void>> call(void param) {
    return _authentication.logout();
  }
}
