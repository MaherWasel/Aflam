class Movie {
  String id;
  bool isAdult;
  String orginalTitleText;
  String imageId;
  String imageUrl;
  final IMDBRate;
  final worldRank;
  final voters;
  final releaseYear;
  final streamingOptions;
  String plot;
  final releaseDate;
  Movie({required this.id,required this.isAdult, required this.orginalTitleText,required this.imageId,
  required this.imageUrl,required this.IMDBRate,required this.worldRank,required this.voters,
  required this.releaseYear,required this.streamingOptions,required this.plot,required this.releaseDate});

  

}