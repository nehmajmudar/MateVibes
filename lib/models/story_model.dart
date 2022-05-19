
class StoryModel{
  String? uid;
  String? storyId;
  String? storyUrl;
  String? caption;

  StoryModel({this.uid,this.storyId,this.storyUrl,this.caption});

  factory StoryModel.fromMap(map){
    return StoryModel(
      uid: map['uid'],
      storyId: map['storyId'],
      storyUrl: map['storyUrl'],
      caption: map['caption'],
    );
  }

  Map<String,dynamic> toMap(){
    return{
      'uid': uid,
      'storyId': storyId,
      'storyUrl': storyUrl,
      'caption': caption
    };
  }
}