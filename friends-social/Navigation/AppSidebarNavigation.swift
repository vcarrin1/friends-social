//
//  AppSidebarNavigation.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/14/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//


import SwiftUI

struct AppSidebarNavigation: View {

    enum NavigationItem {
        case home
        case ratings
        case friends
        case map
        case calendar
    }

    @EnvironmentObject private var model: AddressData
    @State private var selection: NavigationItem? = .home
    @State private var presentingRewards = false
    
    var sidebar: some View {
        List(selection: $selection) {
            NavigationLink(destination: HomeView(), tag: NavigationItem.home, selection: $selection) {
                Label("Home", systemImage: "house.fill").accessibility(label: Text("Home"))
            }
            .tag(NavigationItem.home)
            
            NavigationLink(destination: RatingView(), tag: NavigationItem.ratings, selection: $selection) {
                Label("My Ratings", systemImage: "star.fill").accessibility(label: Text("My Ratings"))
            }
            .tag(NavigationItem.ratings)
        
            NavigationLink(destination: CalendarView(), tag: NavigationItem.calendar, selection: $selection) {
                Label("Calendar", systemImage: "calendar.badge.clock").accessibility(label: Text("Calendar"))
            }
            .tag(NavigationItem.friends)
            
        }
        .listStyle(SidebarListStyle())
    }
    
    var body: some View {
        NavigationView {
            sidebar
            
            HomeView()
        }
    }

}

struct AppSidebarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSidebarNavigation()
            .environmentObject(AddressData())
    }
}
