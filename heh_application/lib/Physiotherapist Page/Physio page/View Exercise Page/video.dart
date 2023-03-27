class Video {
  final String name, url, thumbnail;
  const Video({
    required this.name,
    required this.url,
    required this.thumbnail,
  });
}

const videos = [
  Video(name: 'video', url: '', thumbnail: 'assets/images/profile.jpg'),
  // Video(
  //     name: 'video2',
  //     url: 'assets/videos/video2.MP4',
  //     thumbnail: 'assets/images/profile.jpg'),
  // Video(
  //     name: 'video3',
  //     url: 'assets/videos/video3.MP4',
  //     thumbnail: 'assets/images/profile.jpg'),
  // Video(
  //     name: 'video4',
  //     url: 'assets/videos/video4.MP4',
  //     thumbnail: 'assets/images/profile.jpg'),
  // Video(
  //     name: 'video5',
  //     url: 'assets/videos/video5.MP4',
  //     thumbnail: 'assets/images/profile.jpg'),
];
