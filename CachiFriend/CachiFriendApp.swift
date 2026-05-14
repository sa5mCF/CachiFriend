//
//  CachiFriendApp.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 28/03/26.
//

import SwiftUI
import SwiftData

@main
struct CachiFriendApp: App {

    let dataBaseService: DataBasesServiceProtocol
    
    init() {
        if ProcessInfo.processInfo.arguments.contains("-UITests") {
            self.dataBaseService = MockDataBaseService()
        } else {
            self.dataBaseService = SDDataBaseService()        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(dataBaseService))
        }
    }
}
