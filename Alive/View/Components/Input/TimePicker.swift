//
//  TimePicker.swift
//  Alive
//
//  Created by t&a on 2023/11/27.
//

import SwiftUI

struct TimePicker: View {
    
    // MARK: - Receive
    @Binding var selectedTime: Date?
    public let title: String
    
    // MARK: - Utility
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - View
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    private let hours = Array(0...23)
    private let minutes = Array(0...60)
    
    var body: some View {
        
        HStack {
            
            Text(title + L10n.inputTimePickerExtension)
                .padding(.leading, 30)
            
            Spacer()
            
            Menu {
                ForEach(hours, id: \.self) { hour in
                    Button {
                        self.hour = hour
                    } label: {
                        Text("\(hour)")
                    }
                }
            } label: {
                Text("\(hour)")
                    .padding()
                    .frame(width: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.white, lineWidth: 1)
                    )
            }
            
            Text("：")
            
            Menu {
                ForEach(minutes, id: \.self) { minute in
                    Button {
                        self.minute = minute
                    } label: {
                        Text(minute < 10 ? "0\(minute)" :  "\(minute)")
                    }
                }
            } label: {
                Text(minute < 10 ? "0\(minute)" :  "\(minute)")
                    .padding()
                    .frame(width: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.white, lineWidth: 1)
                    )
            }.padding(.trailing)
            
        }.foregroundStyle(.white)
            .onChange(of: hour) { _ in
                selectedTime = dateFormatManager.getDate(hour: hour, minute: minute)
            }
            .onChange(of: minute) { _ in
                selectedTime = dateFormatManager.getDate(hour: hour, minute: minute)
            }
            .onAppear {
                if let time = selectedTime {
                    let timeStr = dateFormatManager.getTimeString(date: time)
                    hour = String(timeStr.prefix(2)).toNum()
                    minute = String(timeStr.suffix(2)).toNum()
                }
            }
    }
}

#Preview {
    TimePicker(selectedTime: Binding.constant(Date()), title: "TITLE")
}
