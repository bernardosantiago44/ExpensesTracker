//
//  RecordSheet.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 19/11/24.
//

import SwiftUI

internal enum RecordSheet: SheetEnum {
    case createRecord
    case editRecord
    
    public var id: String {
        switch self {
            case .createRecord: return "createRecord"
            case .editRecord: return "editRecord"
        }
    }
    
    @ViewBuilder
    func view(coordinator: SheetCoordinator<RecordSheet>) -> some View {
        switch self {
        case .createRecord:
            // New Record Form
            EmptyView()
        case .editRecord:
            // Edit record form
            EmptyView()
        }
    }
}
