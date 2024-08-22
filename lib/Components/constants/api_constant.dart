// ignore_for_file: constant_identifier_names, duplicate_ignore

class ApiConstant {

  static const String baseUrl =
      "https://thinkcast.ir/api/";
  static const String imageBaseUrl = "https://thinkcast.ir";

  static const String getHomeItems = '${baseUrl}home/?command=index';
  static const String getArticleItems =
      '${baseUrl}article/get.php?command=new&user_id=';
  static const String getArticleInfo =
      '${baseUrl}article/get.php?command=info&id=15&user_id=';
  static const String postRegister = '$baseUrl+register/action.php';
  static const String publishedByMe =
      '$baseUrl+article/get.php?command=published_by_me&user_id=8';
  static const String storeArticle = '$baseUrl+article/post.php';
}

class ApiKeyConstant {
  static const title = 'title';
  static const content = 'content';
  // ignore: constant_identifier_names
  static const cat_id = 'cat_id';
  // ignore: constant_identifier_names
  static const tag_list = 'tag_list';
  // ignore: constant_identifier_names
  static const user_id = 'user_id';
  static const article_id = 'article_id';
  static const podcast_id = 'podcast_id';
  static const fav_id = 'fav_id';
  static const image = 'image';
  static const command = 'command';
  static const name = 'name';
  static const file_id = 'file_id';
  static const length = 'length';
  static const file = 'file';


}
