import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail_model.freezed.dart';
part 'product_detail_model.g.dart';

@freezed
class ProductDetailResponse with _$ProductDetailResponse {
  const factory ProductDetailResponse({required Domeggook domeggook}) =
      _ProductDetailResponse;

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailResponseFromJson(json);
}

@freezed
class Domeggook with _$Domeggook {
  const factory Domeggook({
    required Basis basis,
    required Price price,
    required Qty qty,
    required Deli deli,
    required Channel channel,
    required Thumb thumb,
    required Desc desc,
    required String selectOpt,
    required Seller seller,
    required Benefits benefits,
    required Detail detail,
    required Category category,
    @JsonKey(name: 'return') required ReturnInfo returnInfo,
    required Event event,
    required Etc etc,
  }) = _Domeggook;

  factory Domeggook.fromJson(Map<String, dynamic> json) =>
      _$DomeggookFromJson(json);
}

@freezed
class Basis with _$Basis {
  const factory Basis({
    required int no,
    required String status,
    required String title,
    required Keywords keywords,
    required String section,
    required String nego,
    required String adult,
    required String dateStart,
    required String dateEnd,
    required String dateReg,
    required String secretItem,
    required String tax,
  }) = _Basis;

  factory Basis.fromJson(Map<String, dynamic> json) => _$BasisFromJson(json);
}

@freezed
class Keywords with _$Keywords {
  const factory Keywords({required List<String> kw}) = _Keywords;

  factory Keywords.fromJson(Map<String, dynamic> json) =>
      _$KeywordsFromJson(json);
}

@freezed
class Price with _$Price {
  const factory Price({required String dome, required String supply}) = _Price;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}

@freezed
class Qty with _$Qty {
  const factory Qty({
    required String inventory,
    required String domeMoq,
    required int domeUnit,
    required int supplyUnit,
  }) = _Qty;

  factory Qty.fromJson(Map<String, dynamic> json) => _$QtyFromJson(json);
}

@freezed
class Deli with _$Deli {
  const factory Deli({
    required String method,
    required String pay,
    required DeliOption dome,
    required DeliOption supply,
    required String wating,
    required String periodDeli,
    required String sendAvg,
    required String fastDeli,
    required Merge merge,
    required FeeExtra feeExtra,
    required String fromOversea,
    required String reqCcno,
  }) = _Deli;

  factory Deli.fromJson(Map<String, dynamic> json) => _$DeliFromJson(json);
}

@freezed
class DeliOption with _$DeliOption {
  const factory DeliOption({
    String? pay,
    required String type,
    required String tbl,
  }) = _DeliOption;

  factory DeliOption.fromJson(Map<String, dynamic> json) =>
      _$DeliOptionFromJson(json);
}

@freezed
class Merge with _$Merge {
  const factory Merge({required String enable}) = _Merge;

  factory Merge.fromJson(Map<String, dynamic> json) => _$MergeFromJson(json);
}

@freezed
class FeeExtra with _$FeeExtra {
  const factory FeeExtra({
    required String jeju,
    required String islands,
    required String useDeliPro,
  }) = _FeeExtra;

  factory FeeExtra.fromJson(Map<String, dynamic> json) =>
      _$FeeExtraFromJson(json);
}

@freezed
class Channel with _$Channel {
  const factory Channel({required String dome, required String supply}) =
      _Channel;

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
}

@freezed
class Thumb with _$Thumb {
  const factory Thumb({
    required String small,
    required String large,
    required String original,
    required String smallPng,
    required String largePng,
    String? hash,
    required String lastUpdate,
  }) = _Thumb;

  factory Thumb.fromJson(Map<String, dynamic> json) => _$ThumbFromJson(json);
}

@freezed
class Desc with _$Desc {
  const factory Desc({required License license, required Contents contents}) =
      _Desc;

  factory Desc.fromJson(Map<String, dynamic> json) => _$DescFromJson(json);
}

@freezed
class License with _$License {
  const factory License({required String usable, required String msg}) =
      _License;

