import '../models/space_models.dart';

/// Dummy list of study spaces (fake backend)
const List<StudySpace> allSpaces = [
  StudySpace(
    id: 'galvin',
    name: 'Paul V. Galvin Library',
    imageAsset: 'assets/LibraryImg.jpg',
    layoutImageAsset: 'assets/LibraryImg.jpg',
    rating: 4.8,
    noise: NoiseLevel.quiet,
    crowd: CrowdLevel.medium,
    seatingOptions: [
      SeatingType.individualDesks,
      SeatingType.groupTables,
    ],
    environment: EnvironmentType.bright,
    amenities: [
      AmenityType.outlets,
      AmenityType.wifi,
      AmenityType.longHours,
    ],
  ),
  StudySpace(
    id: 'herman',
    name: 'Hermann Hall',
    imageAsset: 'assets/HermanHallImg.jpg',
    layoutImageAsset: 'assets/HermanHallImg.jpg',
    rating: 4.5,
    noise: NoiseLevel.balanced,
    crowd: CrowdLevel.high,
    seatingOptions: [
      SeatingType.groupTables,
      SeatingType.softSeating,
    ],
    environment: EnvironmentType.soft,
    amenities: [
      AmenityType.cafe,
      AmenityType.wifi,
    ],
  ),
  StudySpace(
    id: 'crown',
    name: 'MTCC',
    imageAsset: 'assets/Mtcc.jpg',
    layoutImageAsset: 'assets/Mtcc.jpg',
    rating: 4.2,
    noise: NoiseLevel.busy,
    crowd: CrowdLevel.high,
    seatingOptions: [
      SeatingType.softSeating,
    ],
    environment: EnvironmentType.cool,
    amenities: [
      AmenityType.wifi,
    ],
  ),
  StudySpace(
    id: 'library_private',
    name: 'Library Private Room',
    imageAsset: 'assets/PrivateRoomImg.jpg',
    layoutImageAsset: 'assets/PrivateRoomMap.png',
    rating: 4.9,
    noise: NoiseLevel.quiet,
    crowd: CrowdLevel.low,
    seatingOptions: [
      SeatingType.studyPods,
      SeatingType.individualDesks,
    ],
    environment: EnvironmentType.soft,
    amenities: [
      AmenityType.outlets,
      AmenityType.wifi,
      AmenityType.longHours,
    ],
  ),
  StudySpace(
    id: 'library_silent',
    name: 'Library Silent Study Zone',
    imageAsset: 'assets/SileantStudyImg.jpg',
    layoutImageAsset: 'assets/SileantStudyMap.png',
    rating: 4.7,
    noise: NoiseLevel.quiet,
    crowd: CrowdLevel.medium,
    seatingOptions: [
      SeatingType.individualDesks,
      SeatingType.softSeating,
    ],
    environment: EnvironmentType.bright,
    amenities: [
      AmenityType.outlets,
      AmenityType.wifi,
    ],
  ),
];

/// Helper to get a space by id
StudySpace _spaceById(String id) =>
    allSpaces.firstWhere((s) => s.id == id);

/// Rule-based + scoring matcher
List<StudySpace> findMatchingSpaces(UserPreferences prefs) {
  // ---------- HARD RULES FIRST ----------

  // 1) Quiet, low-ish crowd, individual desks -> strongly recommend Galvin
  final wantsQuietGalvin =
      prefs.noise == NoiseLevel.quiet &&
      (prefs.crowd == CrowdLevel.low || prefs.crowd == CrowdLevel.medium) &&
      prefs.seating == SeatingType.individualDesks;

  if (wantsQuietGalvin) {
    return [_spaceById('galvin')];
  }

  // 2) Some crowd, cafe, soft lighting -> Hermann
  final wantsCafe = prefs.amenities.contains(AmenityType.cafe);
  final wantsSoftLight = prefs.environment == EnvironmentType.soft;
  final wantsSomeCrowd =
      prefs.crowd == CrowdLevel.medium || prefs.crowd == CrowdLevel.high;

  if (wantsCafe && wantsSoftLight && wantsSomeCrowd) {
    return [_spaceById('herman')];
  }

  // ---------- FALLBACK: SCORING APPROACH ----------

  final List<MapEntry<StudySpace, int>> scored = [];

  for (final space in allSpaces) {
    int score = 0;

    if (prefs.noise != null && prefs.noise == space.noise) score++;
    if (prefs.crowd != null && prefs.crowd == space.crowd) score++;
    if (prefs.environment != null && prefs.environment == space.environment) score++;
    if (prefs.seating != null && space.seatingOptions.contains(prefs.seating)) score++;

    // amenities: +1 if at least one preferred amenity is available
    if (prefs.amenities.isNotEmpty) {
      final overlap = space.amenities
          .where((a) => prefs.amenities.contains(a))
          .length;
      if (overlap > 0) score++;
    }

    scored.add(MapEntry(space, score));
  }

  // sort highest score first
  scored.sort((a, b) => b.value.compareTo(a.value));

  // keep only spaces with score > 0
  final filtered = scored.where((e) => e.value > 0).map((e) => e.key).toList();

  if (filtered.isEmpty) {
    // nothing matched well → just show top 1–2 anyway
    final top = scored.map((e) => e.key).toList();
    return top.take(2).toList();
  }

  // return only top 1–2 suggestions
  return filtered.take(2).toList();
}
