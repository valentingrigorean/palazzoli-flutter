library appconfig;

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_config.g.dart';

@JsonSerializable()
class AppConfig extends Equatable {
  @JsonKey(name: 'path_content')
  final String pathContent;
  @JsonKey(name: 'splash_page')
  final String splashPage;
  final String logo;
  @JsonKey(name: 'c_bground_topbar')
  final String backgroundTopBarColor;
  @JsonKey(name: 'c_icon_topbar')
  final String iconTopBarColor;
  @JsonKey(name: 'c_bground_page')
  final String backgroundPageColor;
  @JsonKey(name: 'c_bground_button')
  final String backgroundButtonColor;
  @JsonKey(name: 'c_text_button')
  final String textButtonColor;
  @JsonKey(name: 'c_icon_button')
  final String iconButtonColor;
  @JsonKey(name: 'c_bground_lowbar')
  final String backgroundLowBarColor;
  @JsonKey(name: 'c_icon_lowbar_selected')
  final String iconLowBarSelected;
  @JsonKey(name: 'c_icon_lowbar_unselected')
  final String iconLowBarUnselected;
  @JsonKey(name: 'c_accordion_close')
  final String accordionCloseColor;
  @JsonKey(name: 'c_accordion_open')
  final String accordionOpenColor;
  @JsonKey(name: 'c_titol_accordion_open')
  final String titleAccordionOpenColor;
  @JsonKey(name: 'c_titol_accordion_close')
  final String titleAccordionCloseColor;
  @JsonKey(name: 'c_subtitol_accordion_open')
  final String subtitleAccordionOpenColor;
  @JsonKey(name: 'c_subtitol_accordion_close')
  final String subtitleAccordionCloseColor;
  @JsonKey(name: 'main_image')
  final String mainImage;
  @JsonKey(name: 'image_catalogue')
  final String imageCatalog;
  @JsonKey(name: 'image_favourite')
  final String imageInfo;
  @JsonKey(name: 'image_info')
  final String mailInfo;
  @JsonKey(name: 'path_image_digital')
  final String pathImageDigital;

  AppConfig(
      {this.pathContent,
      this.splashPage,
      this.logo,
      this.backgroundTopBarColor,
      this.iconTopBarColor,
      this.backgroundPageColor,
      this.backgroundButtonColor,
      this.textButtonColor,
      this.iconButtonColor,
      this.backgroundLowBarColor,
      this.iconLowBarSelected,
      this.iconLowBarUnselected,
      this.accordionCloseColor,
      this.accordionOpenColor,
      this.titleAccordionOpenColor,
      this.titleAccordionCloseColor,
      this.subtitleAccordionOpenColor,
      this.subtitleAccordionCloseColor,
      this.mainImage,
      this.imageCatalog,
      this.imageInfo,
      this.mailInfo,
      this.pathImageDigital})
      : super([
          pathContent,
          splashPage,
          logo,
          backgroundTopBarColor,
          iconTopBarColor,
          backgroundPageColor,
          backgroundButtonColor,
          textButtonColor,
          iconButtonColor,
          backgroundLowBarColor,
          iconLowBarSelected,
          iconLowBarUnselected,
          accordionCloseColor,
          accordionOpenColor,
          titleAccordionOpenColor,
          titleAccordionCloseColor,
          subtitleAccordionOpenColor,
          subtitleAccordionCloseColor,
          mainImage,
          imageCatalog,
          imageInfo,
          mailInfo,
          pathImageDigital
        ]);

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigToJson(this);
}

@JsonSerializable()
class AppConfigList extends Equatable {
  final List<AppConfig> items;

  AppConfigList(this.items) : super([items]);

  AppConfig getItem() => items == null || items.length == 0 ? null : items[0];

  factory AppConfigList.fromJson(Map<String, dynamic> json) =>
      _$AppConfigListFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigListToJson(this);
}
