//
//  ARUtil.swift
//  XYARKit
//
//  Created by user on 4/29/22.
//

import Foundation
struct ARUtil {
    static var bundle: Bundle {
        guard let path = Bundle.main.path(forResource: "XYARModule", ofType: "bundle") else {
            fatalError("资源错误")
        }
        guard let bundle = Bundle(path: path) else {
            fatalError("资源错误")
        }
        return bundle
    }
}
