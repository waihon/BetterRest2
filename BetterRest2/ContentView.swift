//
//  ContentView.swift
//  BetterRest2
//
//  Created by Waihon Yew on 05/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0

    var body: some View {
        Stepper("\(sleepAmount) hours", value: $sleepAmount, in: 4...12)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
