// lib/models/space_models.dart
enum NoiseLevel { quiet, balanced, busy }
enum MusicPref { lightMusic, cafeAmbience, natureSounds, noMusic }
enum CrowdLevel { low, medium, high }
enum SeatingType { individualDesks, groupTables, softSeating, studyPods }
enum EnvironmentType { bright, soft, cool, warm }
enum AmenityType { outlets, wifi, cafe, longHours }

class UserPreferences {
  NoiseLevel? noise;
  MusicPref? music;
  CrowdLevel? crowd;
  SeatingType? seating;
  EnvironmentType? environment;
  List<AmenityType> amenities = [];
  
}

final userPrefs = UserPreferences();

class StudySpace {
  final String id;
  final String name;
  final String imageAsset; // you can point to assets
  final String? layoutImageAsset;
  final double rating;
  final NoiseLevel noise;
  final CrowdLevel crowd;
  final List<SeatingType> seatingOptions;
  final EnvironmentType environment;
  final List<AmenityType> amenities; 

  const StudySpace({
    required this.id,
    required this.name,
    required this.imageAsset,
    this.layoutImageAsset,
    required this.rating,
    required this.noise,
    required this.crowd,
    required this.seatingOptions,
    required this.environment,
    required this.amenities,
  });
}
