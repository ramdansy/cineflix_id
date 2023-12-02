import 'package:cineflix_id/data/repositories/movie_repository.dart';
import 'package:cineflix_id/domain/entities/actor/actor.dart';
import 'package:cineflix_id/domain/entities/result/result.dart';
import 'package:cineflix_id/domain/usecases/get_actors/get_actors_param.dart';
import 'package:cineflix_id/domain/usecases/usecase.dart';

class GetActor implements UseCase<Result<List<Actor>>, GetActorParam> {
  final MovieRepository _movieRepository;

  GetActor({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<List<Actor>>> call(GetActorParam param) async {
    var actorListResult = await _movieRepository.getActor(id: param.movieId);

    return switch (actorListResult) {
      Success(value: final actorList) => Result.success(actorList),
      Failed(:final message) => Result.failed(message)
    };
  }
}
