
//
//  companyModel.swift
//  FHCreative
//
//  Created by Admin on 25/10/2019.
//  Copyright © 2019 MontiRed. All rights reserved.
//

import Foundation

struct Company: Codable {
    let addedByID : String //Foreign key to users
    let companyLogo : URL
    let companyName : String
    let companyTel : Int
    let companyEmail: String
    let companyTown : String
    let companyCity : String
    let companyCountry : String
    
    init(addedByID : String, companyLogo : URL, companyName : String, companyTel : Int, companyEmail: String, companyTown : String, companyCity : String, companyCountry : String){
        self.addedByID =  addedByID
        self.companyLogo = companyLogo
        self.companyName = companyName
        self.companyTel = companyTel
        self.companyEmail = companyEmail
        self.companyTown = companyTown
        self.companyCity = companyCity
        self.companyCountry = companyCountry
    }
}
