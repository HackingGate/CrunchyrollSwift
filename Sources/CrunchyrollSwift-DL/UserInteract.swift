//
//  UserInteract.swift
//  
//
//  Created by HG on 2020/12/28.
//

import Foundation

struct UserInteract {
    public static func chooseNumber(from range: Range<Int>) -> Int {
        var validateChoise: Int?
        repeat {
            let keyboard = FileHandle.standardInput
            let inputData = keyboard.availableData
            guard let inputString = String(data: inputData, encoding: .utf8) else {
                print("Cannot read input")
                continue
            }
            guard let choise = Int(inputString.trimmingCharacters(in: .whitespacesAndNewlines)) else {
                print("Please type a number")
                continue
            }
            if !range.contains(choise - 1) {
                print("Choice is not in range \(range)")
                continue
            }
            validateChoise = choise - 1
        } while (validateChoise == nil)

        return validateChoise!
    }
}
