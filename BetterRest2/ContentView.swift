//
//  ContentView.swift
//  BetterRest2
//
//  Created by Waihon Yew on 05/05/2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)

                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()

                Text("Desired amount of sleep")
                    .font(.headline)

                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)

                Text("Daily coffee intake")
                    .font(.headline)

                Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)

            }
            .padding()
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    func calculateBedtime() {
        do {
            // The configuration is here in case we need to enable a handful
            // of what are fairly obscure options.
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            // Extract hour and minute from wakeUp which contains date and time
            // among others.
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            // Convert our values to Double to be compatible with that of the
            // model and feed into Core ML and see what comes out.
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            // Compute sleep time from wake up datetime and the actual amount
            // of sleep in seconds (returned by the prediction).
            let sleepTime = wakeUp - prediction.actualSleep

            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            // Using Core ML can throw errors in two places:
            // 1. Loading the model
            // 2. When we ask for preductions
            alertTitle = "Error"
            alertMessage = "SOrry, there was a problem calculating your bedtime."
        }

        showingAlert = true
    }
}

struct OverviewContentView: View {
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
            Section {
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    .padding()
            } header: {
                Text("Stepper")
            }

            Section {
                DatePicker("Date", selection: $wakeUp)

                DatePicker("Date 2", selection: $wakeUp2)
                    .labelsHidden()

                DatePicker("Date 3", selection: $wakeUp3, displayedComponents: .date)

                DatePicker("Time", selection: $wakeUp4, displayedComponents: .hourAndMinute)

                DatePicker("Birthday", selection: $birthday, in: ...Date.now, displayedComponents: .date)

                DatePicker("Pregnancy due", selection: $pregnancyDue, in: Date.now..., displayedComponents: .date)

                DatePicker("Appointment", selection: $appointment, in: Date.now...Date.now.addingTimeInterval(6 * 86_400), displayedComponents: .date)
            } header: {
                Text("Date Picker")
            }

            Section {
                Text("\(wakeUpTime(hour: 8, minute: 0))")
                    .font(.caption)

                Text("\(wakeUpTime(date: wakeUp))")

                Text(wakeUp, format: .dateTime.hour().minute())

                Text(wakeUp, format: .dateTime.day().month().year())

                Text(wakeUp.formatted(date: .long, time: .shortened))

                Text(wakeUp.formatted(date: .complete, time: .omitted))

                Text(wakeUp.formatted(date: .omitted, time: .complete))
            } header: {
                Text("Date Manipulation")
            }
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
