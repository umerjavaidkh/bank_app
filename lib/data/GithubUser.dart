
import 'dart:io';


class  Customer{

   String  id;
   String first_name;
   String last_name;
   String gender;
   String dob;
   String email;
   String phone;
   String address;
   String status;
   String avatar;

   Customer(this.id,this.first_name,this.last_name,this.gender,this.dob,this.email,this.phone,this.address,this.status,this.avatar);

   factory Customer.fromJson(Map<String, dynamic> json) {

      var avatar = json['_links']['avatar']['href'];

      print(avatar);


      return Customer(
         json['id'],
         json['first_name'],
         json['last_name'],
         json['gender'],
         json['dob'],
         json['email'],
         json['phone'],
         json['address'],
         json['status'],
          avatar.toString());

   }

   /*"id":"7671",
   "first_name":"John",
   "last_name":"Miller",
   "gender":"male",
   "dob":"1946-07-08",
   "email":"bradly23@example.org",
   "phone":"(796) 716-2660 x233",
   "website":"https://www.zboncak.com/aspernatur-et-accusamus-quis-neque-iste-magni-nihil-possimus",
   "address":"16562 Lafayette Forks\nWest Kyle, MS 14285-1380",
   "status":"active",
   "_links":{
       "self":{"href":"https://gorest.co.in/public-api/users/7671"},
       "edit":{"href":"https://gorest.co.in/public-api/users/7671"},
      "avatar":{"href":"https://lorempixel.com/250/250/people/?38983"}
   }
   }*/
}

