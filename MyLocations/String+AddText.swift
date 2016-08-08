//
//  String+AddText.swift
//  MyLocations
//
//  Created by Sean Perez on 8/8/16.
//  Copyright © 2016 SeanPerez. All rights reserved.
//

import Foundation

extension String {
    mutating func addText(text: String?, withSeparator separator: String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}