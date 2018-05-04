//
//  ViewController.swift
//  Test
//
//  Created by Admin on 2/4/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SVGKit
import Kingfisher

//protocol checkUrlImageLocal {
//    func checkArray(count: Int)
//}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, protocolReloadTBV{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var txtSearchName: UITextField!
    
    @IBOutlet weak var txtSearchLanguage: UITextField!
    
    @IBOutlet weak var txtSearchCapital: UITextField!
    
    @IBAction func btmReload(_ sender: Any) {
        LibraryAPI.shared.delegate = self as protocolReloadTBV
        LibraryAPI.shared.getData(url: "https://restcountries.eu/rest/v2/all")
    }
    
    @IBAction func searchNamebtm(_ sender: Any) {
        let urlSearchName : String = "https://restcountries.eu/rest/v2/currency/" + txtSearchName.text!
        
        LibraryAPI.shared.delegate = self as protocolReloadTBV
        LibraryAPI.shared.getData(url: urlSearchName)
    }
    
    @IBAction func searchLanguagebtm(_ sender: Any) {
        let urlSearchLanguage : String = "https://restcountries.eu/rest/v2/lang/" + txtSearchLanguage.text!
        
        LibraryAPI.shared.delegate = self as protocolReloadTBV
        LibraryAPI.shared.getData(url: urlSearchLanguage)
    }
    
    @IBAction func searchCapitalbtm(_ sender: Any) {
        let urlSearchCapital : String = "https://restcountries.eu/rest/v2/capital/" + txtSearchCapital.text!
        
        LibraryAPI.shared.delegate = self as protocolReloadTBV
        LibraryAPI.shared.getData(url: urlSearchCapital)
    }
    
    var countries : [Country] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        LibraryAPI.shared.delegate = self as protocolReloadTBV
        LibraryAPI.shared.getData(url: "https://restcountries.eu/rest/v2/all")
        
        tableView.dataSource = self
        tableView.delegate  = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCELL") as! CustomCell
        
        let country = countries[indexPath.row]
        cell.country = country
        
        return cell
    }
    
    //implement protocolReloadTBV
    internal func reloadTableView(countries:[Country]) {
        self.countries = countries
        tableView.reloadData()
    }
    
    internal func requestAPIError(statusError: Int){
        self.setAlertError(status: statusError)
    }
    
    
    //AlertError
    func setAlertError(status: Int){
        
        let alert = UIAlertController(title: "Error", message: "Key search error \(status) ", preferredStyle: .alert)
        
        let btmOk = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alert.addAction(btmOk)
        
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

