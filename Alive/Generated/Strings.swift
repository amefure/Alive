// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// 広告を視聴して容量を追加する
  internal static let adsAddCapacity = L10n.tr("Localizable", "ads_add_capacity", fallback: "広告を視聴して容量を追加する")
  /// 広告を視聴できるのは1日に1回までです。
  internal static let adsAlertMsg = L10n.tr("Localizable", "ads_alert_msg", fallback: "広告を視聴できるのは1日に1回までです。")
  /// お知らせ
  internal static let adsAlertTitle = L10n.tr("Localizable", "ads_alert_title", fallback: "お知らせ")
  /// 現在の容量:%@個
  internal static func adsCurrentCapacity(_ p1: Any) -> String {
    return L10n.tr("Localizable", "ads_current_capacity_%@", String(describing: p1), fallback: "現在の容量:%@個")
  }
  /// ・追加される容量は10個です。
  /// ・容量の追加は1日に1回までです。
  internal static let adsDesc1 = L10n.tr("Localizable", "ads_desc_1", fallback: "・追加される容量は10個です。\n・容量の追加は1日に1回までです。")
  /// 設定から広告を視聴すると
  /// 保存容量を増やすことができます。
  internal static let adsLimitAlertMsg = L10n.tr("Localizable", "ads_limit_alert_msg", fallback: "設定から広告を視聴すると\n保存容量を増やすことができます。")
  /// 保存容量が上限に達しました...
  internal static let adsLimitAlertTitle = L10n.tr("Localizable", "ads_limit_alert_title", fallback: "保存容量が上限に達しました...")
  /// 広告を読み込み中です。
  internal static let adsLoading = L10n.tr("Localizable", "ads_loading", fallback: "広告を読み込み中です。")
  /// 広告
  internal static let adsTitle = L10n.tr("Localizable", "ads_title", fallback: "広告")
  /// https://apps.apple.com/jp/app/alive-live参戦記録アプリ/id6473169112
  internal static let appUrl = L10n.tr("Localizable", "app_url", fallback: "https://apps.apple.com/jp/app/alive-live参戦記録アプリ/id6473169112")
  /// アーティストカウント棒グラフ
  internal static let chartsBarName = L10n.tr("Localizable", "charts_bar_name", fallback: "アーティストカウント棒グラフ")
  /// データがありません
  internal static let chartsNoData = L10n.tr("Localizable", "charts_no_data", fallback: "データがありません")
  /// アーティストカウント円グラフ
  internal static let chartsPieName = L10n.tr("Localizable", "charts_pie_name", fallback: "アーティストカウント円グラフ")
  /// iPhoneとApple Watchの同期に失敗しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。
  internal static let connectErrorActivateFailedMessage = L10n.tr("Localizable", "connect_error_activate_failed_message", fallback: "iPhoneとApple Watchの同期に失敗しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。")
  /// iPhoneとApple Watchの接続に失敗しました。Bletoothのペアリング状況を確認してください。
  internal static let connectErrorConnectFailedMessage = L10n.tr("Localizable", "connect_error_connect_failed_message", fallback: "iPhoneとApple Watchの接続に失敗しました。Bletoothのペアリング状況を確認してください。")
  /// 通信エラー
  internal static let connectErrorTitle = L10n.tr("Localizable", "connect_error_title", fallback: "通信エラー")
  /// yyyy年M月d日
  internal static let dateFormat = L10n.tr("Localizable", "date_format", fallback: "yyyy年M月d日")
  /// yyyy年
  /// M月d日
  internal static let dateFormatBlake = L10n.tr("Localizable", "date_format_blake", fallback: "yyyy年\nM月d日")
  /// ja_JP
  internal static let dateLocale = L10n.tr("Localizable", "date_locale", fallback: "ja_JP")
  /// 削除
  internal static let deleteButtonTitle = L10n.tr("Localizable", "delete_button_title", fallback: "削除")
  /// このLiveを削除しますか？
  internal static let deleteLiveAlertTitle = L10n.tr("Localizable", "delete_live_alert_title", fallback: "このLiveを削除しますか？")
  /// %@を削除しますか？
  internal static func deleteTimetableAlertTitle(_ p1: Any) -> String {
    return L10n.tr("Localizable", "delete_timetable_alert_title_%@", String(describing: p1), fallback: "%@を削除しますか？")
  }
  /// 登録しました。
  internal static let entrySuccessAlertTitle = L10n.tr("Localizable", "entry_success_alert_title", fallback: "登録しました。")
  /// 登録
  internal static let entryTimetableButton = L10n.tr("Localizable", "entry_timetable_button", fallback: "登録")
  /// 予期せぬエラーが発生しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。
  internal static let imageErrorCastFailedMessage = L10n.tr("Localizable", "image_error_cast_failed_message", fallback: "予期せぬエラーが発生しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。")
  /// 画像の削除に失敗しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。
  internal static let imageErrorDeleteFailedMessage = L10n.tr("Localizable", "image_error_delete_failed_message", fallback: "画像の削除に失敗しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。")
  /// 画像の保存に失敗しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。
  internal static let imageErrorSaveFailedMessage = L10n.tr("Localizable", "image_error_save_failed_message", fallback: "画像の保存に失敗しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。")
  /// 画像操作エラー
  internal static let imageErrorTitle = L10n.tr("Localizable", "image_error_title", fallback: "画像操作エラー")
  /// 時間
  internal static let inputTimePickerExtension = L10n.tr("Localizable", "input_time_picker_extension", fallback: "時間")
  /// アーティスト
  internal static let liveArtist = L10n.tr("Localizable", "live_artist", fallback: "アーティスト")
  /// 終演
  internal static let liveClosingTime = L10n.tr("Localizable", "live_closingTime", fallback: "終演")
  /// 開催日
  internal static let liveDate = L10n.tr("Localizable", "live_date", fallback: "開催日")
  /// 開催年
  internal static let liveDateYear = L10n.tr("Localizable", "live_date_year", fallback: "開催年")
  /// 次のライブの予定はありません
  internal static let liveDemoNextTitle = L10n.tr("Localizable", "live_demo_next_title", fallback: "次のライブの予定はありません")
  /// 一押しアーティスト
  internal static let liveMainArtist = L10n.tr("Localizable", "live_main_artist", fallback: "一押しアーティスト")
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
  /// - 円
  internal static let livePriceNone = L10n.tr("Localizable", "live_price_none", fallback: "- 円")
  /// %@円
  internal static func livePriceUnit(_ p1: Any) -> String {
    return L10n.tr("Localizable", "live_price_unit_%@", String(describing: p1), fallback: "%@円")
  }
  /// セトリ
  internal static let liveSetlist = L10n.tr("Localizable", "live_setlist", fallback: "セトリ")
  /// TimeTable
  internal static let liveTimeTable = L10n.tr("Localizable", "live_timeTable", fallback: "TimeTable")
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
  /// URL
  internal static let liveUrl = L10n.tr("Localizable", "live_url", fallback: "URL")
  /// 開催地
  internal static let liveVenue = L10n.tr("Localizable", "live_venue", fallback: "開催地")
  /// Localizable.strings
  ///   Alive
  /// 
  ///   Created by t&a on 2023/11/20.
  internal static let onboarding1Title = L10n.tr("Localizable", "onboarding1_title", fallback: "次のLive情報をチケット風に表示！\n直近1ヶ月のLive参戦履歴を塗り潰そう！")
  /// アーティストごとの参戦回数をグラフで確認！
  /// 友達に参戦回数を自慢しよう！
  internal static let onboarding2Title = L10n.tr("Localizable", "onboarding2_title", fallback: "アーティストごとの参戦回数をグラフで確認！\n友達に参戦回数を自慢しよう！")
  /// 自分だけのタイムテーブルを作成できる！
  /// 開始時間や色分け、MEMOも残せるよ！
  internal static let onboarding3Title = L10n.tr("Localizable", "onboarding3_title", fallback: "自分だけのタイムテーブルを作成できる！\n開始時間や色分け、MEMOも残せるよ！")
  /// 次へ
  internal static let onboardingNext = L10n.tr("Localizable", "onboarding_next", fallback: "次へ")
  /// はじめる
  internal static let onboardingStart = L10n.tr("Localizable", "onboarding_start", fallback: "はじめる")
  /// データの不整合エラーが発生しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。
  internal static let sessionErrorJsonFailedMessage = L10n.tr("Localizable", "session_error_json_failed_message", fallback: "データの不整合エラーが発生しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。")
  /// データの受信に失敗しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。
  internal static let sessionErrorNotExistHeaderMessage = L10n.tr("Localizable", "session_error_not_exist_header_message", fallback: "データの受信に失敗しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。")
  /// データの送信に失敗しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。
  internal static let sessionErrorSendFailedMessage = L10n.tr("Localizable", "session_error_send_failed_message", fallback: "データの送信に失敗しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。")
  /// セッションエラー
  internal static let sessionErrorTitle = L10n.tr("Localizable", "session_error_title", fallback: "セッションエラー")
  /// 予期せぬエラーが発生しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。
  internal static let sessionErrorUnidentifiedMessage = L10n.tr("Localizable", "session_error_unidentified_message", fallback: "予期せぬエラーが発生しました。何度も繰り返される場合はアプリを起動し直して再度実行してみてください。")
  /// アプリの特徴を見る
  internal static let settingAppOnboading = L10n.tr("Localizable", "setting_app_onboading", fallback: "アプリの特徴を見る")
  /// Aliveアプリ
  internal static let settingAppTitle = L10n.tr("Localizable", "setting_app_title", fallback: "Aliveアプリ")
  /// Live情報をメモするLive好きのためのアプリだよ！
  internal static let settingRecommendShareText = L10n.tr("Localizable", "setting_recommend_share_text", fallback: "Live情報をメモするLive好きのためのアプリだよ！")
  /// 「ALIVE」をオススメする
  internal static let settingRecommendTitle = L10n.tr("Localizable", "setting_recommend_title", fallback: "「ALIVE」をオススメする")
  /// アプリをレビューする
  internal static let settingReviewTitle = L10n.tr("Localizable", "setting_review_title", fallback: "アプリをレビューする")
  /// ?action=write-review
  internal static let settingReviewUrlQuery = L10n.tr("Localizable", "setting_review_url_query", fallback: "?action=write-review")
  /// 利用規約とプライバシーポリシー
  internal static let settingTermsOfServiceTitle = L10n.tr("Localizable", "setting_terms_of_service_title", fallback: "利用規約とプライバシーポリシー")
  /// https://tech.amefure.com/app-terms-of-service
  internal static let settingTermsOfServiceUrl = L10n.tr("Localizable", "setting_terms_of_service_url", fallback: "https://tech.amefure.com/app-terms-of-service")
  /// テキストがありません
  internal static let shareNoText = L10n.tr("Localizable", "share_no_text", fallback: "テキストがありません")
  /// シェアしたいLive情報にチェックを入れてください。
  internal static let shareNoTextAlert = L10n.tr("Localizable", "share_no_text_alert", fallback: "シェアしたいLive情報にチェックを入れてください。")
  /// TimeTableは長押しすることで削除することが可能です。
  /// 編集することはできないので削除後に新規作成してください。
  internal static let timetableAlertTitle = L10n.tr("Localizable", "timetable_alert_title", fallback: "TimeTableは長押しすることで削除することが可能です。\n編集することはできないので削除後に新規作成してください。")
  /// 更新しました。
  internal static let updateSuccessAlertTitle = L10n.tr("Localizable", "update_success_alert_title", fallback: "更新しました。")
  /// アーティスト名と
  /// ライブ名は必須入力です。
  internal static let validationAlertTitle = L10n.tr("Localizable", "validation_alert_title", fallback: "アーティスト名と\nライブ名は必須入力です。")
  /// 出演時間と
  /// アーティスト名は必須入力です。
  internal static let validationTimetableAlertTitle = L10n.tr("Localizable", "validation_timetable_alert_title", fallback: "出演時間と\nアーティスト名は必須入力です。")
  /// 無効なURLです。
  internal static let validationUrlTitle = L10n.tr("Localizable", "validation_url_title", fallback: "無効なURLです。")
  /// TOPに戻る
  internal static let watchErrorBackButton = L10n.tr("Localizable", "watch_error_back_button", fallback: "TOPに戻る")
  /// iPhoneとの通信に失敗しました。
  internal static let watchErrorText = L10n.tr("Localizable", "watch_error_text", fallback: "iPhoneとの通信に失敗しました。")
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
