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

    let dataBaseService: DataBasesServiceProtocol = SDDataBaseService()
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(dataBaseService))
        }
    }
}
