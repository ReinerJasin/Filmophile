part of 'services.dart';

class ApiServices {
// getMediaList() = mengambil semua daftar movie atau tv show
// NOTES:
// tapi untuk sekarang hanya bisa dari 1 page
  static Future<List<Media>> getMediaList(String type) async {

    List<Media> medias = [];

    // looping berdasarkan jumlah page yang kita
    for(int i = 1; i<=2;i++){
    String apiURL =
        Constant.BASE_URL + "/discover/" + type + "?api_key=" + Constant.API_KEY + "&page=" + i.toString();

    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body);

    List<dynamic> listMedias = (jsonObject as Map<String, dynamic>)['results'];

    for (int i = 0; i < listMedias.length; i++)
    if(type == "movie"){
      medias.add(Media.createMedias(listMedias[i], "title"));
    }else{
      medias.add(Media.createMedias(listMedias[i], "name"));
    }
    }
    return medias;
  }

// getMovieSearch(String id) = mengambil movie yang dicari dalam kolom search
// NOTES:
// Fitur tambahan tapi cukup penting
  static Future<List<Media>> getMediaSearch(String id, String type) async {}

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
