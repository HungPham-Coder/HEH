class UserChat {
  String id;
  String nickname;
  String photoUrl;
  UserChat({required this.id,required this.nickname, required this.photoUrl});
  factory UserChat.fromMap (Map<String,dynamic>? data, String documentID){
    if (data == null) {
      return null!;
    }
    final String nickname = data['nickname'];
    final String photoUrl = data['photoUrl'];
    return UserChat(id: documentID, nickname: nickname, photoUrl: photoUrl);
  }

}