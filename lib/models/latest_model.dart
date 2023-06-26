class LatestModel {
  LatestModel({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  LatestModel.fromJson(dynamic json) {
    adult = json['adult'] ?? false;
    backdropPath = json['backdrop_path'];
    belongsToCollection = json['belongs_to_collection'];
    budget = json['budget'] ?? 0;
    if (json['genres'] != null) {
      genres = List<dynamic>.from(json['genres']);
    }
    homepage = json['homepage'] ?? "";
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'] ?? "";
    popularity = json['popularity'] ?? 0.0;
    posterPath = json['poster_path'];
    if (json['production_companies'] != null) {
      productionCompanies = List<dynamic>.from(json['production_companies']);
    }
    if (json['production_countries'] != null) {
      productionCountries = List<dynamic>.from(json['production_countries']);
    }
    releaseDate = json['release_date'] ?? "";
    revenue = json['revenue'] ?? 0;
    runtime = json['runtime'] ?? 0;
    if (json['spoken_languages'] != null) {
      spokenLanguages = List<dynamic>.from(json['spoken_languages']);
    }
    status = json['status'] ?? "";
    tagline = json['tagline'] ?? "";
    title = json['title'] ?? "";
    video = json['video'] ?? false;
    voteAverage = json['vote_average'] ?? 0.0;
    voteCount = json['vote_count'] ?? 0;
  }

  bool? adult;
  dynamic backdropPath;
  dynamic belongsToCollection;
  num? budget;
  List<dynamic>? genres;
  String? homepage;
  num? id;
  dynamic imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  num? popularity;
  String? posterPath;
  List<dynamic>? productionCompanies;
  List<dynamic>? productionCountries;
  String? releaseDate;
  num? revenue;
  num? runtime;
  List<dynamic>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  num? voteAverage;
  num? voteCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['backdrop_path'] = backdropPath;
    map['belongs_to_collection'] = belongsToCollection;
    map['budget'] = budget;
    map['genres'] = genres;
    map['homepage'] = homepage;
    map['id'] = id;
    map['imdb_id'] = imdbId;
    map['original_language'] = originalLanguage;
    map['original_title'] = originalTitle;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['poster_path'] = posterPath;
    map['production_companies'] = productionCompanies;
    map['production_countries'] = productionCountries;
    map['release_date'] = releaseDate;
    map['revenue'] = revenue;
    map['runtime'] = runtime;
    map['spoken_languages'] = spokenLanguages;
    map['status'] = status;
    map['tagline'] = tagline;
    map['title'] = title;
    map['video'] = video;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }
}
