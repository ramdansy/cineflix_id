import 'package:cineflix_id/domain/entities/actor/actor.dart';
import 'package:cineflix_id/domain/entities/result/result.dart';
import 'package:cineflix_id/domain/usecases/get_actors/get_actors.dart';
import 'package:cineflix_id/domain/usecases/get_actors/get_actors_param.dart';
import 'package:cineflix_id/presentation/providers/usecases/get_actors/get_actors_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_provider.g.dart';

@riverpod
Future<List<Actor>> actors(ActorsRef ref, {required int movieId}) async {
  GetActor getActors = ref.read(getActorsProvider);

  var actorResult = await getActors(GetActorParam(movieId: movieId));

  return switch (actorResult) {
    Success(value: final actors) => actors,
    Failed(message: _) => const [],
  };
}
