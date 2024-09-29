
class SignUpBody{
 var  name;
  var email;
  var phone;
  var password;
  var token;
  SignUpBody({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.token
});

  Map<String, dynamic> toJson(){
    final Map<String,dynamic> data= new Map<String,dynamic>();
    data['f_name']=this.name;
    data['phone']=this.phone;
    data['password']=this.password;
    data['email']=this.email;
    data['cm_firebase_token']=this.token;

    return data;
  }
}