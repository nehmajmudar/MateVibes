import 'package:flutter/material.dart';
import 'package:matevibes/res/app_colors.dart';
import 'package:story_view/story_view.dart';

class StoryViewWidget extends StatefulWidget {
  final snap;
  const StoryViewWidget({Key? key,required this.snap}) : super(key: key);

  @override
  _StoryViewWidgetState createState() => _StoryViewWidgetState();
}

class _StoryViewWidgetState extends State<StoryViewWidget> {
  final storyItems=<StoryItem>[];
  StoryController controller=StoryController();

  void addItems(){
    for(final story in widget.snap){
      if(story['storyUrl']==null){
        storyItems.add(StoryItem.text(title: story['caption'], backgroundColor: AppColors.colorWhite));
      }
      else{
        storyItems.add(StoryItem.inlineImage(url: story['storyUrl'], controller: controller,caption: Text(story['caption'])));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    addItems();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: storyItems,
      controller: controller,
      onVerticalSwipeComplete: (direction){
        if(direction==Direction.down){
          Navigator.of(context).pop();
        }
      },
    );
  }
}
