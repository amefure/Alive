//
//  ArtistBarChartView.swift
//  Alive
//
//  Created by t&a on 2023/11/26.
//

import UIKit
import DGCharts
import SwiftUI

struct ArtistBarChartView: UIViewRepresentable {
    
    public var artistCounts: Array<(key: String, value: Int)>
    
    private let colors = [Asset.Colors.themaRed.color,
                          Asset.Colors.themaYellow.color,
                          Asset.Colors.themaGreen.color,
                          Asset.Colors.themaBlue.color,
                          Asset.Colors.themaPurple.color]
    
    func makeUIView(context: Context) -> BarChartView {
        // チャートビューのサイズと位置を定義
        let chartView = BarChartView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        guard artistCounts.count != 0 else {
            chartView.noDataText = L10n.chartsNoData
            chartView.noDataTextColor = .themaRed
            chartView.noDataFont = .boldSystemFont(ofSize: 15)
            return chartView
        }
        
        // チャートに渡す用の配列を定義
        var entries: [ChartDataEntry] = []
        var keys: [String] = []
        
        // Y軸のデータリストからインデックスと値を取得し配列に格納
        for (index, item) in artistCounts.reversed().enumerated() {
            // X軸は配列のインデックス番号
            let entry = BarChartDataEntry(x: Double(index), y: Double(item.value))
            keys.append(String(item.key))
            entries.append(entry)
        }
        
        let dataSet = BarChartDataSet(entries: entries, label:  L10n.chartsBarName)
        
        chartView.data = BarChartData(dataSet: dataSet)
        
        // 下部にラベルを表示
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: keys)
        
        dataSet.colors = colors
        // グラフ内に値を表示しない
        dataSet.drawValuesEnabled = false
        dataSet.valueTextColor = .foundation
        dataSet.valueFont = .boldSystemFont(ofSize: 12)
        
        // タッチでハイライトしない
        chartView.highlightPerTapEnabled = false
        // ラベルに位置を中央に
        chartView.legend.horizontalAlignment = .center
        
        // グラフ名ラベルを非表示
        chartView.legend.enabled = false
        // Y軸右側ラベルを非表示
        chartView.rightAxis.enabled = false
        
        // x軸のラベルをbottomに表示
        chartView.xAxis.labelPosition = .bottom
        // x軸のラベル数をデータの数にする
        chartView.xAxis.labelCount = entries.count - 1
        
        // y軸ラベルの表示個数
        chartView.leftAxis.labelCount = 5
        
        // Y軸ラベルの変化幅を調整1単位に
        chartView.leftAxis.granularity = 1
        
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        
        chartView.notifyDataSetChanged()
        return chartView
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) { }
    
}
