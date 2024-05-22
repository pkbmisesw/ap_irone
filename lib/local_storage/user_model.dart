class UserData {
  final int id;
  final String name;
  final String email;
  final String waNumber;
  final String country;
  final String province;
  final String city;
  final String branchOfficer;
  final String residenceAddress;
  final String jobTitle;
  final String companyName;
  final String businessField;
  final String dateBirth;
  final String religion;
  final String bloodType;
  final String emergencyContactName;
  final String emergencyContactNumber;
  final String relationshipWithContact;
  final String picSelfie;
  final String picKtp;
  final String picSim;
  final String? otp;
  final String? emailVerifiedAt;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.waNumber,
    required this.country,
    required this.province,
    required this.city,
    required this.branchOfficer,
    required this.residenceAddress,
    required this.jobTitle,
    required this.companyName,
    required this.businessField,
    required this.dateBirth,
    required this.religion,
    required this.bloodType,
    required this.emergencyContactName,
    required this.emergencyContactNumber,
    required this.relationshipWithContact,
    required this.picSelfie,
    required this.picKtp,
    required this.picSim,
    this.otp,
    this.emailVerifiedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      waNumber: json['wa_number'] ?? '',
      country: json['country'] ?? '',
      province: json['province'] ?? '',
      city: json['city'] ?? '',
      branchOfficer: json['branch_officer'] ?? '',
      residenceAddress: json['residence_address'] ?? '',
      jobTitle: json['job_title'] ?? '',
      companyName: json['company_name'] ?? '',
      businessField: json['business_field'] ?? '',
      dateBirth: json['date_birth'] ?? '',
      religion: json['religion'] ?? '',
      bloodType: json['blood_type'] ?? '',
      emergencyContactName: json['emergency_contact_name'] ?? '',
      emergencyContactNumber: json['emergency_contact_number'] ?? '',
      relationshipWithContact: json['relationship_with_contact'] ?? '',
      picSelfie: json['pic_selfie'] ?? '',
      picKtp: json['pic_ktp'] ?? '',
      picSim: json['pic_sim'] ?? '',
      otp: json['otp'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'wa_number': waNumber,
      'country': country,
      'province': province,
      'city': city,
      'branch_officer': branchOfficer,
      'residence_address': residenceAddress,
      'job_title': jobTitle,
      'company_name': companyName,
      'business_field': businessField,
      'date_birth': dateBirth,
      'religion': religion,
      'blood_type': bloodType,
      'emergency_contact_name': emergencyContactName,
      'emergency_contact_number': emergencyContactNumber,
      'relationship_with_contact': relationshipWithContact,
      'pic_selfie': picSelfie,
      'pic_ktp': picKtp,
      'pic_sim': picSim,
      'otp': otp,
      'email_verified_at': emailVerifiedAt,
    };
  }
}
