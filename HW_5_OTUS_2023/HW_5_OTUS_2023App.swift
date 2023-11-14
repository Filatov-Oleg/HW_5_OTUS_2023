//
//  HW_5_OTUS_2023App.swift
//  HW_5_OTUS_2023
//
//  Created by Филатов Олег Олегович on 10.11.2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct HW_5_OTUS_2023App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: SuffixFeature.State(), reducer: {
                SuffixFeature()
            }))
        }
    }
}
