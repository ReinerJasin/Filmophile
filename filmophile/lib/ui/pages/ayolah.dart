// part of 'pages.dart';

// class DetailTv extends StatefulWidget {
//   final String tvId;

//   const DetailTv({Key key, this.tvId}) : super(key: key);
//   @override
//   _DetailTvState createState() => _DetailTvState();
// }

// class _DetailTvState extends State<DetailTv> {
//   TvShow tvShow;
//   String judulCard = "";
//   List<String> genreList;
//   String genreCard = "";

//   // Untuk menu
//   List<String> categories = ["Progress", "Information", "Friends"];
//   List<IconData> categories_icon = [
//     Icons.bar_chart,
//     Icons.info_outlined,
//     Icons.people_outlined
//   ];
//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     ApiServices.getTvShowDetail(widget.tvId).then((value) => {
//           setState(() {
//             tvShow = new TvShow(
//               id: value.id,
//               judul: value.judul,
//               overview: value.overview,
//               backdrop: value.backdrop,
//               tanggal: value.tanggal,
//               season: value.season,
//               episode: value.episode,
//               genreIds: value.genreIds,
//             );
//             judulCard = tvShow.judul + " (";
//             judulCard += tvShow.tanggal.substring(0, 4);
//             judulCard += ")";

//             // ApiServices.getGenres(tvShow.genreIds).then((value) => {
//             //       genreCard = value,
//             //     });
//           })
//         });
//     ApiServices.getGenres(tvShow.genreIds).then((value) => {
//           setState(() {
//             // genreList = value;
//             // for (int i = 0; i < genreList.length; i++) {
//             genreCard = value;
//             print("DEBUG 2");
//             print(genreList);
//             // }
//           })
//         });

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "TV Show Detail",
//           style: TextStyle(
//               color: filmophileBlue,
//               fontFamily: GoogleFonts.righteous().fontFamily),
//         ),
//         iconTheme: IconThemeData(color: filmophileBlue),
//       ),
//       body: Column(
//         children: [
//           (tvShow != null)
//               ? Stack(
//                   children: [
//                     // Kalau ada datanya
//                     Container(
//                       width: double.infinity,
//                       height: MediaQuery.of(context).size.width * 11 / 18,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: NetworkImage(
//                               Constant.IMAGE_BASE_URL + tvShow.backdrop,
//                             ),
//                             fit: BoxFit.cover),
//                         color: filmophileSoftBlue,
//                       ),
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: MediaQuery.of(context).size.width * 11 / 18,
//                       decoration: BoxDecoration(
//                         color: filmophileSoftBlue,
//                         gradient: LinearGradient(
//                           begin: FractionalOffset.topCenter,
//                           end: FractionalOffset.bottomCenter,
//                           colors: [
//                             Colors.transparent,
//                             Colors.black.withOpacity(0.7)
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: MediaQuery.of(context).size.height -
//                           (MediaQuery.of(context).size.width * 11 / 18) -
//                           80 +
//                           20,
//                       margin: EdgeInsets.only(
//                           top: (MediaQuery.of(context).size.width * 11 / 18) -
//                               20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20)),
//                         color: Colors.white,
//                       ),
//                       child: Container(
//                         child: ListView(
//                           children: [
//                             Container(
//                               margin:
//                                   EdgeInsets.only(top: 12, left: 12, right: 12),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     judulCard,
//                                     style: TextStyle(
//                                       fontFamily:
//                                           GoogleFonts.righteous().fontFamily,
//                                       fontSize: 28,
//                                       color: filmophileBlue,
//                                     ),
//                                   ),
//                                   Text(
//                                     genreCard,
//                                     style: TextStyle(
//                                       fontFamily:
//                                           GoogleFonts.rhodiumLibre().fontFamily,
//                                       fontSize: 18,
//                                       color: filmophileBlue,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 50,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: categories.length,
//                                 itemBuilder: (context, index) =>
//                                     buildCategory(index),
//                               ),
//                             ),
//                             Container(
//                               width: double.infinity,
//                               child: buildMenu(selectedIndex),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               : Text("nd ada data")
//         ],
//       ),
//     );
//   }

//   Container buildMenu(int index) {
//     if (index == 0) {
//       return Container(
//         width: MediaQuery.of(context).size.width,
//         margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Progress",
//               style: TextStyle(
//                 color: filmophileBlue,
//                 fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
//                 fontSize: 24,
//               ),
//             ),

