//
//  String+Extension.swift
//  Mastermind
//
//  Created by Ramcharan Reddy Gaddam on 10/08/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import Foundation

extension String {
    
    func charAt(index: Int) -> Character {
        return Array(self)[index]
    }
    
    static func generateRandomWord(from fromLetters:String ,ofLength length:Int) -> String {
        return String((0..<length).map({_ in
            (fromLetters.randomElement() ?? Character(""))
        }))
    }
}
