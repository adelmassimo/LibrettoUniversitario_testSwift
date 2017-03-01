//
//  Libretto.swift
//  Libretto
//
//  Created by adel on 30/03/16.
//  Copyright © 2016 Adel. All rights reserved.
//

import Foundation

class Libretto: NSObject{
    var esami = [Esame]()
    var CFULaurea : Int!
    
    override init() {
        CFULaurea = 180
    }
    
    required init(coder aDecoder: NSCoder) {
        self.esami = (aDecoder.decodeObjectForKey("esami") as? [Esame])!
        CFULaurea = 180
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(esami, forKey: "esami")
    }
    
    func media()-> Float{
        if( esami.count == 0){
            return 0
        }
        var m : Float = 0
        var c : Float = 0
        for(var i = 0; i < esami.endIndex; i++){
            m += esami[i].voto*Float(esami[i].cfu)
            c += Float(esami[i].cfu)
        }
        return m/c
    }
    
    func votoBaseLaurea() ->Float{
        return media()*110/30
    }
    
    func creditiResidui() -> Int{
        return CFULaurea - creditiTotali()
    }
    
    func creditiTotali() -> Int{
        if( esami.count == 0){
            return 0
        }
        var tot = 0
        for(var i = 0; i < esami.endIndex; i++){
            tot += esami[i].cfu
        }
        return tot
    }
    
    static func salvaLibretto(libretto : Libretto){
        let defaults = NSUserDefaults.standardUserDefaults()
        let myData = NSKeyedArchiver.archivedDataWithRootObject(libretto)
        defaults.setObject(myData, forKey: "libretto")
    }
    
    static func caricaLibretto() -> Libretto!{
        let defaults = NSUserDefaults.standardUserDefaults()
        let myData = defaults.objectForKey("libretto") as? NSData
        if myData != nil {
            return NSKeyedUnarchiver.unarchiveObjectWithData(myData!)! as! Libretto
        }
        return Libretto()
    }
    
}