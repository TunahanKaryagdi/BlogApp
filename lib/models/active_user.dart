import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'active_user.g.dart';

@HiveType(typeId: 1)
class ActiveUser extends ChangeNotifier {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String surname;

  @HiveField(3)
  String email;

  @HiveField(4)
  int follow;

  @HiveField(5)
  int follower;

  @HiveField(6)
  String photo;

  ActiveUser(this.id, this.name, this.surname, this.email, this.follow,
      this.follower, this.photo);

  ActiveUser copyWith(
          {String? id,
          String? name,
          String? surname,
          String? email,
          int? follow,
          int? follower,
          String? photo}) =>
      ActiveUser(
        id ?? this.id,
        name ?? this.name,
        surname ?? this.surname,
        email ?? this.email,
        follow ?? this.follow,
        follower ?? this.follower,
        photo ?? this.photo,
      );
}
