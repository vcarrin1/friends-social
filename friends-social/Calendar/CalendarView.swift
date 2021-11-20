//
//  CalendarManager.swift
//  friends-social
//
//  Created by Valentina Carrington on 7/10/21.
//  Copyright © 2021 Valentina Carrington. All rights reserved.
//

import SwiftUI
import EventKit
import EventKitUI

struct CalendarView: View {
    
    @EnvironmentObject var calendar: CalendarEvents

    var body: some View {
        VStack {
            Text("Calendar")
            List {
                ForEach(self.calendar.events, id: \.self) { event in
                    
                    Text("event : \(event.title) \(event.startDate)")
                }
            }.onAppear{
                DispatchQueue.main.async {
                    self.calendar.requestAccessCalendars()
                    self.calendar.fetchEventsFromCalendar(calendarTitle: "Calendar")
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(CalendarEvents())
    }
}

class CalendarEvents: NSObject, ObservableObject {
    
    private var eventStore: EKEventStore
    @Published var calendars: [EKCalendar] = []
    @Published var events: [EKEvent] = []
    
    override init() {
        eventStore = EKEventStore()
    }
    
   func requestAccessCalendars() {
        eventStore.requestAccess(to: .event) { [weak self] (accessGranted, error) in
            if accessGranted {
                self?.eventStore = EKEventStore() // <- second instance
                self?.eventStore.refreshSourcesIfNecessary()

                self?.loadCalendars()
            }
        }
    }

    private func loadCalendars() {
        let cals = eventStore.calendars(for: .event)
        for c in cals {
            if c.allowsContentModifications { // without birthdays, holidays etc'...
                calendars.append(c)
            }
        }
    }

    // MARK: Fetech Events from Calendar
    func fetchEventsFromCalendar(calendarTitle: String) -> Void {

        //PGAEventsCalendar
        for calendar:EKCalendar in calendars {

            if calendar.title == calendarTitle {

                let selectedCalendar = calendar
                let startDate = NSDate(timeIntervalSinceNow: -60*60*24*180)
                let endDate = NSDate(timeIntervalSinceNow: 60*60*24*180)
                let predicate = eventStore.predicateForEvents(withStart: startDate as Date, end: endDate as Date, calendars: [selectedCalendar])
                events = eventStore.events(matching: predicate) as [EKEvent]

                print("addedEvents : \(events)")

            }
        }

    }
}
