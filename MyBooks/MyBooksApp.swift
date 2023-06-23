//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import SwiftUI

@main
struct MyBooksApp: App {
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.environment["XCTestBundlePath"] != nil {
                Text("Run Unit Tests")
            } else {
                ContentView()
            }
        }
    }
}
