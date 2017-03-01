//
//  Ipotizza.swift
//  Libretto
//
//  Created by adel on 03/04/16.
//  Copyright © 2016 Adel. All rights reserved.
//

import Cocoa

class IpotizzaViewController: NSViewController {
    
    @IBOutlet var cod: NSTextField!
    @IBOutlet var nome: NSTextField!
    @IBOutlet var aggiungi: NSButton!
    @IBOutlet var votoSelector: NSSlider!
    @IBOutlet var lode: NSButton!
    @IBOutlet var votoLabel: NSTextField!
    @IBOutlet var lodeLabel: NSTextField!
    @IBOutlet var CFUIn: NSTextField!
    @IBOutlet var CFUStepper: NSStepper!
    @IBOutlet var media: NSTextField!
    @IBOutlet var baseLaurea: NSTextField!
    var libretto : Libretto!
    @IBOutlet var close: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBAction func setVoto(sender: NSSlider){
        votoSlide()
    }
    
    func setUp(){
        close.image = NSImage(named: "NSStopProgressFreestandingTemplate")
        lode.integerValue = 0
        votoSlide()
        CFUIn.integerValue = CFUStepper.integerValue
        setBaseLaurea()
    }
    
    func setMedia() -> Float{
        if(libretto.esami.count == 0){
            var n = votoSelector.integerValue
            if(lode.integerValue == 1){
                n += 3
            }
            media.stringValue = String(libretto.media())+" ► "+String(n)
            return Float(n)
        }
        var m = libretto.media()*Float(libretto.creditiTotali())
        m += Float(votoSelector.integerValue*CFUIn.integerValue)
        if(lode.integerValue == 1){
            m += Float(3*CFUIn.integerValue)
        }
        m = m/Float(libretto.creditiTotali()+CFUIn.integerValue)
        media.stringValue = String(libretto.media())+" ► "+String(m)
        return m
    }
    
    func setBaseLaurea(){
        let base = Int(setMedia()*110/30)
        if(base > 110){
            baseLaurea.stringValue = String(libretto.votoBaseLaurea())+" ► "+"110 e lode"
            return
        }
        baseLaurea.stringValue = String(Int(libretto.votoBaseLaurea()))+" ► "+String(base)
    }
    
    func votoSlide(){
        votoLabel.stringValue = String(votoSelector.integerValue)
        if(votoSelector.integerValue == 30){
            lode.enabled = true
        }
        else{
            lode.enabled = false
        }
        printLode()
        setBaseLaurea()
    }
    
    func printLode(){
        if(votoSelector.integerValue == 30 && lode.integerValue == 1){
            lodeLabel.stringValue = "e lode"
        }
        else{
            lode.integerValue = 0
            lodeLabel.stringValue = ""
        }
    }
    
    @IBAction func pressLode(sender: NSButton){
        printLode()
        setMedia()
        setBaseLaurea()
    }
    
    @IBAction func setCFUByStepper(sender: NSStepper){
        CFUIn.integerValue = CFUStepper.integerValue
        setMedia()
        setBaseLaurea()
    }
    
    @IBAction func closeWindow(sender: AnyObject){
        self.view.window?.close()
        
    }
}
