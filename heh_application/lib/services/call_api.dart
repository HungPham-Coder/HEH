import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/login.dart';
import 'package:heh_application/SignUp%20Page/signup.dart';
import 'package:heh_application/models/booking_detail.dart';
import 'package:heh_application/models/exercise_model/category.dart';
import 'package:heh_application/models/exercise_model/exercise.dart';
import 'package:heh_application/models/exercise_model/exercise_detail.dart';
import 'package:heh_application/models/exercise_resource.dart';
import 'package:heh_application/models/login_user.dart';
import 'package:heh_application/models/medical_record.dart';
import 'package:heh_application/models/physiotherapist.dart';
import 'package:heh_application/models/result_login.dart';
import 'package:heh_application/models/schedule.dart';
import 'package:heh_application/models/sign_up_user.dart';
import 'package:heh_application/models/slot.dart';
import 'package:heh_application/models/sub_profile.dart';
import 'package:heh_application/models/type_of_slot.dart';
import 'package:heh_application/models/user_exercise.dart';
import 'package:http/http.dart' as http;

import '../Member page/navigation_main.dart';
import '../models/feedback.dart';
import '../models/role.dart';

class CallAPI {
  String link = 'https://taskuatapi.hisoft.vn';
  Future<ResultLogin?> callLoginAPI(LoginUser loginUser) async {
    var url = Uri.parse('${link}/api/User/Login');
    // var url = Uri.https('localhost:7166', 'api/User/Login');
    final body = jsonEncode(
        {"phoneNumber": loginUser.phone, "password": loginUser.password});
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json",
    };
    var response = await http.post(url, body: body, headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      // return auth.signInWithEmailAndPassword(loginUser.phone, loginUser.password);
      Map<String, dynamic> responseBody = json.decode(response.body);
      Map<String, dynamic> result = responseBody["result"];
      print(result["access_token"]);
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${result["access_token"]}",
      };
      var response1 = await http
          .get(url, headers: headers)
          .then((value) => print(value.body));

