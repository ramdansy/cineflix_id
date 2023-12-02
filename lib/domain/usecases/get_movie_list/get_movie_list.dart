import '../../../data/repositories/movie_repository.dart';
import '../../entities/movie/movie.dart';
import '../../entities/result/result.dart';
import '../usecase.dart';
import 'get_movie_list_param.dart';

class GetMovieList implements UseCase<Result<List<Movie>>, GetMovieListParam> {
  final MovieRepository _movieRepository;

  GetMovieList({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<Result<List<Movie>>> call(GetMovieListParam param) async {
    var movieResult = switch (param.category) {
      MovieListCategories.nowPlaying =>
        await _movieRepository.getNowPlaying(page: param.page),
      MovieListCategories.upcoming =>
        await _movieRepository.getUpcoming(page: param.page),
    };

    return switch (movieResult) {
      Success(value: final movies) => Result.success(movies),
      Failed(:final message) => Result.failed(message),
    };
  }
}
