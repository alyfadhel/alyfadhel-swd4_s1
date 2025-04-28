class CategoriesHomeModel
{
  final bool status;
  final CategoriesHomeDataModel data;

  CategoriesHomeModel({
    required this.status,
    required this.data,
  });
  factory CategoriesHomeModel.fromJson(Map<String,dynamic>json){
    return CategoriesHomeModel(
        status: json['status'],
        data: CategoriesHomeDataModel.fromJson(json['data']),
    );
  }
}

class CategoriesHomeDataModel
{
  final int currentPage;
  final List<CategoriesHomeDataDetailsModel>data;

  CategoriesHomeDataModel({
    required this.currentPage,
    required this.data,
  });
  factory CategoriesHomeDataModel.fromJson(Map<String,dynamic>json){
    List<CategoriesHomeDataDetailsModel>data = [];
    if(json['data'] != null){
      json['data'].forEach((element){
        data.add(CategoriesHomeDataDetailsModel.fromJson(element));
      });
    }
    return CategoriesHomeDataModel(
      currentPage: json['current_page'],
      data: data,
    );
  }

}

class CategoriesHomeDataDetailsModel
{
  final int id;
  final String name;
  final String image;

  CategoriesHomeDataDetailsModel({
    required this.id,
    required this.name,
    required this.image,
  });
  factory CategoriesHomeDataDetailsModel.fromJson(Map<String,dynamic>json){
    return CategoriesHomeDataDetailsModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
    );
  }
}