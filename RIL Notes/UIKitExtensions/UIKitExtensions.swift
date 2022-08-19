//
//  UIKitExtensions.swift
//  RIL Notes
//
//  Created by Srikanth Gimka on 17/08/22.
//

import UIKit
import SwiftUI


extension UIApplication {
    
    func addRootController(view: AnyView){
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        // Use a UIHostingController as window root view controller.
        
        if let windowScene = scene, let windowScenedelegate = windowScene.delegate as? SceneDelegate {
           let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView:view)
           windowScenedelegate.window = window
           window.makeKeyAndVisible()
        }
    }
}


