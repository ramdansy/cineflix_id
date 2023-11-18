import 'package:cineflix_id/data/repositories/movie_repository.dart';
import 'package:cineflix_id/domain/entities/actor/actor.dart';
import 'package:cineflix_id/domain/entities/movie/movie.dart';
import 'package:cineflix_id/domain/entities/movie_detail/movie_detail.dart';
import 'package:cineflix_id/domain/entities/result/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TmdbMovieRepository implements MovieRepository {
  final Dio? _dio;
  final String _accessToken = "${dotenv.env["ACCESS_TOKEN"]}";

  late final Options _options = Options(headers: {
    'Authorization': 'Bearer $_accessToken',
    'accept': 'application/json'
  });

  TmdbMovieRepository({required Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<Result<List<Actor>>> getActor({required int id}) async {
    try {
      final response = await _dio!.get(
          '${dotenv.env["BASE_URL"]}/3/movie/$id/credits?language=en-US',
          options: _options);

      final results = List<Map<String, dynamic>>.from(response.data['cast']);

      return Result.success(results.map((e) => Actor.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<MovieDetail>> getDetail({required int id}) async {
    try {
      final response = await _dio!.get(
          '${dotenv.env["BASE_URL"]}/3/movie/$id?language=en-US',
          options: _options);

      return Result.success(MovieDetail.fromJSON(response.data));
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) async =>
      _getMovies(_MovieCategory.nowPlaying.toString(), page: page);

  @override
  Future<Result<List<Movie>>> getUpcoming({int page = 1}) async =>
      _getMovies(_MovieCategory.upcoming.toString(), page: page);

  Future<Result<List<Movie>>> _getMovies(String category,
      {int page = 1}) async {
    try {
      final response = await _dio!.get(
          '${dotenv.env["BASE_URL"]}/3/movie/$category?language=en-US&page=$page',
          options: _options);

      final results = List<Map<String, dynamic>>.from(response.data['results']);

      return Result.success(results.map((e) => Movie.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }
}

enum _MovieCategory {
  nowPlaying('now_playing'),
  upcoming('upcoming');

  final String _instring;

  const _MovieCategory(String inString) : _instring = inString;

  @override
  String toString() => _instring;
}
