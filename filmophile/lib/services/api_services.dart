part of 'services.dart';

class ApiServices {
// getMovieList() = mengambil semua daftar movies
// NOTES:
// tapi untuk sekarang hanya bisa dari 1 page
  static Future<List<Movie>> getMovieList() async {

    List<Movie> movies = [];

    // looping berdasarkan jumlah page yang kita
    for(int i = 1; i<=2;i++){
    String apiURL =
        Constant.BASE_URL + "/discover/movie?api_key=" + Constant.API_KEY + "&page=" + i.toString();

    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body);

    List<dynamic> listMovies = (jsonObject as Map<String, dynamic>)['results'];

    for (int i = 0; i < listMovies.length; i++)
      movies.add(Movie.createMovie(listMovies[i]));
    }
    return movies;
  }

// getMovieSearch(String id) = mengambil movie yang dicari dalam kolom search
// NOTES:
// Fitur tambahan tapi cukup penting
  static Future<List<Movie>> getMovieSearch(String id) async {}

// getMovieDetail(String id) = mengambil detail movie untuk tampilan detail movie
// NOTES:
//
  static Future<Movie> getMovieDetail(String id) async {}

// getGenres(List<String> genreIds) = mengambil genre dari suatu movie dan direturn berupa List<>
// NOTES:
// Mungkin tidak dibutuhkan
  // static Future<List<Genre>> getGenres(List<String> genreIds) async {}

// getCasts(String id) = mengambil daftar cast berupa list<cast> dengan mengirim parameter id movie
// NOTES:
//
  static Future<List<Cast>> getCasts(String id) async {}
}
