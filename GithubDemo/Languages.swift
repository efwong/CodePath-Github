//
//  Languages.swift
//  GithubDemo
//
//  Created by Edwin Wong on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation

enum LanguageSettings:String{
    case enableLanguagesOption = "Filter by Language"
    case javascript = "Javascript", cpp = "Cpp", ruby = "Ruby", python = "Python", objectivec = "Objective-C", swift = "swift"
    
    // get GitHub recognizable name
//    var rawkey : String{
//        get{
//            return self.rawValue
//        }
//    }
    
    static let allLanguages = [javascript, cpp, ruby, python, objectivec, swift]
}
