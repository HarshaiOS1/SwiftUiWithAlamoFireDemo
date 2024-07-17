//
//  Extensions.swift
//  DemoAlamofireWithAsyncAwait
//
//  Created by Krishnappa, Harsha on 17/07/2024.
//


import SwiftUI
/*
    convert view to viewcontroller for snapshot testing
 */
extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        vc.forceRender()
        return vc
    }
}

extension UIHostingController {
  fileprivate func forceRender() {
    _render(seconds: 5)
  }
}
