//
//  Esame.swift
//  Libretto
//
//  Created by adel on 29/03/16.
//  Copyright © 2016 Adel. All rights reserved.
//

import Foundation

class Esame: NSObject{
    var nome : String!
    var cod : String!
    var voto : Float = 0
    var lode : Bool!
    var cfu : Int! = 6
    var professore : String! = ""
    
    override init() {
    }
    
    required init(coder aDecoder: NSCoder) {
        self.nome = (aDecoder.decodeObjectForKey("nome") as? String)!
        self.cod = (aDecoder.decodeObjectForKey("cod") as? String)!
        self.voto = (aDecoder.decodeObjectForKey("voto") as? Float)!
        self.lode = (aDecoder.decodeObjectForKey("lode") as? Bool)!
        self.cfu = (aDecoder.decodeObjectForKey("cfu") as? Int)!
      //  self.professore = (aDecoder.decodeObjectForKey("professore") as? String)!

    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(nome, forKey: "nome")
        aCoder.encodeObject(cod, forKey: "cod")
        aCoder.encodeObject(voto, forKey: "voto")
        aCoder.encodeObject(lode, forKey: "lode")
        aCoder.encodeObject(cfu, forKey: "cfu")
        aCoder.encodeObject(professore, forKey: "professore")
    }
    
    
}