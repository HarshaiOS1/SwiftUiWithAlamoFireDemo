//
//  DemoAlamofireWithAsyncAwaitTests.swift
//  DemoAlamofireWithAsyncAwaitTests
//
//  Created by Krishnappa, Harsha on 28/03/2024.
//

import XCTest
import SnapshotTesting
@testable import DemoAlamofireWithAsyncAwait

final class DemoAlamofireWithAsyncAwaitTests: XCTestCase {
    
    func testContentView() {
        let service = MockApplianceServices(mockResponse: nil)
        let viewmodel = ContentViewViewModel(applianceService: service)
        let contentView = ContentView(viewModel: viewmodel)
        assertSnapshot(of: contentView.toVC(), as: .image)
    }
    
    //revist test case
    func testContentViewWithData() {
        let mockdata = [ApplianceModel(id: 123, uid: "121212", brand: "test", equipment: "equipment"), ApplianceModel(id: 55123, uid: "12121212", brand: "23test", equipment: "asdfaequipment")]
        let service = MockApplianceServices(mockResponse: mockdata)
        let viewmodel = ContentViewViewModel(applianceService: service)
        let contentView = ContentView.init(viewModel: viewmodel)
        sleep(5)
        assertSnapshot(of: contentView.toVC(), as: .image)
    }
}

struct MockApplianceServices: ApplianceServices {
    var mockResponse: [ApplianceModel]?
    func fetchAppliance(url: String) async -> [ApplianceModel]? {
        return mockResponse
    }
}
