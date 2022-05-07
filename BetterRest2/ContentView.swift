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
    @State private var wakeUp3 = Date.now
    @State private var wakeUp4 = Date.now
    @State private var birthday = Date.now
    @State private var pregnancyDue = Date.now
    @State private var appointment = Date.now

    var body: some View {
        Form {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                .padding()

            DatePicker("Date", selection: $wakeUp)

            DatePicker("Date 2", selection: $wakeUp2)
                .labelsHidden()

            DatePicker("Date 3", selection: $wakeUp3, displayedComponents: .date)

            DatePicker("Time", selection: $wakeUp4, displayedComponents: .hourAndMinute)

            DatePicker("Birthday", selection: $birthday, in: ...Date.now, displayedComponents: .date)

            DatePicker("Pregnancy due", selection: $pregnancyDue, in: Date.now..., displayedComponents: .date)

            DatePicker("Appointment", selection: $appointment, in: Date.now...Date.now.addingTimeInterval(6 * 86_400), displayedComponents: .date)

            Text("\(wakeUpTime(hour: 8, minute: 0))")
                .font(.caption)

            Text("\(wakeUpTime(date: wakeUp))")
        }
    }

    func wakeUpTime(hour: Int, minute: Int) -> Date {
        var components = DateComponents()

        components.hour = hour
        components.minute = minute

        return Calendar.current.date(from: components) ?? Date.now
    }

    func wakeUpTime(date: Date) -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0

        return "\(hour):\(minute)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
