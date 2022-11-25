//
//  ModuleBuilder.swift
//  MVP
//
//  Created by Aleksei Kevra on 21.11.22.
//

import UIKit

enum ModuleBuilder {
    static func buildModule() -> UIViewController {
        let networkService = NetworkService()
        let presenter = MainPresenter(networkService: networkService)
        let view = MainViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
