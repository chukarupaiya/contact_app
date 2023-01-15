class user{
  final String name;
  final String email;
  final int id;
  final String address;
  final String phone;
  final String website;
  final String company;
  

  user({required this.id,required this.name,required this.email,required this.address,required this.phone,required this.website,required this.company});


  factory user.fromJson(Map<String, dynamic> json) {
    return user(
      id:json['id'],
      name:json['name'],
      email:json['email'],
      address:json['address']['street']+"\n"+json['address']['suite']+"\n"+json['address']['city']+"\n"+json['address']['zipcode'],
      phone:json['phone'],
      website:json['website'],
      company:json['company']['name'],
    );
  }

  
}