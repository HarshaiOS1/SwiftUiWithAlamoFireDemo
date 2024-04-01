//
//  ApplianceModel.swift
//  DemoAlamofireWithAsyncAwait
//
//  Created by Krishnappa, Harsha on 28/03/2024.
//

import Foundation

struct ApplianceModel: Identifiable, Codable {
    let id: Int
    let uid: String
    let brand: String
    let equipment: String
}
