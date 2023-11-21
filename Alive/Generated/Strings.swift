// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// yyyy年M月dd日
  internal static let dateFormat = L10n.tr("Localizable", "date_format", fallback: "yyyy年M月dd日")
  /// ja_JP
  internal static let dateLocale = L10n.tr("Localizable", "date_locale", fallback: "ja_JP")
  /// このLiveを削除しますか？
  internal static let deleteButtonAlertTitle = L10n.tr("Localizable", "delete_button_alert_title", fallback: "このLiveを削除しますか？")
  /// 削除
  internal static let deleteButtonTitle = L10n.tr("Localizable", "delete_button_title", fallback: "削除")
  /// Localizable.strings
  ///   Alive
  /// 
  ///   Created by t&a on 2023/11/20.
  internal static let liveArtist = L10n.tr("Localizable", "live_artist", fallback: "アーティスト")
  /// 終演
  internal static let liveClosingTime = L10n.tr("Localizable", "live_closingTime", fallback: "終演")
  /// 開催日
  internal static let liveDate = L10n.tr("Localizable", "live_date", fallback: "開催日")
  /// MEMO
  internal static let liveMemo = L10n.tr("Localizable", "live_memo", fallback: "MEMO")
  /// ライブ名
  internal static let liveName = L10n.tr("Localizable", "live_name", fallback: "ライブ名")
  /// 開場
  internal static let liveOpeningTime = L10n.tr("Localizable", "live_openingTime", fallback: "開場")
  /// 開演
  internal static let livePerformanceTime = L10n.tr("Localizable", "live_performanceTime", fallback: "開演")
  /// チケット代
  internal static let livePrice = L10n.tr("Localizable", "live_price", fallback: "チケット代")
  /// ライブ形式
  internal static let liveType = L10n.tr("Localizable", "live_type", fallback: "ライブ形式")
  /// 対バン
  internal static let liveTypeBattleBands = L10n.tr("Localizable", "live_type_battleBands", fallback: "対バン")
  /// フェス
  internal static let liveTypeFestival = L10n.tr("Localizable", "live_type_festival", fallback: "フェス")
  /// ワンマン
  internal static let liveTypeOneman = L10n.tr("Localizable", "live_type_oneman", fallback: "ワンマン")
  /// 未設定
  internal static let liveTypeUnknown = L10n.tr("Localizable", "live_type_unknown", fallback: "未設定")
  /// 開催地
  internal static let liveVenue = L10n.tr("Localizable", "live_venue", fallback: "開催地")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
