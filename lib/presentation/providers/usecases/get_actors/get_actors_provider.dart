import 'package:cineflix_id/domain/usecases/get_actors/get_actors.dart';
import 'package:cineflix_id/presentation/providers/repositories/movie_repository/movie_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_actors_provider.g.dart';

@riverpod
GetActor getActors(GetActorsRef ref) =>
    GetActor(movieRepository: ref.watch(movieRepositoryProvider));