class APOD {
  final String date;
  final String explanation;
  final String title;
  final String url;

  const APOD({
    this.date,
    this.explanation,
    this.title,
    this.url,
  });

  factory APOD.fromJson(Map<String, dynamic> map) {
    return APOD(
      date: map["date"],
      explanation: map["explanation"],
      title: map["title"],
      url: map["url"],
    );
  }
}
