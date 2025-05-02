class FavoriteModel {
  final bool status;
  final FavoriteDataModel? data;

  FavoriteModel({
    required this.status,
    required this.data,
  });
  factory FavoriteModel.fromJson(Map<String,dynamic>json)
  {
    return FavoriteModel(
      status: json['status'],
      data: json['data'] != null ? FavoriteDataModel.fromJson(json['data']) : null,
    );
  }
}

class FavoriteDataModel {
  final int currentPage;
  final List<FavoriteDataDetailsModel> data;

  FavoriteDataModel({
    required this.currentPage,
    required this.data,
  });
  factory FavoriteDataModel.fromJson(Map<String,dynamic>json){
    List<FavoriteDataDetailsModel> data = [];
    if(json['data'] != null){
      json['data'].forEach((element){
        data.add(FavoriteDataDetailsModel.fromJson(element));
      });
    }
    return FavoriteDataModel(
      currentPage: json['current_page'],
      data: data,
    );
  }
}

class FavoriteDataDetailsModel {
  final int id;
  final ProductFavoritesModel product;

  FavoriteDataDetailsModel({
    required this.id,
    required this.product,
  });

  factory FavoriteDataDetailsModel.fromJson(Map<String, dynamic> json) {
    return FavoriteDataDetailsModel(
        id: json['id'],
        product: ProductFavoritesModel.fromJson(json['product']),
    );
  }
}

class ProductFavoritesModel {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String image;
  final String name;
  final String description;

  ProductFavoritesModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  factory ProductFavoritesModel.fromJson(Map<String, dynamic> json) {
    return ProductFavoritesModel(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