//             // SEASON PROGRESS
//             Row(
//               children: [
//                 Text(
//                   "1/" + tvShow.season,
//                   style: TextStyle(
//                     color: filmophileBlue,
//                     fontFamily: GoogleFonts.righteous().fontFamily,
//                     fontSize: 18,
//                   ),
//                 ),
//                 Text(
//                   " Season(s) ",
//                   style: TextStyle(
//                     color: filmophileBlue,
//                     fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
//                     fontSize: 18,
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(
//                       left: MediaQuery.of(context).size.width * 0.52),
//                   child: Text(
//                     "50%",
//                     style: TextStyle(
//                       color: filmophileBlue,
//                       fontFamily: GoogleFonts.righteous().fontFamily,
//                       fontSize: 18,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             Stack(
//               children: [
//                 Container(
//                   height: 8,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     color: filmophileGrey,
//                   ),
//                 ),
//                 Container(
//                   height: 8,
//                   width: MediaQuery.of(context).size.width *
//                       1 /
//                       int.parse(tvShow.season),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     color: filmophileOrange,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(
//               height: 12,
//             ),

//             // EPISODE PROGRESS
//             Row(
//               children: [
//                 Text(
//                   "6/" + tvShow.episode,
//                   style: TextStyle(
//                     color: filmophileBlue,
//                     fontFamily: GoogleFonts.righteous().fontFamily,
//                     fontSize: 18,
//                   ),
//                 ),
//                 Text(
//                   " Episode(s) ",
//                   style: TextStyle(
//                     color: filmophileBlue,
//                     fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
//                     fontSize: 18,
//                   ),
//                 ),
//                 Container(
//                   width: 75,
//                   margin: EdgeInsets.only(
//                       left: MediaQuery.of(context).size.width * 0.44),
//                   child: Text(
//                     (1 / int.parse(tvShow.episode)).round().toString(),
//                     style: TextStyle(
//                       color: filmophileBlue,
//                       fontFamily: GoogleFonts.righteous().fontFamily,
//                       fontSize: 18,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             Stack(
//               children: [
//                 Container(
//                   height: 8,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     color: filmophileGrey,
//                   ),
//                 ),
//                 Container(
//                   height: 8,
//                   width: MediaQuery.of(context).size.width *
//                       1 /
//                       int.parse(tvShow.episode),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     color: filmophileOrange,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(
//               height: 16,
//             ),

//             Text(
//               "Timestamp",
//               style: TextStyle(
//                 color: filmophileBlue,
//                 fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
//                 fontSize: 24,
//               ),
//             ),
//             Container(
//               child: Text(
//                 "01 : 25 : 39",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontFamily: GoogleFonts.righteous().fontFamily,
//                   fontSize: 32,
//                   color: Colors.white,
//                 ),
//               ),
//               width: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.only(top: 8, bottom: 8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: filmophileBlue,
//               ),
//             ),
//             Text(
//               "Notes",
//               style: TextStyle(
//                 color: filmophileBlue,
//                 fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
//                 fontSize: 24,
//               ),
//             ),
//             Container(
//               child: Text(
//                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tincidunt libero ut mi auctor, id volutpat risus tincidunt. Proin malesuada sem justo, at vestibulum lacus ornare nec.",
//                 textAlign: TextAlign.justify,
//                 style: TextStyle(
//                   fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
//                   fontSize: 14,
//                   color: Colors.white,
//                 ),
//               ),
//               width: MediaQuery.of(context).size.width,
//               padding:
//                   EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: filmophileBlue,
//               ),
//             ),
//           ],
//         ),
//       );
//     } else if (index == 1) {
//       return Container();
//     } else {
//       return Container();
//     }
//   }

//   Widget buildCategory(int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedIndex = index;
//         });
//       },
//       child: Column(
//         children: [
//           (selectedIndex == index)
//               ? Container(
//                   color: Colors.transparent,
//                   // margin: EdgeInsets.only(top: 5),
//                   width: MediaQuery.of(context).size.width * 0.333333,
//                   child: Column(
//                     children: [
//                       Icon(
//                         categories_icon[index],
//                         color: filmophileOrange,
//                       ),
//                       Text(
//                         categories[index],
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: filmophileOrange,
//                           fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : Container(
//                   color: Colors.transparent,
//                   // margin: EdgeInsets.only(top: 5),
//                   width: MediaQuery.of(context).size.width * 0.333333,
//                   child: Column(
//                     children: [
//                       Icon(
//                         categories_icon[index],
//                         color: filmophileBlue,
//                       ),
//                       Text(
//                         categories[index],
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: filmophileBlue,
//                           fontFamily: GoogleFonts.rhodiumLibre().fontFamily,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//           // Container(
//           //   alignment: Alignment.center,
//           //   height: 4,
//           //   width: 50,
//           //   color:
//           //       selectedIndex == index ? filmophileOrange : Colors.transparent,
//           // ),
//         ],
//       ),
//     );
//   }
// }
