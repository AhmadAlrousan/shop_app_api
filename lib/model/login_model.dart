class ShopLoginModel {
   bool? status;
   String? message;
  UserData? data;

  ShopLoginModel({
     this.data,
    this.message,
    this.status,
});

   // named constructor

   ShopLoginModel.fromJson(
       Map<String, dynamic> json ,
       )
   {
     status=json['status'];
     message=json['message'];
     data=json['data']!=null ? UserData.fromJson(json['data']):null; // ?? not equal


   }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  // named constructor

  UserData.fromJson(
  Map<String, dynamic> json ,
      )
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    token=json['token'];
    phone=json['phone'];
    image=json['image'];
    credit=json['credit'];
    points=json['points'];

  }
}
