//
//  SuffixFeature.swift
//  HW_5_OTUS_2023
//
//  Created by Филатов Олег Олегович on 13.11.2023.
//

import Foundation
import ComposableArchitecture

enum SuffixSort {
    case ASC
    case DESC
}

enum SelectForPicker : String, CaseIterable {
    case all = "Все"
    case top = "Топ 3"
}

struct SuffixFeature: Reducer {
    
    struct State: Equatable {
        var text: String = ""
        var sortedSuffixes: [String] = .init()
        var suffixes : [String : Int] = .init()
        var topSortedSuffixes : [String] = .init()
        var suffixSort: SuffixSort = .ASC
        var statePicker: SelectForPicker = .all
    }
    
    enum Action: Equatable {
        case changeWord(String)
        case setSuffixes([String: Int])
        case changeSort(SuffixSort)
        case changeTypePicker(SelectForPicker)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .changeWord(let text):
                enum CancelID { case search }
                state.text = text
                return .run { send in
                    let words = text.split(separator: " ")
                    let suffixArray = words.flatMap{ SuffixSequence(word: String($0)).map { $0 } }
                    let suffixes = suffixArray.reduce(into: [:]) { partialResult, str in
                        partialResult[str as! String, default: 0] += 1
                    }
                    await send(.setSuffixes(suffixes))
                }
                .debounce(id: CancelID.search, for: 0.5, scheduler: DispatchQueue.main)
            case .setSuffixes(let suffixes):
                state.suffixes = suffixes
                state.sortedSuffixes = suffixes.keys.map( {$0} ).sorted(by: <)
                return .none
            case .changeSort(let typeSort):
                switch typeSort {
                case .ASC:
                    state.suffixSort = .DESC
                    state.sortedSuffixes.sort(by: >)
                case .DESC:
                    state.suffixSort = .ASC
                    state.sortedSuffixes.sort(by: <)
                }
                return .none
            case .changeTypePicker(let statePicker):
                switch statePicker {
                case .all:
                    state.statePicker = .all
                case .top:
                    state.statePicker = .top
                    let topSuffixes = state.suffixes.filter{$0.key.count == 3}
                    state.topSortedSuffixes = topSuffixes.keys.map( {$0} ) .sorted(by: <)
                }
                return .none
            }
        }
    }
}
