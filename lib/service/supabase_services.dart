import 'dart:async';
import 'dart:io';

import 'package:green_saudi_app/model/gsi_user.dart';
import 'package:green_saudi_app/model/event_model.dart';
import 'package:green_saudi_app/model/personal_event.dart';
import 'package:green_saudi_app/model/reward_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBServices {
  final supabase = Supabase.instance.client;
  String userRole = "";
  String email = "";
  String userID = "";
  String otpToken = "";
  String userImageUrl = "";
  File userImageFile = File("");
  GSIUser user = GSIUser();
  List<EventModel> listOfPersonalEvents = [];
  //----------------------------- Auth --------------------------------
  Future signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final signedInUser =
        await supabase.auth.signUp(email: email, password: password);

    await supabase.from("user_green_sa_app").insert(
        {'id_user': signedInUser.user!.id, 'name': name, 'phone': phone});
  }

  Future login({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future signOut() async {
    await supabase.auth.signOut();
  }

  Future<Session?> getCurrentSession() async {
    final currentSession = supabase.auth.currentSession;

    return currentSession;
  }

  Future<GSIUser> getUser({required String id}) async {
    final userInfo = await supabase
        .from('user_green_sa_app')
        .select('*')
        .match({'id_user': id}).single();
    email = supabase.auth.currentUser!.email!;
    return GSIUser.fromJson(userInfo);
  }

  Future updateUser(
      {required String name,
      required String phone,
      required String city}) async {
    try {
      await supabase
          .from('user_green_sa_app')
          .update({'name': name, 'phone': phone, 'city': city})
          .eq('id_user', userID)
          .single();
    } catch (e) {
      print(e);
    }
  }

  Future<String> getCurrentUserId() async {
    final userId = supabase.auth.currentUser!.id;

    return userId;
  }

  Future sendOtp({required String email}) async {
    await supabase.auth.signInWithOtp(email: email);
  }

  Future verifyOtp({required String email, required String otpToken}) async {
    await supabase.auth
        .verifyOTP(token: otpToken, type: OtpType.email, email: email);
  }

  Future resendOtp() async {
    email = supabase.auth.currentSession!.user.email!;
    await supabase.auth
        .resend(type: OtpType.magiclink, email: "flutterg73@gmail.com");
  }

  Future resetPassword({required String newPassword}) async {
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  //-----------------------------User----------------------------------
  //signin event
  Future participateEvent({required PersonalEvent event}) async {
    await supabase.from('personal_event').insert({
      "user_id": userID,
      "name": event.event,
      "event": event.event,
      "stats": event.stats,
      "days": event.days
    });
  }

  //display List Event history
  Future<List<EventModel>> getUserEvent({required String id}) async {
    final eventListData =
        await supabase.from('personal_event').select('*').match({'user_id': id});
    for (var element in eventListData) {
      listOfPersonalEvents.add(EventModel.fromJson(element));
    }
    return listOfPersonalEvents;
  }

  //points
  //balance
  //redeem
  //display List redeem history

  //----------------------------- Admin --------------------------------
  Future createEvent({required EventModel event}) async {
    await supabase.from('org_event').insert({
      "name": event.title,
      "content": event.description,
      "location": event.location,
      "date_start": event.startDate,
      "time_start": event.startTime,
      "end_date": event.endDate,
      "time_end": event.endTime,
      "maximam_number_of": event.maximumCapacity,
    });
  }
  Future createReward({required RewardModel reward}) async {
    var newReward = await supabase
        .from('reward_table').insert({
  "reward_name": reward.rewardName,
  "reward_company_logo": reward.rewardCompanyLogo,
  "reward_content": reward.rewardContent,
  "reward_company_name": reward.rewardCompanyName,
  "reward_image": reward.rewardImage,
});
print("done");
  }
    Future<List<EventModel>> getAllEvent() async {
    final eventsListData = await supabase
        .from('org_event')
        .select('*');
    List<EventModel> listOfEvents = [];
    for (var element in eventsListData) {
      listOfEvents.add(EventModel.fromJson(element));
    }
    return listOfEvents;}
    
        Future<List<RewardModel>> getAllReward() async {
    final rewardListData = await supabase
        .from('reward_table')
        .select('*');
    List<RewardModel> listOfReward = [];
    for (var element in rewardListData) {
      listOfReward.add(RewardModel.fromJson(element));
    }
    return listOfReward;}



  /////////////////file crud
Future<void> uploadImage(File imageFile) async {
    print(userID);

   await supabase.storage
      .from('avatar') // Replace with your storage bucket name
      .upload("${userID}", imageFile);
      UrlImage();
print("done");
}

Future<void> updateImage(File imageFile) async {
    print(userID);

  await supabase.storage
      .from('avatar') // Replace with your storage bucket name
      .update("${userID}", imageFile);
      UrlImage();
print("done add");
}
Future<void> deleteImage() async {
  print(userID);
  await supabase.storage
      .from('avatar') // Replace with your storage bucket name
      .remove(["${userID}"]);
print("done remove");
}
Future<String> UrlImage() async {
  final response = await supabase.storage
      .from('avatar') // Replace with your storage bucket name
      .getPublicUrl("${userID}");
      return response;
}}

