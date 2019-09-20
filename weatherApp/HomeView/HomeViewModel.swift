//
//  HomeViewModel.swift
//  weatherApp
//
//  Created by Shilpa Kumari on 12/09/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import Foundation


protocol ShowErrorProtocol : class {
    func showErrorMessage()
}
class HomeViewModel {
    weak var delegate : ShowErrorProtocol?
    func checkEmptyLocation(location : String){
        if location.isEmpty{
            self.delegate?.showErrorMessage()
        }
    }
}
