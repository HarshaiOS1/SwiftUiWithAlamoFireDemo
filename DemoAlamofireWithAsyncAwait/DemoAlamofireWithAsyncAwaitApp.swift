//
//  DemoAlamofireWithAsyncAwaitApp.swift
//  DemoAlamofireWithAsyncAwait
//
//  Created by Krishnappa, Harsha on 28/03/2024.
//

import SwiftUI

@main
struct DemoAlamofireWithAsyncAwaitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewViewModel(applianceService: AppliancesAPI()))
        }
    }
}
