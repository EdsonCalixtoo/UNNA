import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:unna/controllers/user_controller.dart';
import '../models/comment.dart';
import '../models/post.dart';
import '../services/database.dart';

class PostController extends GetxController {
  UserController _userController = Get.find<UserController>();
  List<PostModel> listAllPosts = [];
  RxBool isOptionsFilterVisible = false.obs;
  var filteredPosts = [].obs;
  var filterLiked = false.obs;
  var filterCategory = "".obs;
  var filterDate = DateTime(1500).obs;

  void setOptionsFinishVisible(bool value) {
    isOptionsFilterVisible.value = value;
  }

  void setFilter() {
    List<PostModel> filteredList = [];
    if (filterLiked.value || filterCategory.value != "" || filterDate.value != DateTime(1500)) {
      filteredList.addAll(listAllPosts);
      if (filterDate.value != DateTime(1500)) {
        filteredList.removeWhere((element) {
          if (element.actionData!.toDate().difference(filterDate.value).inSeconds <= 0) {
            return true;
          } else {
            return false;
          }
        });
      }

      if (filterCategory.value != "") {
        filteredList.removeWhere((element) {
          if (element.category!.trim() == filterCategory.trim()) {
            return false;
          } else {
            return true;
          }
        });
      }

      if (filterLiked.value) {
        filteredList.removeWhere((element) {
          if (element.likes!.contains(_userController.user.id)) {
            return false;
          } else {
            return true;
          }
        });
      }
    } else {
      filteredList.addAll(listAllPosts);
    }
    filteredPosts.clear();
    filteredPosts.addAll(filteredList);
  }

  void resetFilters() {
    filterLiked.value = false;
    filterCategory.value = "";
    filterDate.value = DateTime(1500);
    setFilter();
  }

  Stream<QuerySnapshot<PostModel>> getStreamPosts(
    String category,
    String subCategory,
  ) {
    return Database().getStreamPosts(
      null,
      category,
      subCategory,
    );
  }

  Stream<QuerySnapshot<CommentModel>> getStreamComments({required String postId}) {
    return Database().getStreamComments(postId: postId);
  }

  final postList = [].obs;
  final postListUserProfile = [].obs;
  final commentList = [].obs;
  final isLoading = false.obs;
  final isLoadingSendingComment = false.obs;
  final isFetchingTop = false.obs;
  final isFetchingBotton = false.obs;
  final isFetching = false.obs;
  final isGridView = false.obs;
  final isEditing = false.obs;
  final imageTempUrl = ''.obs;
  String selectedFilter = 'geral';

