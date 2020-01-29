//
//  String+Utils.swift
//  CupcakeCorner
//
//  Created by Matthew Mohrman on 12/20/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

extension String {
    var isBlank: Bool {
        isEmpty || trimmingCharacters(in: .whitespaces).isEmpty
    }
}
