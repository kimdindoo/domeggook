import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail_model.freezed.dart';
part 'product_detail_model.g.dart';

@freezed
class ProductDetailModel with _$ProductDetailModel {
  factory ProductDetailModel({required Domeggook domeggook}) =
      _ProductDetailResponse;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);
}

@freezed
class Domeggook with _$Domeggook {
  factory Domeggook({
    required Basis basis,
    required Price price,
    required Qty qty,
    required Deli deli,
    required Channel channel,
    required Thumb thumb,
    required DescClass desc,
    String? selectOpt,
    required Seller seller,
    required Benefits benefits,
    required Detail detail,
    required Category category,
    @JsonKey(name: 'return') required ReturnClass domeggookReturn,
    Popular? popular,
    required Event event,
    required Etc etc,
  }) = _Domeggook;

  factory Domeggook.fromJson(Map<String, dynamic> json) =>
      _$DomeggookFromJson(json);
}

// ===================== Basis / Keywords =====================
@freezed
class Basis with _$Basis {
  factory Basis({
    int? no,
    String? status,
    String? title,
    required Keywords keywords,
    String? section,
    String? nego,
    String? adult,
    DateTime? dateStart,
    DateTime? dateEnd,
    DateTime? dateReg,
    String? secretItem,
    String? tax,
  }) = _Basis;

  factory Basis.fromJson(Map<String, dynamic> json) => _$BasisFromJson(json);
}

@freezed
class Keywords with _$Keywords {
  factory Keywords({required List<String> kw}) = _Keywords;
  factory Keywords.fromJson(Map<String, dynamic> json) =>
      _$KeywordsFromJson(json);
}

// ===================== Benefits / SellerPoint =====================
@freezed
class Benefits with _$Benefits {
  factory Benefits({required SellerPoint sellerPoint}) = _Benefits;
  factory Benefits.fromJson(Map<String, dynamic> json) =>
      _$BenefitsFromJson(json);
}

@freezed
class SellerPoint with _$SellerPoint {
  factory SellerPoint({String? type}) = _SellerPoint;
  factory SellerPoint.fromJson(Map<String, dynamic> json) =>
      _$SellerPointFromJson(json);
}

// ===================== Category =====================
@freezed
class Category with _$Category {
  factory Category({required Parents parents, required Current current}) =
      _Category;
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class Current with _$Current {
  factory Current({String? name, String? code, int? depth}) = _Current;
  factory Current.fromJson(Map<String, dynamic> json) =>
      _$CurrentFromJson(json);
}

@freezed
class Parents with _$Parents {
  factory Parents({required List<Current> elem}) = _Parents;
  factory Parents.fromJson(Map<String, dynamic> json) =>
      _$ParentsFromJson(json);
}

// ===================== Channel / Deli / Dome / Merge / FeeExtra =====================
@freezed
class Channel with _$Channel {
  factory Channel({String? dome, String? supply}) = _Channel;
  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
}

@freezed
class Deli with _$Deli {
  factory Deli({
    String? method,
    String? pay,
    required Dome dome,
    required Dome supply,
    String? wating,
    String? periodDeli,
    String? sendAvg,
    String? fastDeli,
    required Merge merge,
    @JsonKey(fromJson: _toString) String? shippingArea, // ! 확인
    required FeeExtra feeExtra,
    String? fromOversea,
    String? reqCcno,
  }) = _Deli;

  factory Deli.fromJson(Map<String, dynamic> json) => _$DeliFromJson(json);
}

@freezed
class Dome with _$Dome {
  factory Dome({String? type, String? tbl}) = _Dome;
  factory Dome.fromJson(Map<String, dynamic> json) => _$DomeFromJson(json);
}

@freezed
class Merge with _$Merge {
  factory Merge({String? enable}) = _Merge;
  factory Merge.fromJson(Map<String, dynamic> json) => _$MergeFromJson(json);
}

@freezed
class FeeExtra with _$FeeExtra {
  factory FeeExtra({String? jeju, String? islands, String? useDeliPro}) =
      _FeeExtra;
  factory FeeExtra.fromJson(Map<String, dynamic> json) =>
      _$FeeExtraFromJson(json);
}

// ===================== DescClass / Contents / License =====================
@freezed
class DescClass with _$DescClass {
  factory DescClass({
    required License license,
    String? notice,
    required Contents contents,
  }) = _DescClass;

  factory DescClass.fromJson(Map<String, dynamic> json) =>
      _$DescClassFromJson(json);
}

@freezed
class Contents with _$Contents {
  factory Contents({
    String? item,
    String? deli,
    String? event,
    String? otherItem,
  }) = _Contents;

  factory Contents.fromJson(Map<String, dynamic> json) =>
      _$ContentsFromJson(json);
}

@freezed
class License with _$License {
  factory License({String? usable, String? msg}) = _License;
  factory License.fromJson(Map<String, dynamic> json) =>
      _$LicenseFromJson(json);
}

// ===================== Price / Qty / Thumb =====================
@freezed
class Price with _$Price {
  factory Price({String? dome}) = _Price;
  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}

@freezed
class Qty with _$Qty {
  factory Qty({
    @JsonKey(fromJson: _toString) String? inventory,
    @JsonKey(fromJson: _toString) String? domeMoq,
    @JsonKey(fromJson: _toString) String? domeUnit,
  }) = _Qty;

