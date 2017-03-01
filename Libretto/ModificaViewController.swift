//
//  ModificaViewController.swift
//  Libretto
//
//  Created by adel on 02/04/16.
//  Copyright © 2016 Adel. All rights reserved.
//

import Cocoa

class ModificaViewController: NSViewController {
    @IBOutlet var cod: NSTextField!
    @IBOutlet var nome: NSTextField!
    @IBOutlet var modifica: NSButton!
    @IBOutlet var votoSelector: NSSlider!
    @IBOutlet var lode: NSButton!
    @IBOutlet var votoLabel: NSTextField!
    @IBOutlet var lodeLabel: NSTextField!
    @IBOutlet var CFUIn: NSTextField!
    @IBOutlet var CFUStepper: NSStepper!
    var libretto = Libretto()
    @IBOutlet var bg: NSImageView!
    var back : EsamiViewController!
    var row : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        CFUStepper.integerValue = libretto.esami[row].cfu
        votoSelector.integerValue = Int(libretto.esami[row].voto)
        nome.stringValue = libretto.esami[row].nome
        cod.stringValue = libretto.esami[row].cod
        CFUIn.stringValue = String(libretto.esami[row].cfu)
        votoSlide()
    }
    
    
    @IBAction func setVoto(sender: NSSlider){
        votoSlide()
    }
    
    func votoSlide(){
        votoLabel.stringValue = String(votoSelector.integerValue)
        if(votoSelector.integerValue == 30){
            lode.enabled = true
        }
        else{
            lode.enabled = false
        }
        printLode(lode)
    }
    
    func printLode(sender: NSButton){
        if(votoSelector.integerValue == 30 && lode.integerValue == 1){
            lodeLabel.stringValue = "e lode"
        }
        else{
            lode.integerValue = 0
            lodeLabel.stringValue = ""
        }
    }
    
    @IBAction func pressLode(sender: NSButton){
        printLode(sender)
    }
    
    @IBAction func modificaEsame(sender: NSButton){
        
        libretto.esami[row].nome = nome.stringValue
        libretto.esami[row].cod  = cod.stringValue
        libretto.esami[row].voto = Float(votoSelector.integerValue)
        libretto.esami[row].lode = Bool(lode.integerValue)
        libretto.esami[row].cfu = CFUIn.integerValue
        if( lode.integerValue == 1){
            libretto.esami[row].voto += 3
        }
        Libretto.salvaLibretto(libretto)
        back.listaEsami.reloadData()
        self.view.window?.close()
    }
    
    @IBAction func setCFUByStepper(sender: NSStepper){
        CFUIn.integerValue = CFUStepper.integerValue
    }
    
}
