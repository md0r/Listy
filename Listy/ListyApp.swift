//
//  ListyApp.swift
//  Listy
//
//  Created by Mihai Dorhan on 22.02.2023.
//

import SwiftUI

@main
struct ListyApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
