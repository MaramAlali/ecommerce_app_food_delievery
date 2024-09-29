class AddressModel {
  int? id;
   String? addressType;
   String? contactPersonName;
  String? contactPersonNumber;
  String? address;
   String? latitude;
   String? longitude;

  AddressModel({
    this.id,
    this. addressType,
    this.contactPersonName,
    this.contactPersonNumber,
    this.address,
    this.latitude,
    this.longitude

  });
  // {
  //   _id:id;
  //   _addressType:addressType;
  //   _contactPersonName:contactPersonName;
  //   _contactPersonNumber:contactPersonNumber;
  //   _address:address;
  //   _latitude:latitude;
  //   _longitude:longitude;
  // }
  // int? get id=>_id;
  // String? get address=>_address;
  // String? get addressType=>_addressType;
  // String? get contactPersonName=>_contactPersonName;
  // String? get contactPersonNumber=>_contactPersonNumber;
  // String? get latitude=>_latitude;
  // String? get longitude=>_longitude;

  AddressModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    address=json['address'];
    addressType=json['address_type']??"";
    contactPersonName=json['contact_person_name']??"";
    contactPersonNumber=json['contact_person_number']??"";
    latitude=json['latitude'];
    longitude=json['longitude'];

  }

  Map<String ,dynamic> toJson(){
    final Map<String,dynamic> data=<String,dynamic>{};
    data['id']=id;
    data['address']=address;
    data['address_type']=addressType;
    data['contact_person_name']=contactPersonName;
    data['contact_person_number']=contactPersonNumber;
    data['latitude']=latitude;
    data['longitude']=longitude;
    return data;
  }


}