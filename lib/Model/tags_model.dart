class TagsModel {
  String? title;
  String?id;
  TagsModel({required this.title,required this.id});
  TagsModel.fromJson(Map<String,dynamic> element){
    title = element['title'];
    id = element['id'];

  }
   
  }