  factory Qty.fromJson(Map<String, dynamic> json) => _$QtyFromJson(json);
}

@freezed
class Thumb with _$Thumb {
  factory Thumb({
    String? small,
    String? large,
    String? original,
    String? smallPng,
    String? largePng,
    String? hash,
    DateTime? lastUpdate,
  }) = _Thumb;

  factory Thumb.fromJson(Map<String, dynamic> json) => _$ThumbFromJson(json);
}

// ===================== Seller / Score / Company =====================
@freezed
class Seller with _$Seller {
  factory Seller({
    String? id,
    String? nick,
    String? type,
    String? rank,
    String? power,
    String? good,
    String? global,
    required Score score,
    required Company company,
  }) = _Seller;

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}

@freezed
class Score with _$Score {
  factory Score({String? avg, int? cnt}) = _Score;
  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}

@freezed
class Company with _$Company {
  factory Company({
    String? name,
    String? boss,
    String? cno,
    String? addr,
    String? phone,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}

// ===================== Detail / InfoDuty / Item =====================
@freezed
class Detail with _$Detail {
  factory Detail({
    String? size,
    String? weight,
    String? country,
    String? manufacturer,
    String? model,
    @JsonKey(fromJson: _safetyCertFromJson) List<SafetyCert>? safetyCert,
    String? oversea,
    String? itemCustomCode,
    InfoDuty? infoDuty,
  }) = _Detail;

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
}

@freezed
class InfoDuty with _$InfoDuty {
  factory InfoDuty({String? type, required List<InfoItem> item}) = _InfoDuty;
  factory InfoDuty.fromJson(Map<String, dynamic> json) =>
      _$InfoDutyFromJson(json);
}

enum Type {
  @JsonValue('item')
  ITEM,
  @JsonValue('transaction')
  TRANSACTION,
}

@freezed
class InfoItem with _$InfoItem {
  factory InfoItem({
    @JsonKey(unknownEnumValue: Type.ITEM) Type? type,
    String? name,
    String? desc,
  }) = _InfoItem;

  factory InfoItem.fromJson(Map<String, dynamic> json) =>
      _$InfoItemFromJson(json);
}

// ===================== SafetyCert =====================
@freezed
class SafetyCert with _$SafetyCert {
  factory SafetyCert({
    String? exem,
    String? exemTitle,
    String? exemContent1,
    String? exemContent2,
    String? cert,
    String? useImgUrl,
    String? imgUrl,
    String? type,
    String? name,
    String? certType,
    String? certName,
    String? useNo,
    String? no,
    String? useWarning,
    String? warning,
  }) = _SafetyCert;

  factory SafetyCert.fromJson(Map<String, dynamic> json) =>
      _$SafetyCertFromJson(json);
}

// ===================== ReturnClass / Addr =====================
@freezed
class ReturnClass with _$ReturnClass {
  factory ReturnClass({
    required Addr addr,
    int? deliAmt,
    String? deliAmtDouble,
  }) = _ReturnClass;

  factory ReturnClass.fromJson(Map<String, dynamic> json) =>
      _$ReturnClassFromJson(json);
}

@freezed
class Addr with _$Addr {
  factory Addr({
    String? no,
    String? zipcode,
    String? address1,
    String? address2,
    String? phone,
    String? mobile,
  }) = _Addr;

  factory Addr.fromJson(Map<String, dynamic> json) => _$AddrFromJson(json);
}

// ===================== Event / Popular / Etc =====================
@freezed
class Event with _$Event {
  factory Event({
    @JsonKey(fromJson: _joinFromJson) Join? join,
    String? packDeli,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

// ! JSON 필드가 동적으로 타입이 바뀔 수 있음
@freezed
class Join with _$Join {
  factory Join({List<String>? no}) = _Join;

  factory Join.fromJson(Map<String, dynamic> json) => _$JoinFromJson(json);
}

// JSON이 ""이면 null, Map이면 Join.fromJson 사용
Join? _joinFromJson(dynamic json) {
  if (json == null || json == "") return null;
  return Join.fromJson(json as Map<String, dynamic>);
}

@freezed
class Popular with _$Popular {
  factory Popular({String? code, String? name}) = _Popular;
  factory Popular.fromJson(Map<String, dynamic> json) =>
      _$PopularFromJson(json);
}

@freezed
class Etc with _$Etc {
  factory Etc({
    String? showByMailzine,
    String? connectStompApi,
    String? denyMarket,
  }) = _Etc;
  factory Etc.fromJson(Map<String, dynamic> json) => _$EtcFromJson(json);
}

// int, double, String 모두 안전하게 String으로 변환
String? _toString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

// null이 들어와도 빈 리스트로 처리
List<SafetyCert>? _safetyCertFromJson(dynamic json) {
  if (json == null) return null; // 또는 [] 로도 가능
  return (json as List<dynamic>)
      .map((e) => SafetyCert.fromJson(e as Map<String, dynamic>))
      .toList();
}
