import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unna/controllers/category_controller.dart';
import 'package:unna/controllers/post_controller.dart';
import 'package:unna/controllers/user_controller.dart';
import 'package:unna/models/comment.dart';
import 'package:unna/models/post.dart';
import 'package:unna/utils/colors.dart';
import 'package:unna/widgets/botao_cortado.dart';
import 'package:unna/widgets/botao_simples.dart';
import 'package:unna/widgets/comment_card.dart';

// ignore: must_be_immutable
class PostCommentScreen extends StatelessWidget {
  final TextEditingController commentTextController = TextEditingController();

  static String title = 'Post - Comentar';
  static String idEditing = '';
  PostModel? post;
  BuildContext? localContext;

  PostController _postController = Get.find<PostController>();
  UserController _userController = Get.find<UserController>();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    localContext = context;
    if (Get.arguments != null) {
      post = Get.arguments as PostModel;
      title = post!.userName!;
    } else {
      Get.back();
    }

    return Scaffold(
      floatingActionButton: commentForm(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(
              color: corBlack,
            ),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            pinned: true,
            backgroundColor: corFundoClara,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    height: 270,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(64, 64, 64, 0.5),
                          Color.fromRGBO(0, 0, 0, 0.8),
                          Color.fromRGBO(0, 0, 0, 1),
                        ],
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(post != null
                            ? post!.postImage!
                            : 'https://firebasestorage.googleapis.com/v0/b/experimentosdiversos.appspot.com/o/zSocialImagens%2FtesteImage.png?alt=media&token=53a7bdf7-a9e2-4752-a11f-d0ccd074936c'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.grey.withAlpha(77),
                          BlendMode.dstATop,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        userLine(),
                        post!.body != null
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.black26,
                                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      child: Text(
                                        post!.body!,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          height: 1.3,
                                          color: Colors.white,
                                          letterSpacing: 1.1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                commentsArea(),
                SizedBox(height: 16),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget commentForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Row(
        children: [
          Expanded(
            flex: 70,
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.campaign,
                  color: corPrimaria,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    topLeft: Radius.circular(90),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: corPrimaria,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    topLeft: Radius.circular(90),
                  ),
                  borderSide: BorderSide(
                    width: 2,
                    color: corPrimaria,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Seu comentario...',
                hintStyle: TextStyle(
                  color: corPrimariaEscura,
                ),
              ),
              controller: commentTextController,
              autocorrect: false,
              style: TextStyle(
                color: corBlack,
              ),
            ),
          ),
          Obx(
            () => Expanded(
              flex: 20,
              child: _postController.isLoadingSendingComment.value == true
                  ? loadingElement()
                  : BotaoCortado(
                      executarAcao: () {
                        if ((commentTextController.text.trim() != '')) {
                          _postController.addComment(
                            postId: post!.id!,
                            body: commentTextController.text.trim(),
                            userHandle: _userController.user.email!,
                            userName: _userController.user.name!,
                            userImage: _userController.user.userImage!,
                          );

                          commentTextController.text = '';
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                          );
                        } else {
                          Get.snackbar(
                            'Opa, ta errado manolo',
                            'Preenche os campos direito que vai!',
                            snackPosition: SnackPosition.TOP,
                            duration: Duration(seconds: 5),
                            colorText: Colors.white,
                          );
                        }

                        print("enviei comentario");
                      },
                      iconeBotao: Icon(
                        Icons.send,
                        size: 30,
                        color: _postController.isLoading.value == false ? Colors.white : Colors.transparent,
                      ),
                      textoBotao: "",
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingElement() {
    return Container(
      height: 53,
      decoration: BoxDecoration(
        color: corPrimaria,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(90),
          topRight: Radius.circular(90),
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ),
    );
  }

  Widget emptyListComment() {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 45,
            color: Colors.black54,
          ),
          Text(
            "Nenhum comentario no momento",
          )
        ],
      ),
    );
  }

  Widget commentsArea() {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 68),
      child: StreamBuilder<QuerySnapshot<CommentModel>>(
        stream: _postController.getStreamComments(postId: post!.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              ),
            );
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text(
                "Erro ao carregar comentarios",
              ),
            );
          }
          return Container(
            child: snapshot.data!.docs.length <= 0
                ? emptyListComment()
                : Column(
                    children: List.generate(
                      snapshot.data!.docs.length,
                      (index) => CommentCard(
                        comment: snapshot.data!.docs[index].data(),
                        loggedUserHandle: _userController.user.email!,
                        onDelete: () {
                          _postController.deleteComment(
                            postId: post!.id!,
                            commentId: snapshot.data!.docs[index].data().id,
                          );
                        },
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget mainContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            corFundoClara,
            corFundoEscura,
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "aqui vem os comentarios",
                ),
                SizedBox(
                  height: 260,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.loyalty,
                      color: corPrimaria,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90),
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90),
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'Nome',
                    hintStyle: TextStyle(
                      color: corPrimariaEscura,
                    ),
                  ),
                  controller: commentTextController,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: corBlack,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userLine() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(top: 35, right: 15),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post!.userHandle!.split('@')[0],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      DateFormat('dd.MM hh:mm').format(post!.createdAt!.toDate()).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: corBlack.withAlpha(50),
                        blurRadius: 17,
                        offset: Offset(0, 12),
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: post!.userImage!,
                      height: 51,
                      width: 51,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget areaBotoesInferiores(context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 35,
              child: BotaoSimples(
                executarAcao: () {
                  Get.back();
                },
                iconeBotao: Icon(
                  Icons.cancel,
                  size: 20,
                  color: Colors.white,
                ),
                textoBotao: "Cancelar",
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              flex: 35,
              child: GetX<CategoryController>(
                  initState: (_) {},
                  builder: (categoryControler) {
                    return !categoryControler.isLoading()
                        ? BotaoSimples(
                            executarAcao: () async {
                              print("\n\n* SALVAR \n");
                            },
                            iconeBotao: Icon(
                              Icons.save,
                              size: 20,
                              color: Colors.white,
                            ),
                            textoBotao: "Enviar",
                          )
                        : Container(
                            height: 20,
                            width: 20,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(corPrimariaClara),
                              ),
                            ),
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
