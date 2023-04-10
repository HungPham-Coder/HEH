import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/landing_page.dart';

import 'package:heh_application/Member%20page/Service%20Page/advisesession.dart';
import 'package:heh_application/Member%20page/Service%20Page/longtermtreatment.dart';
import 'package:heh_application/Member%20page/Messenger%20page/messenger_page.dart';
import 'package:heh_application/models/sign_up_user.dart';
import 'package:heh_application/models/chat_model/user_chat.dart';
import 'package:heh_application/services/auth.dart';
import 'package:heh_application/services/chat_provider.dart';
import 'package:heh_application/services/firebase_firestore.dart';
import 'package:provider/provider.dart';

class Physiotherapist extends StatefulWidget {
  const Physiotherapist({
    Key? key,
    this.currentUser,
  }) : super(key: key);
  final SignUpUser? currentUser;

  @override
  State<Physiotherapist> createState() => _PhysiotherapistState();
}

class _PhysiotherapistState extends State<Physiotherapist> {
  UserChat? opponentUser;

  Future<void> loadPhysioTherapistAccount() async {
    final firestoreDatabase =
        Provider.of<FirebaseFirestoreBase>(context, listen: false);
    UserChat? userChatResult =
        await firestoreDatabase.getPhysioUser(physioID: 'physiotherapist');
    opponentUser = userChatResult;
  }
  // Future<void> getSignUpUser () async {
  //   sharedSignupUser = await CallAPI().getUserById(sharedResultLogin!.userID!);
  //
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    // print("${sharedSignupUser!.firstName} physio");
    String physioIcon = 'assets/icons/physio.png';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Dịch vụ",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Bạn đang cần tim đến dịch vụ của chúng tôi?"),
            PhysiptherapistMenu(
              icon:
                  "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fadvise.png?alt=media&token=73296749-85c7-415c-9287-eb044d23d6a1",
              text: "Tư vấn một buổi",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdviseSession()));
              },
            ),
            PhysiptherapistMenu(
              icon:
                  "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphysio.png?alt=media&token=dcc89b01-2c15-4808-87eb-4a2ecc9667a3",
              text: "Điều trị lâu dài",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LongTermTreatment(),
                    ));
              },
            ),
            PhysiptherapistMenu(
              icon:
                  "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fcare.png?alt=media&token=0ce5dd58-bcaf-45a8-b277-05eaad8b89b8",
              text: "Chăm sóc khách hàng",
              press: () async {
                await loadPhysioTherapistAccount();
                await auth.checkUserExistInFirebase(sharedCurrentUser!);

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  if (sharedCurrentUser?.image == null) {
                    sharedCurrentUser?.setImage = "Không có hình";
                  }

                  if (sharedCurrentUser != null) {
                    return Provider<ChatProviderBase>(
                      create: (context) => ChatProvider(),
                      child: MessengerPage(
                          oponentID: opponentUser!.id,
                          oponentAvartar: opponentUser!.photoUrl,
                          oponentNickName: opponentUser!.nickname,
                          userAvatar: sharedCurrentUser!.image,
                          currentUserID: sharedCurrentUser!.userID!),
                    );
                  } else {
                    print('null');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PhysiptherapistMenu extends StatelessWidget {
  const PhysiptherapistMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xfff5f6f9)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.white)),
              )),
          onPressed: press,
          child: Row(
            children: [
              Image.network(
                icon,
                width: 60,
              ),
              const SizedBox(
                width: 20,
                height: 10,
              ),
              Expanded(
                  child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              )),
              const Icon(Icons.arrow_forward_sharp),
            ],
          )),
    );
  }
}
