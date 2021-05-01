import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String userName;
  final String displayName;
  final String photoUrl;
  final String displayPic;
  final String email;
  final String bio;
  final String familyId;
  final String isAdmin;
  final String memberActive;
  final String index;

  User({
    this.id,
    this.userName,
    this.displayName,
    this.photoUrl,
    this.displayPic,
    this.email,
    this.bio,
    this.familyId,
    this.isAdmin,
    this.memberActive,
    this.index,
  });

  factory User.fromDocument(DocumentSnapshot doc){
    return User(
      id: doc['id'],
      userName: doc['userName'],
      displayName: doc['displayName'],
      photoUrl: doc['photoUrl'],
      email: doc['email'],
      bio: doc['bio'],
      familyId: doc['familyId'],
      isAdmin: doc['isAdmin'],
      memberActive: doc['memberActive'],
      index: doc['index'],
    );
  }
}
