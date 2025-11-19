//
//  PrintDebug.swift
//  TaskTracker
//
//  Created by Tihitinaw Buzuwek on 20/10/2025.
//

import Foundation

class PrintDebug {
    static func printDebug<T>(_ message: T,function: StaticString = #function, line: UInt = #line) {
    #if DEBUG
        print("\(message) : \(function):\(line)")
    #endif
    }
}
