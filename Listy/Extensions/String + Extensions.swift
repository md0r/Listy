//
//  String + Extensions.swift
//  Listy
//
//  Created by Mihai Dorhan on 22.02.2023.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
