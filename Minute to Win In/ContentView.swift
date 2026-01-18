//
//  ContentView.swift
//  Minute to Win In
//
//  Created by Isaac D2 on 1/17/26.
//

import SwiftUI
import ConfettiSwiftUI

struct ContentView: View {
    @State private var trigger: Int = 0
    @State var task: Task<Void, Never>? = nil  // reference to the task
    @State private var countdown: Int = 60
    @State private var isCountingDown: Bool = false
    @FocusState var buttonFocus: Bool
    let count = 60
    
    var body: some View {
        VStack {
            Spacer()
            CustomNumberPad(
                roundValue: Binding(get: { countdown }, set: { countdown = $0 })
            )
            .onAutoAdd {
                isCountingDown.toggle()
                if isCountingDown {
                    self.task?.cancel()
                    self.task = Task {
                        do {
                            while countdown > 0 {
                                try await Task.sleep(nanoseconds: 1_000_000_000)
                                countdown -= 1
                            }
                            trigger += 1
                            isCountingDown = false
                            try await Task.sleep(nanoseconds: 10_000_000_000)
                            countdown = count
                        } catch is CancellationError {
                            print("Task was cancelled")
                        } catch {
                            print("ooops! \(error)")
                        }
                    }
                } else {
                    self.task?.cancel()
                    countdown = count
                }
            }
            .confettiCannon(trigger: $trigger, num: 500, confettiSize: 35.0, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 1000)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(countdown > 0 ? Color.background : Color.accent)
    }
}

#Preview {
    ContentView()
}
