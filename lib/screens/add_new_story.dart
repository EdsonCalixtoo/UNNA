import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_new_story_controller.dart';
import '../utils/colors.dart';

class AddNewStory extends StatefulWidget {
  const AddNewStory({super.key});

  @override
  State<AddNewStory> createState() => _AddNewStoryState();
}

class _AddNewStoryState extends State<AddNewStory> {
  AddNewStoryController controller = AddNewStoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: corPrimaria,
        title: Text("Adicionar Story"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  actionsAlignment: MainAxisAlignment.center,
                  title: Text("Adicionar Story"),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: corPrimaria,
                      ),
                      onPressed: () async {
                        controller.sendStoryImage();
                      },
                      child: Obx(
                        () => controller.isLoading.value
                            ? Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                ),
                              )
                            : Text(
                                "Adicionar",
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.add_box),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder<List<Uint8List>>(
            future: controller.getGalery(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                    ),
                  ),
                );
              }
              if (snapshot.hasError || snapshot.data == null) {
                return SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Erro ao carregar galeria",
                    ),
                  ),
                );
              }
              controller.data = snapshot.data![controller.indexSelected.value];
              return Column(
                children: [
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight / 2,
                    child: Obx(
                      () => Image.memory(
                        snapshot.data![controller.indexSelected.value],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight / 2,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          controller.indexSelected.value = index;
                          controller.data = snapshot.data![controller.indexSelected.value];
                        },
                        child: Obx(
                          () => Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: controller.indexSelected.value == index ? corPrimaria : Colors.transparent,
                                width: 5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                snapshot.data![index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
