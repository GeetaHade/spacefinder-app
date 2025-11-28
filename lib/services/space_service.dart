import '../models/space_models.dart';

/// Dummy list of study spaces (fake backend)
const List<StudySpace> allSpaces = [
  StudySpace(
    id: 'galvin',
    name: 'Paul V. Galvin Library',
    imageAsset: 'assets/galvin.jpg',
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
    imageAsset: 'assets/herman.jpg',
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
    name: 'SR Crown Hall',
    imageAsset: 'assets/crown.jpg',
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
