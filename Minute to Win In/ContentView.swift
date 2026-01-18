//
//  ContentView.swift
//  Minute to Win In
//
//  Created by Isaac D2 on 1/17/26.
//

import SwiftUI

struct ContentView: View {
    @State var task: Task<Void, Never>? = nil  // reference to the task
    @State private var countdown: Int = 60
    @State private var isCountingDown: Bool = false
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
                            isCountingDown = false
                            try await Task.sleep(nanoseconds: 5_000_000_000)
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
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(countdown > 0 ? Color.background : Color.accent)
    }
    
//    func doCountdown() {
//        self.task?.cancel()
//        print("Entered function")
//        while countdown > 0 {
//            print("Running countdown: \(countdown)")
//            self.task = Task {
//                do {
//                    print("Starting timer")
//                    try await Task.sleep(nanoseconds: 1_000_000_000)
//                    print("Finished timer")
//                    countdown = countdown - 1
////                    countdown -= 1
////                    print("Removed one, now at \(countdown)")
//                } catch is CancellationError {
//                    print("Task was cancelled")
//                } catch {
//                    print("ooops! \(error)")
//                }
//            }
//        }
//    }
}

#Preview {
    ContentView()
}
