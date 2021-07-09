//
//  AppTabNavigation.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/14/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import SwiftUI

// MARK: - AppTabNavigation

struct AppTabNavigation: View {
    @State private var selection: Tab = .menu

    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill").accessibility(label: Text("Home"))
            }
            .tag(Tab.menu)
            
            NavigationView {
                RatingView()
            }
            .tabItem {
                Label("My Reviews", systemImage: "star.fill").accessibility(label: Text("My Reviews"))
            }
            .tag(Tab.favorites)
            
            NavigationView {
                EventsView()
            }
            .tabItem {
                Label("Map", systemImage: "map").accessibility(label: Text("Map"))
            }
            .tag(Tab.recipes)
        }
    }
}

// MARK: - Tab

extension AppTabNavigation {
    enum Tab {
        case menu
        case favorites
        case rewards
        case recipes
    }
}

// MARK: - Previews

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
    }
}
