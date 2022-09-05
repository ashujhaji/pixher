import 'package:http/http.dart' as http;

import 'api_constant.dart';

class ApiProvider {
  static ApiProvider? _provider;

  static ApiProvider getInstance() {
    _provider ??= ApiProvider();
    return _provider!;
  }

  Future<http.Response> getCategories() => http.get(
        Uri.parse(ApiConstant.CATEGORIES+'?per_page=100'),
        headers: {ApiConstant.CONTENT_TYPE: ApiConstant.APPLICATION_JSON},
      );

  Future<http.Response> getTemplatesByCategory(categoryId) => http.get(
        Uri.parse(
            '${ApiConstant.TEMPLATES}?categories=$categoryId'),
        headers: {ApiConstant.CONTENT_TYPE: ApiConstant.APPLICATION_JSON},
      );
  
  Future<http.Response> getRelevantTags(tag) => http.get(
    Uri.parse('${ApiConstant.INSTAGRAM_API}?tag_name=$tag'),
    headers: {ApiConstant.CONTENT_TYPE: ApiConstant.APPLICATION_JSON,
    'x-ig-app-id':'936619743392459',
    'cookie':' mid=YdrobQAEAAGgUFpZKRRglKbLjllT; ig_did=BF50B9AE-A123-44AF-AAB9-BF5A55464337; ig_nrcb=1; csrftoken=bt9APMIVd9mEgnytKBVp6IdodLuurZ5L; sessionid=7073479901%3A8Dicmb7NeuT8kn%3A17; ds_user_id=7073479901; dpr=2; datr=fLLvYuvc0PZyJVB9QQcmLkeu; shbid="19647\0547073479901\0541691411967:01f71039b7934ec73fc87801b736ef3fc4317b535012f7f754d9635b057246084c8e7564"; shbts="1659875967\0547073479901\0541691411967:01f71297bb350736a3eaee8f17eb7b2b7fc3486f5140071f859aa551c653165dea75bb6e"; fbm_124024574287414=base_domain=.instagram.com; fbsr_124024574287414=UoKqceoN2ZBuFco8h2KVpstTpgxdj_5BwJfI4nykNYY.eyJ1c2VyX2lkIjoiMTAwMDAzMjkyMTQwMDc0IiwiY29kZSI6IkFRQm54UVQ4bVhuRnYzeXJPNWdncTZRTWVfc0c3Zk05M2xKM3J5b1dDcEV4Nzg2RkNESjJaZDB5LThQTjZDejNycE5ZU1N2WVFiazlFaDh3dkFvRmtMWVM4cm15ek5TMGNDRUg2LTRlWURWQlY1M3Y3R2lsd1I1Q2tFSmR6Ul9VZ1owTHlTeTdIUFF0dEJJSEktTVRIVGZnS09EbTRCRU1MNnZpZXdBemFLc2V6VzFTamFNWmY2SEFGdE1tXzUzYVl4WkRQTE55cUEyLVVtWUItN0w5Q0tDZWd3Q1VEdzJpR29EWUpCd05mR3kydFBza2k2STByaTdnODU0d2lvM2ZtNE45SFNYUElMMFZMSzFXRkNBTWItZU1tSnI3U3UxSXAzWU1rX3NtdktjR194RHZvVjE1NVhoQ2otTzktekR2U2VxQ0Iwb0NsWWZzaUZHdG40UTdleVFhIiwib2F1dGhfdG9rZW4iOiJFQUFCd3pMaXhuallCQUlGazJaQzhvVW1RYzltaXBWQzJCdkxGSTFaQjhMUmxUUGUxWG1aQTA0QTZaQU10eFZ3eDRlZGJiVkU2ekd6eFNiT1IyWkNBS0JXQVRkdW9MWkNmQkI2b3dyajludFdFa05SZlpBRWRlUWRaQTRNVlNLNFpDdENzcnBpTHVGUFhucXNPdkt2b2ZBdjhiVDRlb1pCNG1FWkMyMkRnZ1dTa0lWQnFjeG1WU0FDOWd1SSIsImFsZ29yaXRobSI6IkhNQUMtU0hBMjU2IiwiaXNzdWVkX2F0IjoxNjYwMTI0MzA4fQ; rur="NCG\0547073479901\0541691660324:01f77b882701f2bb802005155749f66d71159a7ac44197257db762e3372ee56fee386000"',},
  );

  Future<http.Response> getRandomCaption(tags) => http.get(
    Uri.parse('${ApiConstant.CAPTION_API}?$tags'),
  );
}
