// ignore_for_file: file_names

class ImageModels {
  String url;
  String error;

  ImageModels({required this.url, required this.error});

  factory ImageModels.url(Map<String, dynamic> json) {
    return ImageModels(url: json['data'][0]['url'], error: '');
  }

  factory ImageModels.error(Map<String, dynamic> json) {
    return ImageModels(url: '', error: json['error']['message']);
  }
}
