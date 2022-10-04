const Map<String, List<double>> templateDimensions = {
  'ig_story': [1080, 1920],
  'ig_post':[1080, 1350],
  'ig_square':[1080,1080]
};

const Map<String, int> localeTagId = {
  'global':21656,
  'en_US':699,
  'en_IN':3054,
};

const Map<String, int> cost = {
  'paid':29934
};

class TemplateDimension{
  double? width, height;

  TemplateDimension({this.width, this.height});

  factory TemplateDimension.fromName(String tag) {
    final dimensions = templateDimensions[tag];
    return TemplateDimension(
      width: dimensions!=null ? dimensions[0] : null,
      height: dimensions!=null ? dimensions[1] : null,
    );
  }
}
