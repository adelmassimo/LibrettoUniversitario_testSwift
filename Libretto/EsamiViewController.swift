//
//  ViewController.swift
//  Libretto
//
//  Created by adel on 28/03/16.
//  Copyright © 2016 Adel. All rights reserved.
//

import Cocoa

class EsamiViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate{
    
    @IBOutlet weak var aggiungi: NSButton!
    @IBOutlet var remove: NSButton!
    @IBOutlet var listaEsami: NSTableView!
    
    var libretto = Libretto()
    let rules = Rules()
    var aggiungiController = AggiungiViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    
    func setUp(){
        libretto = Libretto.caricaLibretto()
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "aggiungiSegue"){
            let next = segue.destinationController as! AggiungiViewController
            next.libretto = libretto
            next.back = self
        }
        if(segue.identifier == "ipotizzaSegue"){
            let next = segue.destinationController as! IpotizzaViewController
            next.libretto = libretto
        }
        if(segue.identifier == "modificaSegue"){
            let next = segue.destinationController as! ModificaViewController
            next.libretto = libretto
            next.back = self
            next.row = listaEsami.selectedRow
        }
        if(segue.identifier == "infoSegue"){
            let next = segue.destinationController as! InfoViewController
            next.libretto = libretto
        }
    }
    
    @IBAction func aggiungiEsame(sender: NSButton){
        self.performSegueWithIdentifier("aggiungiSegue", sender: self)
        
    }
    
    @IBAction func modificaEsame(sender: AnyObject){
        if(listaEsami.selectedRow != -1){
            self.performSegueWithIdentifier("modificaSegue", sender: self)
        }
    }
   
    @IBAction func infoLibretto(sender: NSButton){
            self.performSegueWithIdentifier("infoSegue", sender: self)
    }

    @IBAction func rimuoviEsame(sender: NSButton){
        if(listaEsami.selectedRow < libretto.esami.endIndex && listaEsami.selectedRow > -1){
            libretto.esami.removeAtIndex(listaEsami.selectedRow)
            listaEsami.reloadData()
            Libretto.salvaLibretto(libretto)
        }
    }
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return libretto.esami.count
    }
    
   func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView?
    {
        var cell = tableView.makeViewWithIdentifier("esameCell", owner: self) as! NSTableCellView
                // 2
        if (tableColumn!.identifier == "esame") {
            cell.textField!.stringValue = libretto.esami[row].nome
            cell.textField?.textColor = coloreEsame(row)//
            return cell;
        }
        
        if (tableColumn!.identifier == "voto") {
            cell = tableView.makeViewWithIdentifier("votoCell", owner: self) as! NSTableCellView
            cell.textField!.textColor = coloreEsame(row)
            if(libretto.esami[row].voto > 30){
                cell.textField!.stringValue = "30L"
            }
            else{
                cell.textField!.stringValue = String(Int(libretto.esami[row].voto))
            }
            
            return cell;
        }

        if (tableColumn!.identifier == "cfu") {
            cell = tableView.makeViewWithIdentifier("cfuCell", owner: self) as! NSTableCellView
            cell.textField!.textColor = coloreEsame(row)
            cell.textField!.stringValue = String(libretto.esami[row].cfu)
            
            return cell;
        }

        if (tableColumn!.identifier == "num") {
            cell = tableView.makeViewWithIdentifier("numCell", owner: self) as! NSTableCellView
            cell.textField!.textColor = coloreEsame(row)
            cell.textField!.stringValue = String(row+1)
            
            return cell;
        }
        
        if (tableColumn!.identifier == "cod") {
            cell = tableView.makeViewWithIdentifier("codCell", owner: self) as! NSTableCellView
            cell.textField?.textColor = coloreEsame(row)
            cell.textField!.stringValue = String(libretto.esami[row].cod)
            return cell;
        }
        
        
        return cell
    }
    

    
    func coloreEsame( row: Int) ->NSColor{
        
        var color : CGColorRef = CGColorCreateGenericRGB(0, 0, 0, 1)
        
        if(!rules.useColors){
            return NSColor(CGColor: color)!
        }
        
        if( libretto.esami[row].voto > libretto.media()){
            color =  CGColorCreateGenericRGB(0.3, 0.85, 0.4, 1)
        }
        if( libretto.esami[row].voto < libretto.media()){
            color = CGColorCreateGenericRGB(0.9, 0.9, 0.1, 1)
        }
        //________________________________________________________Colori forzati:
        if( libretto.esami[row].voto >= 30){
            color = CGColorCreateGenericRGB(0.05, 1, 0.05, 0.8)
        }
        if( libretto.esami[row].voto < 19){
            color = CGColorCreateGenericRGB(0.9, 0.1, 0.1, 0.8)
        }
       
        return NSColor(CGColor: color)!
    }
}

