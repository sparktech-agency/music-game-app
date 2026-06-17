class Song {
  final String title;
  final String artist;
  final String category;
  final List<String> lyrics;
  final String albumArt;

  const Song({
    required this.title,
    required this.artist,
    required this.category,
    required this.lyrics,
    this.albumArt = 'assets/images/one_direction.jpg',
  });
}

// ২৫+ রিয়েল গানের ডাটাবেস
const List<Song> songDatabase = [
  Song(
    category: 'Pop',
    title: 'Night Changes',
    artist: 'One Direction',
    lyrics: [
      "Goin' out tonight, changes into something red",
      "Her mother doesn't like that kind of dress",
      "Everything she never had she's showin' off",
      "Drivin' too fast, moon is breakin' through her hair",
    ],
  ),
  Song(
    category: 'Rock',
    title: 'Bohemian Rhapsody',
    artist: 'Queen',
    lyrics: [
      "Is this the real life? Is this just fantasy?",
      "Caught in a landslide, no escape from reality",
      "Open your eyes, look up to the skies and see",
    ],
  ),
  Song(
    category: 'Hiphop',
    title: 'Lose Yourself',
    artist: 'Eminem',
    lyrics: [
      "His palms are sweaty, knees weak, arms are heavy",
      "There's vomit on his sweater already, mom's spaghetti",
      "He's nervous, but on the surface he looks calm and ready",
    ],
  ),
  Song(
    category: 'Indie',
    title: 'Take Me To Church',
    artist: 'Hozier',
    lyrics: [
      "My lover's got humor",
      "She's the giggle at a funeral",
      "Knows everybody's disapproval",
    ],
  ),
  Song(
    category: 'EDM',
    title: 'Wake Me Up',
    artist: 'Avicii',
    lyrics: [
      "Feeling my way through the darkness",
      "Guided by a beating heart",
      "I can't tell where the journey will end",
    ],
  ),
  Song(
    category: 'Acoustic',
    title: 'Thinking Out Loud',
    artist: 'Ed Sheeran',
    lyrics: [
      "When your legs don't work like they used to before",
      "And I can't sweep you off of your feet",
      "Will your mouth still remember the taste of my love",
    ],
  ),
  Song(
    category: 'R&B',
    title: 'Blinding Lights',
    artist: 'The Weeknd',
    lyrics: [
      "Yeah, I've been tryna call",
      "I've been on my own for long enough",
      "Maybe you can show me how to love, maybe",
    ],
  ),
];