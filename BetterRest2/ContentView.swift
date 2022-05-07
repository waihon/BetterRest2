//
//  ContentView.swift
//  BetterRest2
//
//  Created by Waihon Yew on 05/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    @State private var wakeUp2 = Date.now

    var body: some View {
        Form {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                .padding()

            DatePicker("Date", selection: $wakeUp)

            DatePicker("Date 2", selection: $wakeUp2)
                .labelsHidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
