class KycStatus {
  const KycStatus({
    required this.id,
    required this.quoteId,
    required this.phoneNumber,
    required this.otp,
    required this.isOtpVerified,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.documents,
    required this.quote,
    required this.createdAt,
    required this.updatedAt,
  });

  KycStatus.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      quoteId = json['quoteId'] as String,
      phoneNumber = json['number'] as String,
      otp = json['otp'] as String,
      isOtpVerified = json['otpVerified'] as bool,
      firstName = json['firstName'] as String?,
      lastName = json['lastName'] as String?,
      address = KycAddress(
        addressLine1: json['addressLine1'] as String?,
        addressLine2: json['addressLine2'] as String?,
        addressLine3: json['addressLine3'] as String?,
        city: json['city'] as String?,
        state: json['state'] as String?,
        pincode: json['pincode'] as String?,
      ),
      documents = KycDocuments(
        aadhaarFrontUrl: json['aadhaarFrontUrl'] as String?,
        aadhaarBackUrl: json['aadhaarBackUrl'] as String?,
        addressProofUrl: json['addressProofUrl'] as String?,
      ),
      quote = KycQuote.fromJson(json['quote'] as Map<String, dynamic>),
      createdAt = DateTime.parse(json['createdAt'] as String),
      updatedAt = DateTime.parse(json['updatedAt'] as String);

  final String id;
  final String quoteId;
  final String phoneNumber;
  final String otp;
  final bool isOtpVerified;
  final String? firstName;
  final String? lastName;
  final KycAddress address;
  final KycDocuments documents;
  final KycQuote quote;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'quoteId': quoteId,
    'number': phoneNumber,
    'otp': otp,
    'otpVerified': isOtpVerified,
    'firstName': firstName,
    'lastName': lastName,
    'addressLine1': address.addressLine1,
    'addressLine2': address.addressLine2,
    'addressLine3': address.addressLine3,
    'city': address.city,
    'state': address.state,
    'pincode': address.pincode,
    'aadhaarFrontUrl': documents.aadhaarFrontUrl,
    'aadhaarBackUrl': documents.aadhaarBackUrl,
    'addressProofUrl': documents.addressProofUrl,
    'quote': quote.toJson(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}

class KycAddress {
  final String? addressLine1;
  final String? addressLine2;
  final String? addressLine3;
  final String? city;
  final String? state;
  final String? pincode;

  const KycAddress({
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.city,
    this.state,
    this.pincode,
  });

  KycAddress copyWith({
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? city,
    String? state,
    String? pincode,
  }) => KycAddress(
    addressLine1: addressLine1 ?? this.addressLine1,
    addressLine2: addressLine2 ?? this.addressLine2,
    addressLine3: addressLine3 ?? this.addressLine3,
    city: city ?? this.city,
    state: state ?? this.state,
    pincode: pincode ?? this.pincode,
  );

  Map<String, dynamic> toJson() => {
    'addressLine1': addressLine1,
    'addressLine2': addressLine2,
    'addressLine3': addressLine3,
    'city': city,
    'state': state,
    'pincode': pincode,
  };
}

class KycDocuments {
  final String? aadhaarFrontUrl;
  final String? aadhaarBackUrl;
  final String? addressProofUrl;

  const KycDocuments({
    this.aadhaarFrontUrl,
    this.aadhaarBackUrl,
    this.addressProofUrl,
  });
}

class KycDocumentsSubmission {
  final String aadhaarFrontPath;
  final String aadhaarBackPath;
  final String addressProofPath;

  const KycDocumentsSubmission({
    required this.aadhaarFrontPath,
    required this.aadhaarBackPath,
    required this.addressProofPath,
  });

  KycDocumentsSubmission copyWith({
    String? aadhaarFrontPath,
    String? aadhaarBackPath,
    String? addressProofPath,
  }) => KycDocumentsSubmission(
    aadhaarFrontPath: aadhaarFrontPath ?? this.aadhaarFrontPath,
    aadhaarBackPath: aadhaarBackPath ?? this.aadhaarBackPath,
    addressProofPath: addressProofPath ?? this.addressProofPath,
  );

  Map<String, dynamic> toJson() => {
    'aadhaarFront': aadhaarFrontPath,
    'aadhaarBack': aadhaarBackPath,
    'addressProof': addressProofPath,
  };
}

class KycQuote {
  final String id;
  final String imei;
  final String status;
  final String username;
  final String email;

  const KycQuote({
    required this.id,
    required this.imei,
    required this.status,
    required this.username,
    required this.email,
  });

  KycQuote.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      imei = json['imei'] as String,
      status = json['status'] as String,
      username = json['userName'] as String,
      email = json['userEmail'] as String;

  Map<String, dynamic> toJson() => {
    'id': id,
    'imei': imei,
    'status': status,
    'userName': username,
    'userEmail': email,
  };
}

class KycDetails {
  const KycDetails({
    required this.firstName,
    required this.lastName,
    required this.address,
  });

  KycDetails.fromJson(Map<String, dynamic> json)
    : firstName = json['firstName'] as String,
      lastName = json['lastName'] as String,
      address = KycAddress(
        addressLine1: json['addressLine1'] as String?,
        addressLine2: json['addressLine2'] as String?,
        addressLine3: json['addressLine3'] as String?,
        city: json['city'] as String?,
        state: json['state'] as String?,
        pincode: json['pincode'] as String?,
      );

  final String firstName;
  final String lastName;
  final KycAddress address;

  KycDetails copyWith({
    String? firstName,
    String? lastName,
    KycAddress? address,
  }) => KycDetails(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    address: address ?? this.address,
  );

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'addressLine1': address.addressLine1,
    'addressLine2': address.addressLine2,
    'addressLine3': address.addressLine3,
    'city': address.city,
    'state': address.state,
    'pincode': address.pincode,
  };
}
