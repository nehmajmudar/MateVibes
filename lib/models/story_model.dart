import 'package:matevibes/models/user_model.dart';

enum MediaType{
  image,
  video
}

class StoryModel{
  final String url;
  final MediaType media;
  final Duration duration;
  final UserModel user;

  StoryModel({
    required this.url,
    required this.media,
    required this.duration,
    required this.user,
});
}