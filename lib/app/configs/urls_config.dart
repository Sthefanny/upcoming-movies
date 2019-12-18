class UrlsConfig {
  static final String apiKey = '?api_key=c5850ed73901b8d268d0898a8a9d8bff';
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String upcomingMoviesUrl = '/movie/upcoming$apiKey';
  final String movieDetailsUrl = '/movie/';
  final String searchMovieUrl = '/search/movie$apiKey';
  final String allGenresUrl = '/genre/movie/list$apiKey';
  final String imageUrl = 'https://image.tmdb.org/t/p/w500';
}
