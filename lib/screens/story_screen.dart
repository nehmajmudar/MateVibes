import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matevibes/models/story_model.dart';
import 'package:matevibes/res/app_colors.dart';

class StoryScreen extends StatefulWidget {

  final List<StoryModel> stories;
  const StoryScreen({Key? key,required this.stories}) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late PageController _pageController;
  int currentIndex=0;

  @override
  void initState(){
    super.initState();
    _pageController=PageController();
    final StoryModel firstStory= widget.stories.first;
    loadStory(story: firstStory, animatePage: false);

    animationController.addStatusListener((status) {
      if(status== AnimationStatus.completed){
        animationController.stop();
        animationController.reset();
        setState(() {
          if(currentIndex + 1<= widget.stories.length){
            currentIndex += 1;
            loadStory(story: widget.stories[currentIndex]);
          }
          else{
            currentIndex=0;
            loadStory(story: widget.stories[currentIndex]);
          }
        });
      }
    });
  }

  @override
  void dispose(){
    animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StoryModel story=widget.stories[currentIndex];
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundColor,
      body: GestureDetector(
        onTapDown: (details)=>_onTapDown(details,story),
        child: PageView.builder(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.stories.length,
            itemBuilder: (context,i){
              final StoryModel story=widget.stories[i];
              switch(story.media){
                case MediaType.image:
                  return CachedNetworkImage(
                    imageUrl: story.url,
                    fit: BoxFit.cover
                  );
                  break;
                case MediaType.video:
                  return CachedNetworkImage(
                      imageUrl: story.url,
                      fit: BoxFit.cover
                  );
                  break;
                default:
                  return SizedBox.shrink();
              }
            }
        ),
      ),
    );
  }
  void _onTapDown(TapDownDetails details, StoryModel story){
    final double screenWidth=MediaQuery.of(context).size.width;
    final double dx=details.globalPosition.dx;
    if(dx<screenWidth/3){
      setState(() {
        if(currentIndex-1>=0){
          currentIndex -= 1;
          loadStory(story: widget.stories[currentIndex]);
        }
      });
    }else if (dx>2 * screenWidth/3){
      setState(() {
        if(currentIndex+1 < widget.stories.length){
          currentIndex += 1;
          loadStory(story: widget.stories[currentIndex]);
        }
        else{
          currentIndex=0;
          loadStory(story: widget.stories[currentIndex]);
        }
      });
    }
  }

  void loadStory({StoryModel? story,bool animatePage=true}){
    animationController.stop();
    animationController.reset();
    switch(story!.media){
      case MediaType.image:
        animationController.duration=story.duration;
        animationController.forward();
        break;
      case MediaType.video:
        animationController.duration=story.duration;
        animationController.forward();
        break;
    }
    if(animatePage){
      _pageController.animateToPage(currentIndex, duration: Duration(milliseconds: 1), curve: Curves.easeInOut);
    }
  }

}
