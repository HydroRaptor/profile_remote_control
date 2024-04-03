class User {
  final String utitle;
  final String ubody;
  final int id;
  
  const User({
    required this.utitle,
    required this.ubody,
    required this.id,
    
    
  });

  static User fromJson(json) => User( 
    id: json['id'],
    utitle: json['title'],
    ubody: json['body'],);
}