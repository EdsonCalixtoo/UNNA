import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story/story.dart';
import '../controllers/user_controller.dart';
import '../models/story_model.dart';
import '../services/database.dart';
import '../utils/colors.dart';

class StoryPage extends StatefulWidget {
  final List<List<StoryModel>> storys;
  final int initialPage;
  const StoryPage({super.key, required this.storys, required this.initialPage});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  UserController _userController = Get.find<UserController>();
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StoryPageView(
      initialPage: widget.initialPage,
      indicatorAnimationController: indicatorAnimationController,
      itemBuilder: (context, pageIndex, storyIndex) {
        final storyGroup = widget.storys[pageIndex];
        final story = storyGroup[storyIndex];

        if (DateTime.now().difference(story.createdAt.toDate()).inHours >= 24) {
          Database().deleteStory(story.id);
        }

        return Stack(
          children: [
            Positioned.fill(
              child: Container(color: Theme.of(context).primaryColor),
            ),
            Positioned.fill(
              child: story.type == StoryType.Text
                  ? Center(
                      child: Text(story.storyData!,
                          style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.055)),
                    )
                  : story.type == StoryType.Video
                      ? Center(
                          child: Text("Não Implementado",
                              style:
                                  TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.055)),
                        )
                      : Image.memory(
                          story.storyData!,
                          fit: BoxFit.cover,
                        ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 44, left: 8),
              child: Row(
                children: [
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          story.userModel.userImage!,
                        ),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    story.userModel.name!,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      gestureItemBuilder: (context, pageIndex, storyIndex) {
        final storyGroup = widget.storys[pageIndex];
        final story = storyGroup[storyIndex];
        return Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
            if (story.userModel.id == _userController.user.id)
              Positioned(
                  bottom: 15,
                  right: 15,
                  child: FloatingActionButton(
                      backgroundColor: corFundoClara,
                      child: Icon(Icons.delete_forever, color: Colors.red),
                      onPressed: () {
                        indicatorAnimationController.value = IndicatorAnimationCommand.pause;
                        Get.dialog(AlertDialog(
                          title: Text("Deseja deletar o Story?"),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                              onPressed: () {
                                Get.back();
                                Database().deleteStory(story.id);
                                Get.back();
                              },
                              child: Text("Deletar"),
                            )
                          ],
                        )).then((value) {
                          indicatorAnimationController.value = IndicatorAnimationCommand.resume;
                        });
                      }))
          ],
        );
      },
      storyLength: (pageIndex) {
        return widget.storys[pageIndex].length;
      },
      pageLength: widget.storys.length,
      onPageLimitReached: () {
        Get.back();
      },
    ));
  }
}
