class AuthResponse {
  int code;
  bool status;
  String message;
  List<Data> data;

  AuthResponse(
      {required this.code,
      required this.status,
      required this.message,
      required this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );
}

// Data model
class Data {
  String token;
  User user;
  UserProfile profile;

  Data({required this.token, required this.user, required this.profile});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      token: json["token"],
      user: User.fromJson(json["user"]),
      profile: UserProfile.fromJson(json["profile"]));
}

// User model
class User {
  int id;
  String firstName;
  String lastName;
  String username;
  String email;
  bool isSuperuser;
  bool isActive;
  List<dynamic> groups;
  List<dynamic> userPermissions;
  String dateJoined;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.isSuperuser,
      required this.isActive,
      required this.groups,
      required this.userPermissions,
      required this.dateJoined});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        username: json['username'],
        email: json['email'],
        isSuperuser: json['is_superuser'],
        isActive: json['is_active'],
        groups: json['groups'],
        userPermissions: json['user_permissions'],
        dateJoined: json['date_joined']);
  }
}

// UserProfile model
class UserProfile {
  int pk;
  int user;
  bool business;
  String company;
  String status;
  dynamic photo;
  dynamic idFront;
  dynamic idBack;
  dynamic selfie;
  dynamic businessNumber;
  dynamic businessTax;
  String legalStatus;
  int reference;
  double balance;
  String apiToken;
  String aimedRevenue;

  UserProfile(
      {required this.pk,
      required this.user,
      required this.business,
      required this.company,
      required this.status,
      required this.photo,
      required this.idFront,
      required this.idBack,
      required this.selfie,
      required this.businessNumber,
      required this.businessTax,
      required this.legalStatus,
      required this.reference,
      required this.balance,
      required this.apiToken,
      required this.aimedRevenue});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        pk: json['pk'],
        user: json['user'],
        business: json['business'],
        company: json['company'],
        status: json['status'],
        photo: json['photo'],
        idFront: json['id_front'],
        idBack: json['id_back'],
        selfie: json['selfie'],
        businessNumber: json['business_number'],
        businessTax: json['business_tax'],
        legalStatus: json['legal_status'],
        reference: json['reference'],
        balance: json['balance'].toDouble(),
        apiToken: json['api_token'],
        aimedRevenue: json['aimed_revenue']);
  }
}
