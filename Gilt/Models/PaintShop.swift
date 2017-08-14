//
//  PaintShop.swift
//  Gilt
//
//  Created by Lucas Correa on 13/08/2017.
//  Copyright © 2017 SiriusCode. All rights reserved.
//

import Foundation

struct PaintShop {
    
    // MARK: - Properties
    let numberOfColors: Int
    let customers: [Customer]
    
    //MARK: - Initializers
    init(string: String) throws {
        var lines = string.components(separatedBy: .newlines).filter { !$0.isEmpty }
        
        guard lines.count > 1 else {
            throw Errors.invalidFileFormat
        }
        
        guard let numberOfColors = Int(lines.remove(at: 0)) else {
            throw Errors.numberOfColorsNotProvided
        }
        
        let customers = try lines.map { try Customer(string: $0) }
        
        self.numberOfColors = numberOfColors
        self.customers = customers
    }
}
