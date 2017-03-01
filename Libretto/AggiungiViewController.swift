//
//  AggiungiViewController.swift
//  Libretto
//
//  Created by adel on 31/03/16.
//  Copyright © 2016 Adel. All rights reserved.
//

import Cocoa

class AggiungiViewController: NSViewController{
    @IBOutlet var cod: NSTextField!
    @IBOutlet var nome: NSTextField!
    @IBOutlet var aggiungi: NSButton!
    @IBOutlet var votoSelector: NSSlider!
    @IBOutlet var lode: NSButton!
    @IBOutlet var votoLabel: NSTextField!
    @IBOutlet var lodeLabel: NSTextField!
    @IBOutlet var CFUIn: NSTextField!
    @IBOutlet var CFUStepper: NSStepper!
    var libretto = Libretto()
    @IBOutlet var bg: NSImageView!
    var back : EsamiViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        lode.integerValue = 0
        votoSlide()
        CFUIn.integerValue = CFUStepper.integerValue
    }
    
    func setBgImage(){
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
        setBgImage()
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
        setBgImage()
        printLode(sender)
    }
    
    @IBAction func aggiungiEsame(sender: AnyObject){
        let e = Esame()
        e.nome = nome.stringValue
        e.cod  = cod.stringValue
        e.voto = Float(votoSelector.integerValue)
        e.lode = Bool(lode.integerValue)
        e.cfu = CFUIn.integerValue
        if( lode.integerValue == 1){
            e.voto += 3
        }
        libretto.esami.append(e)
        Libretto.salvaLibretto(libretto)
        back.listaEsami.reloadData()
        self.view.window?.close()
    }
    
    @IBAction func setCFUByStepper(sender: NSStepper){
        CFUIn.integerValue = CFUStepper.integerValue
    }
    
}