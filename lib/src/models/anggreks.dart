import 'dart:convert';

class Anggreks {
  int id;
  String name;
  String desc;
  int price;
  String image;
  String createdAt;
  String updatedAt;
  String deletedAt;
  // final int id;
  // final String name;
  // final String desc;
  // final int price;
  // final String image;
  // final String createdAt;
  // final String updatedAt;
  // final String deletedAt;

  Anggreks(
      {this.id,
      this.name,
      this.desc,
      this.price,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  // Anggreks.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   desc = json['desc'];
  //   price = json['price'];
  //   image = json['image'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  //   deletedAt = json['deleted_at'];
  // }
  factory Anggreks.fromJson(Map<String, dynamic> json) {
    return Anggreks(
      // id : json['id'] == null ? null : json['id'],
      // name : json['name'] == null ? null : json['name'],
      // desc : json['desc'] == null ? null : json['desc'],
      // price : json['price'] == null ? null : json['price'],
      // image : json['image'] == null ? null : json['image'],
      // createdAt : json['created_at'] == null ? null : json['created_at'],
      // updatedAt : json['updated_at'] == null ? null : json['updated_at'],
      // deletedAt : json['deleted_at'] == null ? null : json['deleted_at'],

      id : json['id'],
      name : json['name'],
      desc : json['desc'],
      price : json['price'],
      image : json['image'],
      createdAt : json['created_at'],
      updatedAt : json['updated_at'],
      deletedAt : json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

// List<Anggreks> parseAnggreks(String jsonData){
//   final data = jsonDecode(jsonData).cast<Map<String, dynamic>>();
//   // return List<Anggreks>.from(data.map((item) => Anggreks.fromJson(item)));
//   return data.map<Anggreks>((json) => Anggreks.fromJson(json)).toList();
// }
