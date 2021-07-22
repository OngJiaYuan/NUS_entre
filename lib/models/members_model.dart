class User {
  final String id;
  final String fullName;
  final String linked;
  final String Telegram;

  User({
    required this.id,
    required this.fullName,
    required this.linked,
    required this.Telegram,
  });
  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['Name'],
        linked = data['linked'],
        Telegram = data['Telegram'];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'linked': linked,
      'Telegram': Telegram,
    };
  }
}