  @override
  // ignore: must_call_super
  void onInit() {
    print('OnInit postController selectedFilter=' + selectedFilter);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleGridView() {
    isGridView.value = !isGridView.value;
  }

  void toggleLike(String idUsuario, PostModel post) {
    if (post.likes!.contains(idUsuario)) {
      post.likes!.remove(idUsuario);
      Database().removeLike(idUsuario, post.id!);
      int i = post.likeCount!;
      i--;
      post.likeCount = i;
    } else {
      Database().addLike(idUsuario, post.id!);
      post.likes!.add(idUsuario);
      int i = post.likeCount!;
      i++;
      post.likeCount = i;
    }
  }

  Future<void> getComments({required String postId}) async {
    print('\n\n --- RODOU getComments postId=' + postId);
    isFetching.value = true;
    commentList.clear();
    List<CommentModel> newComments = [];
    newComments = await Database().getComments(postId: postId);

    if (newComments.length > 0) newComments.forEach((comments) => commentList.add(comments));

    print('\n\n --- TERMINOU getComments');

    isFetching.value = false;
  }

  Future<void> getMore({int quantity = 10, required String userId}) async {
    isFetchingBotton.value = true;

    print('\n\n --- RODOU getMore selectedFilter:' + selectedFilter);

    List<PostModel> newPosts = [];
    Timestamp startDate = postList[postList.length - 1]?.createdAt;

    newPosts = await Database().getPosts(
      startDate: startDate,
      quantity: quantity,
      isRefresh: false,
      selectedFilter: selectedFilter,
      userId: userId,
    );

    print(' --- getMore newPosts.length: ' + newPosts.length.toString());
    if (newPosts.length > 0) {
      newPosts.forEach((post) {
        if (this.selectedFilter == 'posts_profile_user') {
          postListUserProfile.add(post);
        } else {
          postList.add(post);
        }
      });
    }

    print('\n\n --- TERMINOU getMore');
    isFetchingBotton.value = false;
  }

  void updateFilter(String newFilter, String userId) {
    print(' --- this.selectedFilter=${this.selectedFilter} newFilter=' + newFilter + ' userId=' + userId);
    if ((newFilter != this.selectedFilter) || (this.selectedFilter == 'posts_profile_user')) {
      this.selectedFilter = newFilter;

      if (this.selectedFilter == 'posts_profile_user') {
        postListUserProfile.clear();
      } else {
        postList.clear();
      }

      get(startDate: null, quantity: 10, userId: userId);
    }
  }

  Future<void> get({
    Timestamp? startDate,
    int? quantity,
    bool isRefresh = false,
    String? userId,
  }) async {
    if (!isRefresh) isFetchingBotton.value = true;
    if (startDate == null) isLoading.value = true;

    print('\n\n --- RODOU get selectedFilter=' + this.selectedFilter);

    List<PostModel> newPosts = [];
    newPosts = await Database().getPosts(
        startDate: startDate,
        quantity: quantity,
        isRefresh: isRefresh,
        selectedFilter: this.selectedFilter,
        userId: userId);

    print(' --- newPosts.length: ' + newPosts.length.toString());
    if (newPosts.length > 0) {
      newPosts.forEach((post) {
        if (isRefresh) {
          postList.insert(0, post);
        } else {
          if (this.selectedFilter == 'posts_profile_user') {
            postListUserProfile.add(post);
          } else {
            postList.add(post);
          }
        }
      });
    }

    print('\n\n --- TERMINOU get');

    if (!isRefresh) isFetchingBotton.value = false;
    if (startDate == null) isLoading.value = false;
  }

  Future<void> add({
    required String body,
    String category = 'geral',
    required String userHandle,
    required String userName,
    required String userImage,
    required String postImage,
    required DateTime actionData,
    required String subCategorie,
  }) async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 6));
    Database().addPost({
      'body': body.trim(),
      'commentCount': 0,
      'likeCount': 0,
      'userHandle': userHandle,
      'userName': userName,
      'userImage': userImage != '' ? userImage : 'https://eu.ui-avatars.com/api/?name=$userName&background=random',
      'postImage': postImage != ''
          ? postImage
          : 'https://firebasestorage.googleapis.com/v0/b/experimentosdiversos.appspot.com/o/zSocialImagens%2FtesteImage.png?alt=media&token=53a7bdf7-a9e2-4752-a11f-d0ccd074936c',
      'category': category != '' ? category : 'geral',
      'createdAt': Timestamp.now(),
      'actionData': actionData,
      'subCategorie': subCategorie,
    });

    imageTempUrl.value = '';
    isLoading.value = false;
  }

  void deleteComment({
    required postId,
    required commentId,
  }) {
    Database().deleteComment(postId, commentId);

    commentList.removeWhere((comment) => comment.id == commentId);
  }

  Future<void> addComment({
    required String postId,
    required String body,
    required String userHandle,
    required String userName,
    required String userImage,
  }) async {
    isLoadingSendingComment.value = true;
    Database().addComment({
      'body': body.trim(),
      'userHandle': userHandle,
      'userName': userName,
      'userImage': userImage != '' ? userImage : 'https://eu.ui-avatars.com/api/?name=$userName&background=random',
      'postId': postId,
      'dateCreatedAt': Timestamp.now(),
    });

    commentList.add(CommentModel(
      body: body.trim(),
      userHandle: userHandle,
      userImage: userImage,
      id: commentList.length.toString(),
      postId: postId,
      userName: userName,
      dateCreatedAt: Timestamp.now(),
    ));

    Database().incrementCommentCount(postId);

    postList.where((post) => post.id == postId).forEach((element) {
      element.commentCount++;
    });

    isLoadingSendingComment.value = false;
  }

  Future<void> edit({
    required String id,
    required String body,
    String category = 'geral',
    required String userHandle,
    required String userName,
    required String userImage,
    required String postImage,
    required DateTime actionData,
    required String subCategorie,
  }) async {
    isLoading.value = true;
    Database().editPost({
      'id': id,
      'body': body.trim(),
      'commentCount': 0,
      'likeCount': 0,
      'userHandle': userHandle,
      'userName': userName,
      'userImage': userImage != '' ? userImage : 'https://eu.ui-avatars.com/api/?name=$userName&background=random',
      'postImage': postImage != ''
          ? postImage
          : 'https://firebasestorage.googleapis.com/v0/b/experimentosdiversos.appspot.com/o/zSocialImagens%2FtesteImage.png?alt=media&token=53a7bdf7-a9e2-4752-a11f-d0ccd074936c',
      'category': category != '' ? category : 'geral',
      'actionData': actionData,
      'subCategorie': subCategorie,
    });

    imageTempUrl.value = '';
    isLoading.value = false;
  }

  Future<String> uploadImageCard(var file) async {
    String res = await Database().uploadPictureGetUrl(file);
    return res;
  }
}
