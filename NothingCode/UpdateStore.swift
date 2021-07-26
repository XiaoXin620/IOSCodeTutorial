//
//  UpdateStore.swift
//  NothingCode
//
//  Created by Sample on 2021/7/27.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    
    @Published var updates : [Update] = updateData
}
