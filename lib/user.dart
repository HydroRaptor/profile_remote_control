class User {
  final String utitle;
  final String ubody;
  final int id;

  const User({
    required this.utitle,
    required this.ubody,
    required this.id,
 
  });
  factory User.fromJson(dynamic json) {
    return User(
        id: json['id'] as int,
        utitle: json['title'] as String,
        ubody: json['body'] as String,
      );
  }

static List<User> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return User.fromJson(data);
    }).toList();
  }

  @override
  String toString(){
    return 'Recipe {id: $id, title: $utitle, body: $ubody,}';
  }

}

//------------------------------------------------------------------------------

// class User {
//   final String utitle;
//   final String ubody;
//   final int id;
//   // final int id_DB;
//   // final String DummyData;

//   const User({
//     required this.utitle,
//     required this.ubody,
//     required this.id,
//     // required this.id_DB,
//     // required this.DummyData,
//   });

//   // static User fromJson(Map<String, dynamic> json) => User(
//   static User fromJson(dynamic json) => User(
//         id: json['id'],
//         utitle: json['title'],
//         ubody: json['body'],
//         // id_DB: json['id'],
//         // DummyData: json['DummyData'],
//       );

//   // Map<String, dynamic> toJson() => {
//   //       'id': id,
//   //       'title': utitle,
//   //       'body': ubody,
//   //       'id': id_DB,
//   //       'DummyData': DummyData,
//   //     };
// }
