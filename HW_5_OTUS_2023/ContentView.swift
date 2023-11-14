//
//  ContentView.swift
//  HW_5_OTUS_2023
//
//  Created by Филатов Олег Олегович on 10.11.2023.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    let store: StoreOf<SuffixFeature>

    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack {
                TextField("Введите слово", text: viewStore.binding(get: \.text, send: { .changeWord($0) }))
                    .padding(10)
                    .border(.black)
                    .padding(10)
                Picker("", selection: viewStore.binding(get: \.statePicker, send: { .changeTypePicker($0) })) {
                    ForEach(SelectForPicker.allCases, id: \.self) { item in
                        Text(item.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                Text(viewStore.state.suffixSort == .ASC ? "По возрастанию" :  "По убыванию")
                List(viewStore.state.statePicker == .all ? viewStore.state.sortedSuffixes : viewStore.state.topSortedSuffixes, id: \.self) { suffix in
                    HStack{
                        Text(suffix)
                        Spacer()
                        Text(String(viewStore.state.suffixes[suffix] ?? 0))
                    }
                }
                .listStyle(.plain)
                
                Button {
                    viewStore.send(.changeSort(viewStore.suffixSort))
                } label: {
                    Text(viewStore.state.suffixSort == .ASC ? "По убыванию" : "По возрастанию")
                }.opacity(viewStore.statePicker == .top ? 0 : 1)
                    .buttonStyle(.bordered)

            }
        }

    }
}
