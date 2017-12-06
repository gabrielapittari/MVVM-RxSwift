//
//  Coordinator.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 17/10/2017.
//

import Foundation
import UIKit


class Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}
