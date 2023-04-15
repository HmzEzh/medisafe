class UserModel{
  String? userName;
  int? userAge;
List<String>? emails;
UserModel({this.userName,this.userAge,this.emails});

Map<String,dynamic> toJson(){
final Map<String,dynamic> data = new Map<String,dynamic>();

data['UserName']= userName;
data['UserAge']= userAge;
data['emails']= emails;
return data;
}


}