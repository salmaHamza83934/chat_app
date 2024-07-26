class CategoryModel {
  static const String sportsId = 'sports';
  static const String moviesId = 'movies';
  static const String musicId = 'music';
  String id;
  late String title;
  late String image;

  CategoryModel(this.id, this.title, this.image);

  CategoryModel.fromId(this.id) {
    if (id == sportsId) {
      title = 'Sports';
      image = 'assets/images/sports.png';
    } else if (id == moviesId) {
      title = 'Movies';
      image = 'assets/images/movies.png';
    } else if (id == musicId) {
      title = 'Music';
      image = 'assets/images/music.png';
    }
  }

  static List<CategoryModel> getCategory() {
    return [
      CategoryModel.fromId(sportsId),
      CategoryModel.fromId(musicId),
      CategoryModel.fromId(moviesId)
    ];
  }
}
