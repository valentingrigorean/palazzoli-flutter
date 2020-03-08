// GENERATED CODE - DO NOT MODIFY BY HAND

part of appconfig;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) {
  return AppConfig(
      pathContent: json['path_content'] as String,
      splashPage: json['splash_page'] as String,
      logo: json['logo'] as String,
      backgroundTopBarColor: json['c_bground_topbar'] as String,
      iconTopBarColor: json['c_icon_topbar'] as String,
      backgroundPageColor: json['c_bground_page'] as String,
      backgroundButtonColor: json['c_bground_button'] as String,
      textButtonColor: json['c_text_button'] as String,
      iconButtonColor: json['c_icon_button'] as String,
      backgroundLowBarColor: json['c_bground_lowbar'] as String,
      iconLowBarSelected: json['c_icon_lowbar_selected'] as String,
      iconLowBarUnselected: json['c_icon_lowbar_unselected'] as String,
      accordionCloseColor: json['c_accordion_close'] as String,
      accordionOpenColor: json['c_accordion_open'] as String,
      titleAccordionOpenColor: json['c_titol_accordion_open'] as String,
      titleAccordionCloseColor: json['c_titol_accordion_close'] as String,
      subtitleAccordionOpenColor: json['c_subtitol_accordion_open'] as String,
      subtitleAccordionCloseColor: json['c_subtitol_accordion_close'] as String,
      mainImage: json['main_image'] as String,
      imageCatalog: json['image_catalogue'] as String,
      imageInfo: json['image_favourite'] as String,
      mailInfo: json['image_info'] as String,
      pathImageDigital: json['path_image_digital'] as String);
}

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'path_content': instance.pathContent,
      'splash_page': instance.splashPage,
      'logo': instance.logo,
      'c_bground_topbar': instance.backgroundTopBarColor,
      'c_icon_topbar': instance.iconTopBarColor,
      'c_bground_page': instance.backgroundPageColor,
      'c_bground_button': instance.backgroundButtonColor,
      'c_text_button': instance.textButtonColor,
      'c_icon_button': instance.iconButtonColor,
      'c_bground_lowbar': instance.backgroundLowBarColor,
      'c_icon_lowbar_selected': instance.iconLowBarSelected,
      'c_icon_lowbar_unselected': instance.iconLowBarUnselected,
      'c_accordion_close': instance.accordionCloseColor,
      'c_accordion_open': instance.accordionOpenColor,
      'c_titol_accordion_open': instance.titleAccordionOpenColor,
      'c_titol_accordion_close': instance.titleAccordionCloseColor,
      'c_subtitol_accordion_open': instance.subtitleAccordionOpenColor,
      'c_subtitol_accordion_close': instance.subtitleAccordionCloseColor,
      'main_image': instance.mainImage,
      'image_catalogue': instance.imageCatalog,
      'image_favourite': instance.imageInfo,
      'image_info': instance.mailInfo,
      'path_image_digital': instance.pathImageDigital
    };

AppConfigList _$AppConfigListFromJson(Map<String, dynamic> json) {
  return AppConfigList((json['items'] as List)
      ?.map((e) =>
          e == null ? null : AppConfig.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$AppConfigListToJson(AppConfigList instance) =>
    <String, dynamic>{'items': instance.items};
