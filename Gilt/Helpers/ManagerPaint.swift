//
//  ManagerPaint.swift
//  Gilt
//
//  Created by Lucas Correa on 13/08/2017.
//  Copyright © 2017 SiriusCode. All rights reserved.
//

import Foundation

struct ManagerPaint {
    let paintShop: PaintShop
    
    // MARK: - Public Functions
    func mixColors() -> String {
        var solution: [Int: Finish] = [:]
        let sortedCustomers = paintShop.customers.sorted { $0.paintPreferences.count < $1.paintPreferences.count }
        
        for customer in sortedCustomers {
            
            // if the customer has more paint preferences, the method below will also
            // fill a list with candidate paints and return a fixed paint or null
            guard let paint = candidateFor(customer, solution: solution) else {
                
                if customer.satisfied(with: solution) {
                    // there is a paint already fixed which is good for this customer,
                    // nothing left to do, customer is already satisfied
                    continue
                } else {
                    return Constants.NoSolutionExists
                }
            }
            
            solution[paint.color] = paint.finish
        }
        
        return complete(solution)
    }
    
    // MARK: - Private Functions
    fileprivate func candidateFor(_ customer: Customer, solution: [Int: Finish]) -> Paint? {
        
        // if the customer has only one paint preference, that must be in the output
        if customer.paintPreferences.count == 1 {
            guard let paint = customer.paintPreferences.first else {
                return nil
            }
            
            if let finish = solution[paint.color], finish != paint.finish {
                return nil
            } else {
                return paint
            }
        } else {
            if customer.paintPreferences.filter({ solution[$0.color] == $0.finish }).count > 0 {
                return nil
            }
            
            let paints = customer.paintPreferences.filter { solution[$0.color] == nil }
            return paints.filter { $0.finish == .Gloss }.first ?? paints.first
        }
    }
    
    fileprivate func complete(_ solution: [Int: Finish]) -> String {
        // Get result final 
        let output = (1...paintShop.numberOfColors).map { solution[$0] ?? .Gloss }
        //Add separator with space
        return output.map { $0.rawValue }.joined(separator: " ")
    }
}
