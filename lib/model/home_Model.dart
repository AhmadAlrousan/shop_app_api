
class HomeModel{
  bool? status;
  HomeDataModel? data;

  HomeModel(this.data,this.status);

  HomeModel.fromJson(Map<String , dynamic> json)

  :
    status =json['status'],
    data = HomeDataModel.fromJson(json['data']);
  //data = json['data']!=null ? HomeDataModel.fromJson(json['data']):null;

}

class HomeDataModel{

  List<BannerModel>banners=[];
  List<ProductModel>products=[];

  HomeDataModel(this.banners,this.products);

  HomeDataModel.fromJson(Map<String ,dynamic>json)
  {
    json['banners'].forEach((element){
      banners.add(element);
      // try       products.add(json['banners']);
    });

    json['products'].forEach((element){
      products.add(element);
      // try       products.add(json['products']);
    });
  }
}

class BannerModel{
  int? id;
  String? image;

  BannerModel.fromJson(Map<String ,dynamic>json)
  :
    id=json['id'],
    image=json['image'];


}

class ProductModel{
  int? id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String? image;
  String? name;
  bool? infavorites;
  bool? incart;

  ProductModel.fromJson(Map<String ,dynamic>json)
  :
    id=json['id'],
    price=json['price'],
    oldprice=json['old_price'],
    discount=json['discount'],
    name=json['name'],
    image=json['image'],
    infavorites=json['in_favorites'],
    incart=json['in_cart'];



}