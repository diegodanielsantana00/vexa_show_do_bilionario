// ignore_for_file: non_constant_identifier_names, file_names
class Config {
  Config({this.sound_effects, this.music});

  String? sound_effects;
  String? music;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'music': music,
      'sound_effects': sound_effects,
    };
    return map;
  }

  Config.fromMap(Map<String, dynamic> map) {
    music = map['music'];
    sound_effects = map['sound_effects'];

  }
}
