//
//  InfoViewController.swift
//  Libretto
//
//  Created by adel on 31/03/16.
//  Copyright © 2016 Adel. All rights reserved.
//

import Cocoa

class InfoViewController: NSViewController {
    var libretto = Libretto()
    @IBOutlet var media: NSTextField!
    @IBOutlet var baseLaurea: NSTextField!
    @IBOutlet var ipotesiBaseLaurea: NSTextField!
    @IBOutlet var ipotesiSlider: NSSlider!
    @IBOutlet var ipotesiResult: NSTextField!
    @IBOutlet var bg: NSImageView!
    @IBOutlet var laureaImg: NSImageView!
    @IBOutlet var lodeLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        laureaImg.image = NSImage(named: "student.png")
        media.stringValue = "Media = "+String(libretto.media())
        
        if(libretto.votoBaseLaurea() > 110){
            baseLaurea.stringValue = "Base Laurea = "+String("110 e lode")
        }
        else{
            baseLaurea.stringValue = "Base Laurea = "+String(Int(libretto.votoBaseLaurea()))
        }
        
        ipotesiSlider.integerValue = Int(libretto.votoBaseLaurea())
        setBaseLaureaLabel()
        ipotesi(NSSlider())
    }
    
    func setBaseLaureaLabel(){
        if( ipotesiSlider.integerValue > 110){
            ipotesiBaseLaurea.stringValue = String(110)
            lodeLabel.hidden = false
        }
        else{
            lodeLabel.hidden = true
            ipotesiBaseLaurea.stringValue = String(ipotesiSlider.integerValue)
        }
    }
    
    @IBAction func ipotesi(sender: NSSlider){
        setBaseLaureaLabel()
        if(ipotesiMedia() < 18 ){
            ipotesiResult.stringValue = "...Tranquillo,\n nemmeno se prendi tutti 18 ci arrivi"
        }
        else if(ipotesiMedia() > 33){
            ipotesiResult.stringValue = "...Ehm, come dire,\n è matematicamente impossibile"
        }
        else if(ipotesiMedia() > 31){
            ipotesiResult.stringValue = "devi prendere una media di:\n30 e lode ai prossimi esami"
        }
        else{
            ipotesiResult.stringValue = "devi prendere una media di:\n"+String(ipotesiMedia())+" ai prossimi esami"
        }
    }
    
    func ipotesiMedia() -> Float{
        var obbiettivo = Float(ipotesiSlider.integerValue)
        obbiettivo = Float(obbiettivo*30/110)
        let x = (obbiettivo*Float(libretto.CFULaurea)-libretto.media()*Float(libretto.creditiTotali()))/Float(libretto.creditiResidui())
        return x
    }
}
