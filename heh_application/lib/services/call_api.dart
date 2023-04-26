import 'dart:convert';
import 'package:heh_application/models/booking_detail.dart';
import 'package:heh_application/models/booking_schedule.dart';
import 'package:heh_application/models/exercise_model/category.dart';
import 'package:heh_application/models/exercise_model/exercise.dart';
import 'package:heh_application/models/exercise_model/exercise_detail.dart';
import 'package:heh_application/models/exercise_resource.dart';
import 'package:heh_application/models/login_user.dart';
import 'package:heh_application/models/medical_record.dart';
import 'package:heh_application/models/physiotherapist.dart';
import 'package:heh_application/models/relationship.dart';
import 'package:heh_application/models/result_login.dart';
import 'package:heh_application/models/schedule.dart';
import 'package:heh_application/models/sign_up_user.dart';
import 'package:heh_application/models/slot.dart';
import 'package:heh_application/models/sub_profile.dart';
import 'package:heh_application/models/type_of_slot.dart';
import 'package:heh_application/models/user_exercise.dart';
import 'package:http/http.dart' as http;

import '../models/feedback.dart';
import '../models/problem.dart';
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
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      print(response.body);

      return response.body;
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
    var url = Uri.parse('${link}/api/Exercise/GetByCategoryId/$categoryId');
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
        throw Exception('Exercise  List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load exercise  list');
    }
  }

  Future<List<ExerciseDetail1>> getExerciseDetailByExerciseID(
      String exerciseID) async {
    var url =
        Uri.parse('${link}/api/ExerciseDetail/GetByExerciseID/$exerciseID');
    // var url = Uri.https('localhost:7166', 'api/ExerciseDetail/GetByExerciseID/$exerciseID');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<ExerciseDetail1> list = List<ExerciseDetail1>.from(
          jsonResult.map((model) => ExerciseDetail1.fromMap(model)));
      if (list == null) {
        throw Exception('Exercise Detail List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load exercise detail list');
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
    print(response.statusCode);
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

  Future<List<ExerciseResource>> getExerciseResourceByExerciseDetailID(
      String detailID) async {
    var url = Uri.parse(
        '${link}/api/ExerciseResource/GetByExerciseDetailId/$detailID');
    // var url = Uri.https('localhost:7166', 'api/ExerciseDetail/GetByExerciseID/$exerciseID');
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

  Future<MedicalRecord?> getMedicalRecordByUserIDAndRelationName(
      String userID) async {
    var url = Uri.parse(
        '${link}/api/MedicalRecord/GetByRelationNameAndUserID?relationName=Tôi&userID=$userID');
    // var url = Uri.https('localhost:7166', 'api/MedicalRecord');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return MedicalRecord.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load MedicalRecord');
    }
  }

  Future<MedicalRecord?> createMedicalRecord(
      MedicalRecord medicalRecord) async {
    var url = Uri.parse('${link}/api/MedicalRecord/Create');
    // var url = Uri.https('localhost:7166', 'api/MedicalRecord/Create');

    final body = jsonEncode({
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
      print('medical add');
      print(response.statusCode);
      return MedicalRecord.fromMap(json.decode(response.body));
    } else {
      print('medical add');
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

  Future<Physiotherapist> getPhysiotherapistByUserID(String id) async {
    var url = Uri.parse(
        '${link}/api/Physiotherapist/GetPhysiotherapistByUserID?userID=$id');
    // var url = Uri.https('localhost:7166', 'api/Physiotherapist');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return Physiotherapist.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load Physiotherapist');
    }
  }

  Future<List<Physiotherapist>> getAllActivePhysiotherapist() async {
    var url =
        Uri.parse('${link}/api/Physiotherapist/GetAllActivePhysiotherapist');
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

  Future<void> updateScheduleWithPhysioBookingStatus(Schedule schedule) async {
    var url = Uri.parse('${link}/api/Schedule');
    // var url = Uri.https('localhost:7166', 'api/Schedule');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    final body = jsonEncode({
      "scheduleID": schedule.scheduleID,
      "slotID": schedule.slotID,
      "physiotherapistID": schedule.physiotherapistID,
      "typeOfSlotID": schedule.typeOfSlotID,
      "description": schedule.description,
      "physioBookingStatus": schedule.physioBookingStatus,
    });
    var response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to load Schedule');
    }
  }

  Future<List<Schedule>?> getallSlotByPhysiotherapistID(
      String physiotherapistID) async {
    var url = Uri.parse(
        '${link}/api/Schedule/getAllSlotByPhysiotherapistID/$physiotherapistID');
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
      List<Schedule> list = List<Schedule>.from(
          jsonResult.map((model) => Schedule.fromMap(model)));

      if (list == null) {
        print("List Schedule Null");
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load Schedule List');
    }
  }

  Future<List<Physiotherapist>> getallPhysiotherapistBySlotID(
      String slotID) async {
    var url =
        Uri.parse('${link}/api/Schedule/getAllPhysiotherapistBySlotID/$slotID');
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

  Future<SubProfile> AddSubProfile(SubProfile subProfile) async {
    var url = Uri.parse('${link}/api/SubProfile/Create');
    // var url = Uri.https('localhost:7166', 'api/User/Register');

    final body = jsonEncode({
      "userID": subProfile.userID,
      "relationId": subProfile.relationID,
      "subName": subProfile.subName
    });
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.post(url, body: body, headers: headers);
    print('${response.statusCode} add subProfile');

    if (response.statusCode == 200) {
      return SubProfile.fromMap(json.decode(response.body));
    } else {
      print(response.body);

      throw Exception("failed to add subprofile");
    }
  }

  Future<List<SubProfile>?> getallSubProfileByUserId(String userId) async {
    var url = Uri.parse('${link}/api/SubProfile/GetByUserId/$userId');
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
      List<SubProfile> list = List<SubProfile>.from(
          jsonResult.map((model) => SubProfile.fromMap(model)));

      if (list == null) {
        print("List SubProfile Null");
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load SubProfile List');
    }
  }

  Future<List<SubProfile>?> getallSubProfileByUserIdAndSlotID(
      String userId, String slotID) async {
    var url = Uri.parse(
        '${link}/api/SubProfile/GetByUserIdAndSlotID?userId=$userId&slotID=$slotID');
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
      List<SubProfile> list = List<SubProfile>.from(
          jsonResult.map((model) => SubProfile.fromMap(model)));

      if (list == null) {
        print("List SubProfile Null");
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load SubProfile List');
    }
  }

  Future<Relationship> getRelationByRelationName(String relationName) async {
    var url =
        Uri.parse('${link}/api/Relationship/GetByRelationName/$relationName');
    // var url = Uri.https('localhost:7166', 'api/Exercise/GetByCategoryID/$categoryId');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return Relationship.fromMap(json.decode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future<List<Relationship>> getAllRelationship() async {
    var url = Uri.parse('${link}/api/Relationship');
    // var url = Uri.https('localhost:7166', 'api/TypeOfSlot');
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print("Relationship");
    if (response.statusCode == 200) {
      Iterable jsonResult = json.decode(response.body);
      List<Relationship> list = List<Relationship>.from(
          jsonResult.map((model) => Relationship.fromMap(model)));
      if (list == null) {
        throw Exception('Relationship List null');
      } else {
        return list;
      }
    } else {
      throw Exception('Failed to load Relationship');
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

  Future<BookingSchedule?> addBookingSchedule(
      BookingSchedule bookingSchedule) async {
    var url = Uri.parse('${link}/api/BookingSchedule/Create');
    // var url = Uri.https('localhost:7166', 'api/User/Register');

    final body = jsonEncode({
      "userID": bookingSchedule.userID,
      "profileID": bookingSchedule.subProfileID,
      "scheduleID": bookingSchedule.scheduleID,
      "dateBooking": bookingSchedule.dateBooking,
      "timeBooking": bookingSchedule.timeBooking,
      "status": true
    });
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.post(url, body: body, headers: headers);
    print('${response.statusCode} bookingschedule');
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return BookingSchedule.fromMap(json.decode(response.body));
    } else {
      print(response.body);

      return null;
    }
  }

  Future<bool> addBookingDetail(BookingDetail bookingDetail) async {
    var url = Uri.parse('${link}/api/BookingDetail/Create');
    // var url = Uri.https('localhost:7166', 'api/User/Register');

    final body = jsonEncode({
      "bookingScheduleID": bookingDetail.bookingScheduleID,
      "videoCallRoom": bookingDetail.videoCallRoom,
      "status": true,
    });
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.post(url, body: body, headers: headers);
    print('${response.statusCode} bookingdetail');
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return true;
    } else {
      print(response.body);

      return false;
    }
  }

  Future<Problem1?> addProblem(Problem1 problem) async {
    var url = Uri.parse('${link}/api/Problem/Create');
    // var url = Uri.https('localhost:7166', 'api/User/Register');

    final body = jsonEncode({
      "categoryID": problem.categoryID,
      "medicalRecordID": problem.medicalRecordID,
    });
    final headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };
    var response = await http.post(url, body: body, headers: headers);
    print('${response.statusCode} problem add');
    if (response.statusCode == 200) {
      return Problem1.FromMap(json.decode(response.body));
    } else {
      print(response.body);
    }
  }
}
