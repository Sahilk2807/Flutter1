import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'firebase_uid')
  final String firebaseUid;
  
  final String? email;
  final String? name;
  final String? mobile;
  final String? address;
  
  @JsonKey(name: 'class')
  final String? userClass;
  
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const UserModel({
    required this.firebaseUid,
    this.email,
    this.name,
    this.mobile,
    this.address,
    this.userClass,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? firebaseUid,
    String? email,
    String? name,
    String? mobile,
    String? address,
    String? userClass,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      firebaseUid: firebaseUid ?? this.firebaseUid,
      email: email ?? this.email,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      userClass: userClass ?? this.userClass,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isProfileComplete {
    return name != null && 
           name!.isNotEmpty &&
           mobile != null && 
           mobile!.isNotEmpty &&
           address != null && 
           address!.isNotEmpty &&
           userClass != null && 
           userClass!.isNotEmpty;
  }

  @override
  String toString() {
    return 'UserModel(firebaseUid: $firebaseUid, email: $email, name: $name, mobile: $mobile, address: $address, userClass: $userClass)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.firebaseUid == firebaseUid &&
        other.email == email &&
        other.name == name &&
        other.mobile == mobile &&
        other.address == address &&
        other.userClass == userClass;
  }

  @override
  int get hashCode {
    return firebaseUid.hashCode ^
        email.hashCode ^
        name.hashCode ^
        mobile.hashCode ^
        address.hashCode ^
        userClass.hashCode;
  }
}

