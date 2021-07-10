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
                ForEach(self.calendar.calendars, id: \.self) { calendar in
                    
                    Text("calendar : \(calendar.title)")
                }
            }.onAppear{
                DispatchQueue.main.async {
                    self.calendar.requestAccessCalendars()
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
    
//    @Published var events: [EKEvent] = []
//    @Published var error: Error? = nil
    
    private var eventStore: EKEventStore
    @Published var calendars: [EKCalendar] = []
    
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
    
//    func fetchCalendarEvents() {
//        let eventStore = EKEventStore()
//    //    let calendars = eventStore.calendars(for: .event)
//
//        eventStore.requestAccess(to: .events, completion:
//            {(granted: Bool, error: Error?) -> Void in
//                if granted {
//                  self.insertEvent(store: eventStore)
//                } else {
//                  print("Access denied")
//                }
//          })
//
//
//        store.requestAccess(to: EKEntityType.event, completion:{(granted, error) in
//            if let error = error {
//                print("failed to request access", error)
//                return
//            }
//
//            if granted {
//
//                do {
//
//                } catch let error {
//                    print("Failed to enumerate events", error)
//                }
//            } else {
//                print("access denied")
//            }
//        }
//    }

    
//    // MARK: Fetech Events from Calendar
//    func fetchEventsFromCalendar(calendarTitle: String) -> Void {
//
//        //PGAEventsCalendar
//        for calendar:EKCalendar in calendars {
//
//            if calendar.title == calendarTitle {
//
//            let selectedCalendar = calendar
//            let startDate = NSDate(timeIntervalSinceNow: -60*60*24*180)
//            let endDate = NSDate(timeIntervalSinceNow: 60*60*24*180)
//            let predicate = eventStore.predicateForEvents(withStart: startDate as Date, end: endDate as Date, calendars: [selectedCalendar])
//            addedEvents = eventStore.events(matching: predicate) as [EKEvent]
//
//            print("addedEvents : \(addedEvents)")
//
//            }
//        }
//
//    }
}
