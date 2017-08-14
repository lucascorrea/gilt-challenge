//
//  Customer.swift
//  Gilt
//
//  Created by Lucas Correa on 13/08/2017.
//  Copyright © 2017 SiriusCode. All rights reserved.
//

import Foundation

struct Customer {
    
    // MARK: - Properties
    var paintPreferences = [Paint]()
    
    //MARK: - Initializers
    init(string: String) throws {
        let colors = string.components(separatedBy: CharacterSet.whitespaces)
        guard colors.count > 1, colors.count%2 == 0 else {
            //the line was either empty or contained
            throw Errors.invalidColorPreferences
        }
        
        for index in stride(from:0, to: colors.count, by: 2) {
            guard let color = Int(colors[index]) else {
                throw Errors.invalidColorPreferences
            }
            
            guard let finish = Finish(rawValue: colors[index+1]) else {
                throw Errors.invalidFinish
            }
            
            add(color, withFinish: finish)
        }
    }
    
    //MARK: - Private Functions
    fileprivate mutating func add(_ paint: Paint) {
        paintPreferences.insert(paint, at: 0)
    }
    
    fileprivate mutating func add(_ color: Int, withFinish finish: Finish? = .Gloss){
        add(Paint(color: color, finish: finish!))
    }
    
    
    //MARK: - Public Functions
    func satisfied(with solution: [Int: Finish]) -> Bool {
        for paint in paintPreferences {
            if solution[paint.color] == paint.finish {
                return true
            }
        }
        return false
    }
}
