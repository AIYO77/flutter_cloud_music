class UserFollowEvent {
  final String id;
  final bool isFollowed;

  const UserFollowEvent({required this.id, required this.isFollowed});
}
