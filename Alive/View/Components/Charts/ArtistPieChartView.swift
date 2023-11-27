//
//  ChartView.swift
//  Alive
//
//  Created by t&a on 2023/11/25.
//

import UIKit
import DGCharts
import SwiftUI

struct ArtistPieChartView: UIViewRepresentable {
    
    public var artistCounts: Array<(key: String, value: Int)>
    
    private let colors = [Asset.Colors.themaRed.color,
                          Asset.Colors.themaYellow.color,
                          Asset.Colors.themaGreen.color,
                          Asset.Colors.themaBlue.color,
                          Asset.Colors.themaPurple.color]
    
    func makeUIView(context: Context) -> PieChartView {
        
        // チャートビューのサイズと位置を定義
        let chartView = PieChartView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        guard artistCounts.count != 0 else {
            chartView.noDataText = "データがありません"
            chartView.noDataTextColor = .themaRed
            chartView.noDataFont = .boldSystemFont(ofSize: 15)
            return chartView
        }
        
        // チャートに渡す用の配列を定義
        var entries: [ChartDataEntry] = []
        
        // Y軸のデータリストからインデックスと値を取得し配列に格納
        for item in artistCounts {
            // X軸は配列のインデックス番号
            let entry = PieChartDataEntry(value: Double(item.value), label: item.key)
            entries.append(entry)
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "アーティストカウント円グラフ")
        
        chartView.data = PieChartData(dataSet: dataSet)
        
        // カラーリストの設定
        dataSet.colors = colors
        // グラフ内に値を表示しない
        dataSet.drawValuesEnabled = false
        dataSet.valueTextColor = .foundation
        dataSet.valueFont = .boldSystemFont(ofSize: 12)
        
        // グラフの値を％表示するかどうか
        chartView.usePercentValuesEnabled = false
        // グラフの中心まで塗りつぶす
        chartView.drawHoleEnabled = false
        // タッチでハイライトしない
        chartView.highlightPerTapEnabled = false
        chartView.rotationEnabled = false
        
        chartView.legend.horizontalAlignment = .center
        chartView.legend.enabled = false
        
        
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        
        return chartView
    }
    
    func updateUIView(_ uiView: PieChartView, context: Context) { }
    
}