      return ResultLogin.fromMap(result);
    }
  }

  Future<String> callRegisterAPI(SignUpUser signUpUser) async {
    var url = Uri.parse('${link}/api/User/Register');
    // var url = Uri.https('localhost:7166', 'api/User/Register');

    final body = jsonEncode({
      "userName": signUpUser.phone,
      "password": signUpUser.password,
      "email": signUpUser.email,
      "firstName": signUpUser.firstName,
      "lastName": signUpUser.lastName,
      "address": signUpUser.address,
      "image": signUpUser.image,
      "dob": signUpUser.dob,
      "phoneNumber": signUpUser.phone,
      "gender": signUpUser.gender,
      "bookingStatus": false,
      "banStatus": false,
    });
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.post(url, body: body, headers: headers);
    print('${response.statusCode} register account');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.body);

      return '';
    }
  }

  Future<SignUpUser?> getUserByEmail(String email) async {
    var url = Uri.parse('${link}/api/User/$email');
    // var url = Uri.https('localhost:7166', 'api/User/$email');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return SignUpUser.fromMap(json.decode(response.body), '');
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<SignUpUser?> getUserById(String id) async {
    var url = Uri.parse('${link}/api/User/getById/$id');
    // var url = Uri.https('localhost:7166', 'api/User/getById/$id');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);

    print('StatusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      return SignUpUser.fromMap(json.decode(response.body), '');
    } else {
      print("response body");
      print(response.statusCode);
      return null;
    }
  }

  Future<Role?> getUserRole(String userId) async {
    var url = Uri.parse('${link}/api/User/getUserRole/$userId');
    // var url = Uri.https('localhost:7166', 'api/User/getUserRole/$userId');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      return Role.fromMap(json.decode(response.body));
    } else {
      print("${response.statusCode} getUserRole");
    }
  }

  Future<List<Exercise>> getListExerciseByCategoryID(String categoryId) async {
    var url = Uri.parse('${link}/api/Exercise/GetByCategoryID/$categoryId');
    // var url = Uri.https('localhost:7166', 'api/Exercise/GetByCategoryID/$categoryId');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<Exercise> list = List<Exercise>.from(
          jsonResult.map((model) => Exercise.fromMap(model)));

      if (list == null) {
        throw Exception('Exercise Detail List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load exercise detail list');
    }
  }

  Future<ExerciseDetail1> getExerciseDetailByExerciseID(
      String exerciseID) async {
    var url = Uri.parse('${link}/api/ExerciseDetail/GetByExerciseID/$exerciseID');
    // var url = Uri.https('localhost:7166', 'api/ExerciseDetail/GetByExerciseID/$exerciseID');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return ExerciseDetail1.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load exercise detail ');
    }
  }

  Future<List<CategoryModel>> getAllCategory() async {
    var url = Uri.parse('${link}/api/Category');
    // var url = Uri.https('localhost:7166', 'api/Category');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<CategoryModel> list = List<CategoryModel>.from(
          jsonResult.map((model) => CategoryModel.fromMap(model)));
      if (list == null) {
        throw Exception('Category List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load categoryList');
    }
  }

  Future<List<BookingDetail>> getAllBookingDetail() async {
    var url = Uri.parse('${link}/api/BookingDetail');
    // var url = Uri.https('localhost:7166', 'api/BookingDetail');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<BookingDetail> list = List<BookingDetail>.from(
          jsonResult.map((model) => BookingDetail.fromMap(model)));
      if (list == null) {
        throw Exception('BookingDetail List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load BookingDetail');
    }
  }

  Future<List<ExerciseResource>> getAllExerciseResource() async {
    var url = Uri.parse('${link}/api/ExerciseResource');
    // var url = Uri.https('localhost:7166', 'api/ExerciseResource');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<ExerciseResource> list = List<ExerciseResource>.from(
          jsonResult.map((model) => ExerciseResource.fromMap(model)));
      if (list == null) {
        throw Exception('ExerciseResource List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load ExerciseResource');
    }
  }

  Future<ExerciseResource> getExerciseResourceByExerciseDetailID(
      String exerciseID) async {
    var url = Uri.parse('${link}/api/ExerciseResource/GetByExerciseDetailId/$exerciseID');
    // var url = Uri.https('localhost:7166', 'api/ExerciseDetail/GetByExerciseID/$exerciseID');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return ExerciseResource.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load exercise resource ');
    }
  }

  Future<List<FeedbackModel>> getAllFeedback() async {
    var url = Uri.parse('${link}/api/Feedback');
    // var url = Uri.https('localhost:7166', 'api/Feedback');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<FeedbackModel> list = List<FeedbackModel>.from(
          jsonResult.map((model) => FeedbackModel.fromMap(model)));
      if (list == null) {
        throw Exception('FeedbackModel List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load FeedbackModel');
    }
  }

  Future<List<MedicalRecord>> getAllMedicalRecord() async {
    var url = Uri.parse('${link}/api/MedicalRecord');
    // var url = Uri.https('localhost:7166', 'api/MedicalRecord');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<MedicalRecord> list = List<MedicalRecord>.from(
          jsonResult.map((model) => MedicalRecord.fromMap(model)));
      if (list == null) {
        throw Exception('MedicalRecord List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load MedicalRecord');
    }
  }
  Future<void> createMedicalRecord(MedicalRecord medicalRecord) async {
    var url = Uri.parse('${link}/api/MedicalRecord/Create');
    // var url = Uri.https('localhost:7166', 'api/User/Register');

    final body = jsonEncode({
      "userID": medicalRecord.userID,
      "categoryID": medicalRecord.categoryID,
      "subProfileID": medicalRecord.subProfileID,
      "problem": medicalRecord.problem,
      "difficult": medicalRecord.difficulty,
      "injury": medicalRecord.injury,
      "curing": medicalRecord.curing,
      "medicine": medicalRecord.medicine,
      "isDeleted": false,
    });
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.post(url, body: body, headers: headers);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      print('medical');
      print(response.statusCode);
    } else {
      print(response.body);
      print('medical');
      print(response.statusCode);
    }
  }

  Future<List<Physiotherapist>> getAllPhysiotherapist() async {
    var url = Uri.parse('${link}/api/Physiotherapist');
    // var url = Uri.https('localhost:7166', 'api/Physiotherapist');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<Physiotherapist> list = List<Physiotherapist>.from(
          jsonResult.map((model) => Physiotherapist.fromMap(model)));
      if (list == null) {
        throw Exception('Physiotherapist List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load Physiotherapist');
    }
  }
  Future<List<Physiotherapist>> getAllActivePhysiotherapist() async {
    var url = Uri.parse('${link}/api/Physiotherapist/GetAllActivePhysiotherapist');
    // var url = Uri.https('localhost:7166', 'api/Physiotherapist');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<Physiotherapist> list = List<Physiotherapist>.from(
          jsonResult.map((model) => Physiotherapist.fromMap(model)));
      if (list == null) {
        throw Exception('Active Physiotherapist List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load Active Physiotherapist');
    }
  }

  Future<List<Schedule>> getAllSchedule() async {
    var url = Uri.parse('${link}/api/Schedule');
    // var url = Uri.https('localhost:7166', 'api/Schedule');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<Schedule> list = List<Schedule>.from(
          jsonResult.map((model) => Schedule.fromMap(model)));
      if (list == null) {
        throw Exception('Schedule List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load Schedule');
    }
  }
  Future<List<Slot>> getallSlotByPhysiotherapistID(String physiotherapistID) async {
    var url = Uri.parse('${link}/api/Schedule/getAllSlotByPhysiotherapistID/$physiotherapistID');
    // var url = Uri.https('localhost:7166', 'api/Exercise/GetByCategoryID/$categoryId');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<Slot> list = List<Slot>.from(
          jsonResult.map((model) => Slot.fromMap(model)));

      if (list == null) {
        throw Exception('Slot List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load Slot List');
    }
  }
  Future<List<Physiotherapist>> getallPhysiotherapistBySlotID(String slotID) async {
    var url = Uri.parse('${link}/api/Schedule/getAllPhysiotherapistBySlotID/$slotID');
    // var url = Uri.https('localhost:7166', 'api/Exercise/GetByCategoryID/$categoryId');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<Physiotherapist> list = List<Physiotherapist>.from(
          jsonResult.map((model) => Physiotherapist.fromMap(model)));

      if (list == null) {
        throw Exception('Physiotherapist List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load Physiotherapist List');
    }
  }

  Future<List<Slot>> getAllSlot() async {
    var url = Uri.parse('${link}/api/Slot');
    // var url = Uri.https('localhost:7166', 'api/Slot');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<Slot> list =
          List<Slot>.from(jsonResult.map((model) => Slot.fromMap(model)));
      if (list == null) {
        throw Exception('Slot List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load Slot');
    }
  }

  Future<List<SubProfile>> getAllSubProfile() async {
    var url = Uri.parse('${link}/api/SubProfile');
    // var url = Uri.https('localhost:7166', 'api/SubProfile');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<SubProfile> list = List<SubProfile>.from(
          jsonResult.map((model) => SubProfile.fromMap(model)));
      if (list == null) {
        throw Exception('SubProfile List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load SubProfile');
    }
  }

  Future<List<TypeOfSlot>> getAllTypeOfSlot() async {
    var url = Uri.parse('${link}/api/TypeOfSlot');
    // var url = Uri.https('localhost:7166', 'api/TypeOfSlot');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<TypeOfSlot> list = List<TypeOfSlot>.from(
          jsonResult.map((model) => TypeOfSlot.fromMap(model)));
      if (list == null) {
        throw Exception('TypeOfSlot List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load TypeOfSlot');
    }
  }

  Future<List<UserExercise>> getAllUserExercise() async {
    var url = Uri.parse('${link}/api/UserExercise');
    // var url = Uri.https('localhost:7166', 'api/UserExercise');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<UserExercise> list = List<UserExercise>.from(
          jsonResult.map((model) => UserExercise.fromMap(model)));
      if (list == null) {
        throw Exception('UserExercise List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load UserExercise');
    }
  }
}
