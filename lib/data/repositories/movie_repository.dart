import 'package:cineflix_id/domain/entities/actor/actor.dart';
import 'package:cineflix_id/domain/entities/movie/movie.dart';
import 'package:cineflix_id/domain/entities/movie_detail/movie_detail.dart';
import 'package:cineflix_id/domain/entities/result/result.dart';

abstract interface class MovieRepository {
  Future<Result<List<Movie>>> getNowPlaying({int page = 1});
  Future<Result<List<Movie>>> getUpcoming({int page = 1});
  Future<Result<List<MovieDetail>>> getDetail({required int id});
  Future<Result<List<Actor>>> getActor({required int id});
}
