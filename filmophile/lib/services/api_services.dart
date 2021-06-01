part of 'services.dart';

class ApiServices {
// getMediaList() = mengambil semua daftar movie atau tv show
// NOTES:
// Loading speed nya cuku lama
  static Future<List<Media>> getMediaList(String type) async {
    List<Media> medias = [];

    // looping berdasarkan jumlah page yang kita
    for (int i = 1; i <= 2; i++) {
      String apiURL = Constant.BASE_URL + "/discover/" + type + "?api_key=" + Constant.API_KEY + "&page=" + i.toString();

      var apiResult = await http.get(Uri.parse(apiURL));
      var jsonObject = json.decode(apiResult.body);

      List<dynamic> listMedias =
          (jsonObject as Map<String, dynamic>)['results'];

      for (int i = 0; i < listMedias.length; i++)
        if (type == "movie") {
          medias.add(Media.createMedias(listMedias[i], "title"));
        } else {
          medias.add(Media.createMedias(listMedias[i], "name"));
        }
    }
    return medias;
  }

// getMovieSearch(String id) = mengambil movie yang dicari dalam kolom search
// NOTES:
// Fitur tambahan tapi cukup penting
  // static Future<List<Media>> getMediaSearch(String id, String type) async {}

// getMovieDetail(String id) = mengambil detail movie untuk tampilan detail movie
// NOTES:
//
  static Future<Movie> getMovieDetail(String id) async {
    String apiURL =
        Constant.BASE_URL + "/movie/" + id + "?api_key=" + Constant.API_KEY;

    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body);

    return Movie(
      id: jsonObject['id'].toString(),
      judul: jsonObject['title'],
      overview: jsonObject['overview'],
      backdrop: jsonObject['backdrop_path'],
      tanggal: jsonObject['release_date'],
      genreIds: jsonObject['genres'],
    );
  }

  static Future<TvShow> getTvShowDetail(String id) async {
    String apiURL =
        Constant.BASE_URL + "/tv/" + id + "?api_key=" + Constant.API_KEY;

    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body);

    return TvShow(
      id: jsonObject['id'].toString(),
      judul: jsonObject['name'],
      overview: jsonObject['overview'],
      backdrop: jsonObject['backdrop_path'],
      tanggal: jsonObject['first_air_date'],
      season: jsonObject['number_of_seasons'].toString(),
      episode: jsonObject['number_of_episodes'].toString(),
      genreIds: jsonObject['genres'],
    );
  }

// getGenres(List<String> genreIds) = mengambil genre dari suatu movie dan direturn berupa List<>
// NOTES:
// Mungkin tidak dibutuhkan
  static Future<String> getGenres(List<dynamic> genreIds) async {
    // List<Genre> genreList;
    String genreString = "";

    for (int i = 0; i < genreIds.length; i++) {
    // print("debug");
    // print(genreIds[i]["name"]);
      //mungkin bisa dipake nanti
      // genreList.add(Genre.createGenre(genreIds[i]));

      // genreString.add(genreIds[i]["name"].toString());
      genreString += genreIds[i]["name"];

      if (i != genreIds.length - 1){
        genreString += " | ";
      }
    }

    return genreString;
  }

// getCasts(String id) = mengambil daftar cast berupa list<cast> dengan mengirim parameter id movie
// NOTES:
//
//   static Future<List<Cast>> getCasts(String id) async {}


static Future<List<Media>> getMediaListExplore(String type, String genreId) async {
    List<Media> medias = [];

    // looping berdasarkan jumlah page yang kita
    for (int i = 1; i <= 2; i++) {
      String apiURL = Constant.BASE_URL + "/discover/" + type + "?api_key=" + Constant.API_KEY + "&page=" + i.toString() + "&with_genres=" + genreId;

      var apiResult = await http.get(Uri.parse(apiURL));
      var jsonObject = json.decode(apiResult.body);

      List<dynamic> listMedias =
          (jsonObject as Map<String, dynamic>)['results'];

      for (int i = 0; i < listMedias.length; i++)
        if (type == "movie") {
          medias.add(Media.createMedias(listMedias[i], "title"));
        } else {
          medias.add(Media.createMedias(listMedias[i], "name"));
        }
    }
    return medias;
  }

}
