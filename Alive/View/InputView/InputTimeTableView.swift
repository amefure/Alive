//
//  InputTimeTableView.swift
//  Alive
//
//  Created by t&a on 2023/11/23.
//

import SwiftUI

struct InputTimeTableView: View {
    
    // MARK: - ViewModel
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - View
    public let live: Live
    @State private var time: Date? = nil
    @State private var artist: String = ""
    @State private var memo: String = ""
    @State private var color: TimeTableColor = .yellow
    @State private var validationAlert: Bool = false
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
            
            TimePicker(selectedTime: $time, title:L10n.liveOpeningTime)
            CustomInputView(text: $artist, imgName: "music.mic", placeholder: L10n.liveArtist)
            CustomInputView(text: $memo, imgName: "note", placeholder: L10n.liveMemo)
            
            HStack(spacing: 20) {
                ForEach(TimeTableColor.allCases, id: \.self) { color in
                    Button {
                        self.color = color
                    } label: {
                        Text("")
                            .frame(width: 30, height: 30)
                            .background(color.color)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(self.color == color ? .white : .opacityGray, lineWidth: 2)
                            )
                        
                    }
                }
            }
            
            Button {
                if let time = time {
                    let new = TimeTable()
                    new.time = time
                    new.artist = artist
                    new.memo = memo
                    new.color = color
                    repository.addTimeTable(id: live.id, newTimeTable: new)
                    dismiss()
                } else {
                    validationAlert = true
                }
                
            } label: {
                Text(L10n.entryTimetableButton)
                    .padding(.vertical, 7)
                    .frame(width: 100)
                    .foregroundStyle(.themaYellow)
                    .overlay{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(style: StrokeStyle(lineWidth: 1))
                            .frame(width: 100)
                            .foregroundStyle(.themaYellow)
                    }.padding(.top , 20)
            }
            
            Spacer()
        }.background(.foundation)
            .alert(L10n.validationTimetableAlertTitle, isPresented: $validationAlert) {
                Button("OK") {
                }
            }
    }
}

#Preview {
    InputTimeTableView(live: Live.demoLive)
}
