class CommunityModel {
  int? idx;
  int? position;
  String title;

  CommunityModel({required this.idx, required this.position, required this.title});

  @override
  String toString() {
    return 'idx : $idx, position : $position, title : $title';
  }


}