  factory License.fromJson(Map<String, dynamic> json) =>
      _$LicenseFromJson(json);
}

@freezed
class Contents with _$Contents {
  const factory Contents({
    required String item,
    required String deli,
    required String event,
    required String otherItem,
  }) = _Contents;

  factory Contents.fromJson(Map<String, dynamic> json) =>
      _$ContentsFromJson(json);
}

@freezed
class Seller with _$Seller {
  const factory Seller({
    required String id,
    required String nick,
    required String type,
    required String rank,
    required String power,
    required String good,
    required String global,
    required Score score,
    required Company company,
  }) = _Seller;

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}

@freezed
class Score with _$Score {
  const factory Score({required String avg, required int cnt}) = _Score;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}

@freezed
class Company with _$Company {
  const factory Company({
    required String name,
    required String boss,
    required String cno,
    required String addr,
    required String phone,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}

@freezed
class Benefits with _$Benefits {
  const factory Benefits({required SellerPoint sellerPoint}) = _Benefits;

  factory Benefits.fromJson(Map<String, dynamic> json) =>
      _$BenefitsFromJson(json);
}

@freezed
class SellerPoint with _$SellerPoint {
  const factory SellerPoint({required String type}) = _SellerPoint;

  factory SellerPoint.fromJson(Map<String, dynamic> json) =>
      _$SellerPointFromJson(json);
}

@freezed
class Detail with _$Detail {
  const factory Detail({
    required String size,
    required String weight,
    required String country,
    required String manufacturer,
    required String model,
    required String oversea,
    required String itemCustomCode,
    required InfoDuty infoDuty,
  }) = _Detail;

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
}

@freezed
class InfoDuty with _$InfoDuty {
  const factory InfoDuty({
    required String type,
    required List<InfoDutyItem> item,
  }) = _InfoDuty;

  factory InfoDuty.fromJson(Map<String, dynamic> json) =>
      _$InfoDutyFromJson(json);
}

@freezed
class InfoDutyItem with _$InfoDutyItem {
  const factory InfoDutyItem({
    required String type,
    required String name,
    required String desc,
  }) = _InfoDutyItem;

  factory InfoDutyItem.fromJson(Map<String, dynamic> json) =>
      _$InfoDutyItemFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    required Parents parents,
    required CategoryElem current,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class Parents with _$Parents {
  const factory Parents({required List<CategoryElem> elem}) = _Parents;

  factory Parents.fromJson(Map<String, dynamic> json) =>
      _$ParentsFromJson(json);
}

@freezed
class CategoryElem with _$CategoryElem {
  const factory CategoryElem({
    required String name,
    required String code,
    required int depth,
  }) = _CategoryElem;

  factory CategoryElem.fromJson(Map<String, dynamic> json) =>
      _$CategoryElemFromJson(json);
}

@freezed
class ReturnInfo with _$ReturnInfo {
  const factory ReturnInfo({
    required ReturnAddr addr,
    required int deliAmt,
    required String deliAmtDouble,
  }) = _ReturnInfo;

  factory ReturnInfo.fromJson(Map<String, dynamic> json) =>
      _$ReturnInfoFromJson(json);
}

@freezed
class ReturnAddr with _$ReturnAddr {
  const factory ReturnAddr({
    required String no,
    required String zipcode,
    required String address1,
    required String address2,
    required String phone,
    required String mobile,
  }) = _ReturnAddr;

  factory ReturnAddr.fromJson(Map<String, dynamic> json) =>
      _$ReturnAddrFromJson(json);
}

@freezed
class Event with _$Event {
  const factory Event({required Join join, required String packDeli}) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

@freezed
class Join with _$Join {
  const factory Join({required List<String> no}) = _Join;

  factory Join.fromJson(Map<String, dynamic> json) => _$JoinFromJson(json);
}

@freezed
class Etc with _$Etc {
  const factory Etc({
    required String showByMailzine,
    required String connectStompApi,
    required String denyMarket,
  }) = _Etc;

  factory Etc.fromJson(Map<String, dynamic> json) => _$EtcFromJson(json);
}
