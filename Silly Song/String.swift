//
//  String.swift
//  Silly Song
//
//  Created by Gunjan Bhasin on 1/31/18.
//  Copyright © 2018 mindbody. All rights reserved.
//
import Foundation

extension String {
    
    /*
     * add capitalization for given strings
     */
    func capitalizingFirstLetter() -> String {
        
        if self.isEmpty { return self }
        
        let first = String(self.characters.prefix(1)).capitalized
        let other = String(self.characters.dropFirst())
        
        return first + other
    }
    
    func index(from: Int) -> Index {
        
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        
        let fromIndex = index(from: from)
        
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        
        let toIndex = index(from: to)
        
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        
        return substring(with: startIndex..<endIndex)
    }
}
