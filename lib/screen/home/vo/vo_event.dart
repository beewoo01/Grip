class Event {
  final int event_idx;
  final String event_title;
  final String event_description;
  final int event_img_idx;
  final String event_img_url;

  Event(this.event_idx, this.event_title, this.event_description, this.event_img_idx, this.event_img_url);

  factory Event.fromJson(Map<String, dynamic> map) {
    return Event(
        map["event_idx"],
        map["event_title"],
        map["event_description"],
        map["event_img_idx"],
        map["event_img_url"],
    );
  }

}