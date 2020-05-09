class Comment {
  String authorName;
  String authorImageUrl;
  String text;

  Comment({
    this.authorName,
    this.authorImageUrl,
    this.text,
  });
}

final List<Comment> comments = [
  Comment(
    authorName: 'Angel',
    authorImageUrl: 'assets/images/user2.png',
    text: 'App Aprovado',
  ),
  Comment(
    authorName: 'Charlie',
    authorImageUrl: 'assets/images/user3.png',
    text: 'App Aprovado',
  ),
  Comment(
    authorName: 'Angelina Martin',
    authorImageUrl: 'assets/images/user4.png',
    text: 'Can\'App Aprovado',
  ),
  Comment(
    authorName: 'Jax',
    authorImageUrl: 'assets/images/user1.png',
    text: 'App Aprovado',
  ),
  Comment(
    authorName: 'Sam Martin',
    authorImageUrl: 'assets/images/user0.png',
    text: 'App Aprovado)',
  ),
];
