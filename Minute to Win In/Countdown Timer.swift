//
//  CustomNumberPad.swift
//  Freed Leaderboard
//
//  Created by Noah Smith on 1/8/26.
//

import SwiftUI

struct CustomNumberPad: View {
    @Binding var roundValue: Int
    var onAutoAdd = {}
    let count = 60
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                self.onAutoAdd()
            } label: {
                Text("\(roundValue)")
                    .font(.system(size: 900))
                    .foregroundStyle(Color.accent)
            }
            .buttonStyle(.borderless)
        
            Spacer()
//            Button(roundValue >= count ? "Start" : "Stop") {
//                
//            }
        }
    }
    
    func onAutoAdd(_ callback: @escaping () -> ()) -> some View {
        CustomNumberPad(roundValue: self.$roundValue, onAutoAdd: callback)
    }
}


//#Preview {
//    struct PreviewWrapper: View {
//        @State private var value: String = "0"
//        @State private var roundValue: Int = 0
//        var body: some View {
//            CustomNumberPad(value: $value, roundValue: $roundValue)
//        }
//    }
//    return PreviewWrapper()
//}
