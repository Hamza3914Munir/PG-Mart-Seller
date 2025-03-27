class Seller {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;
  String? password;
  String? status;
  String? rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bankName;
  String? branch;
  String? accountNo;
  String? holderName;
  String? authToken;
  double? salesCommissionPercentage;
  String? gst;
  String? cmFirebaseToken;
  int? posStatus;
  double? minimumOrderAmount;
  double? freeDeliveryStatus;
  double? freeDeliveryOverAmount;
  String? appLanguage;
  Shop? shop;

  Seller({
    this.id,
    this.fName,
    this.lName,
    this.phone,
    this.image,
    this.email,
    this.password,
    this.status,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.bankName,
    this.branch,
    this.accountNo,
    this.holderName,
    this.authToken,
    this.salesCommissionPercentage,
    this.gst,
    this.cmFirebaseToken,
    this.posStatus,
    this.minimumOrderAmount,
    this.freeDeliveryStatus,
    this.freeDeliveryOverAmount,
    this.appLanguage,
    this.shop,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
  return Seller(
    id: json['id'],
    fName: json['f_name'],
    lName: json['l_name'],
    phone: json['phone'],
    image: json['image'],
    email: json['email'],
    password: json['password'],
    status: json['status'],
    rememberToken: json['remember_token'],
    createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    bankName: json['bank_name'],
    branch: json['branch'],
    accountNo: json['account_no'],
    holderName: json['holder_name'],
    authToken: json['auth_token'],
    salesCommissionPercentage: json['sales_commission_percentage']?.toDouble(),
    gst: json['gst'],
    cmFirebaseToken: json['cm_firebase_token'],
    posStatus: json['pos_status'],
    minimumOrderAmount: json['minimum_order_amount']?.toDouble(),
    freeDeliveryStatus: json['free_delivery_status']?.toDouble(),
    freeDeliveryOverAmount: json['free_delivery_over_amount']?.toDouble(),
    appLanguage: json['app_language'],
    shop: json['shop'] != null ? Shop.fromJson(json['shop']) : null,
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_name': fName,
      'l_name': lName,
      'phone': phone,
      'image': image,
      'email': email,
      'password': password,
      'status': status,
      'remember_token': rememberToken,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'bank_name': bankName,
      'branch': branch,
      'account_no': accountNo,
      'holder_name': holderName,
      'auth_token': authToken,
      'sales_commission_percentage': salesCommissionPercentage,
      'gst': gst,
      'cm_firebase_token': cmFirebaseToken,
      'pos_status': posStatus,
      'minimum_order_amount': minimumOrderAmount,
      'free_delivery_status': freeDeliveryStatus,
      'free_delivery_over_amount': freeDeliveryOverAmount,
      'app_language': appLanguage,
      'shop': shop?.toJson(),
    };
  }
}

class Shop {
  int? id;
  int? sellerId;
  String? name;
  String? slug;
  String? address;
  String? contact;
  String? image;
  String? bottomBanner;
  String? offerBanner;
  DateTime? vacationStartDate;
  DateTime? vacationEndDate;
  String? vacationNote;
  bool? vacationStatus;
  bool? temporaryClose;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? banner;

  Shop({
    this.id,
    this.sellerId,
    this.name,
    this.slug,
    this.address,
    this.contact,
    this.image,
    this.bottomBanner,
    this.offerBanner,
    this.vacationStartDate,
    this.vacationEndDate,
    this.vacationNote,
    this.vacationStatus,
    this.temporaryClose,
    this.createdAt,
    this.updatedAt,
    this.banner,
  });

   factory Shop.fromJson(Map<String, dynamic> json) {
  return Shop(
    id: json['id'],
    sellerId: json['seller_id'],
    name: json['name'],
    slug: json['slug'],
    address: json['address'],
    contact: json['contact'],
    image: json['image'],
    bottomBanner: json['bottom_banner'],
    offerBanner: json['offer_banner'],
    vacationStartDate: json['vacation_start_date'] != null ? DateTime.parse(json['vacation_start_date']) : null,
    vacationEndDate: json['vacation_end_date'] != null ? DateTime.parse(json['vacation_end_date']) : null,
    vacationNote: json['vacation_note'],
    vacationStatus: json['vacation_status'],
    temporaryClose: json['temporary_close'],
    createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    banner: json['banner'],
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'seller_id': sellerId,
      'name': name,
      'slug': slug,
      'address': address,
      'contact': contact,
      'image': image,
      'bottom_banner': bottomBanner,
      'offer_banner': offerBanner,
      'vacation_start_date': vacationStartDate?.toIso8601String(),
      'vacation_end_date': vacationEndDate?.toIso8601String(),
      'vacation_note': vacationNote,
      'vacation_status': vacationStatus,
      'temporary_close': temporaryClose,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'banner': banner,
    };
  }
}
