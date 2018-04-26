//
//  ViewController.swift
//  Test
//
//  Created by Admin on 2/4/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SVGKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var txtSearchName: UITextField!
    
    @IBOutlet weak var txtSearchLanguage: UITextField!
    
    @IBOutlet weak var txtSearchCapital: UITextField!
    
    
    @IBAction func reloadTableView(_ sender: Any) {
        
        tableView.reloadData()
    }
    
    @IBAction func searchNamebtm(_ sender: Any) {
        let urlSearchName : String = "https://restcountries.eu/rest/v2/currency/" + txtSearchName.text!
        
       getData(urlString: urlSearchName)
    }
    
    @IBAction func searchLanguagebtm(_ sender: Any) {
        let urlSearchLanguage : String = "https://restcountries.eu/rest/v2/lang/" + txtSearchLanguage.text!
        
        getData(urlString: urlSearchLanguage)
    }
    
    @IBAction func searchCapitalbtm(_ sender: Any) {
        let urlSearchCapital : String = "https://restcountries.eu/rest/v2/capital/" + txtSearchCapital.text!
        
        getData(urlString: urlSearchCapital)
    }
    
    
    var array : [Country] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getData(urlString: "https://restcountries.eu/rest/v2/all")
        
        tableView.dataSource = self
        tableView.delegate  = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCELL") as! CustomCell
        
        cell.nameCountry.text = array[indexPath.row].name
        cell.capitalCountry.text = array[indexPath.row].capital
        
        cell.areCountry.text = String(format: "%f", array[indexPath.row].area)
        cell.population.text = String(format: "%f", array[indexPath.row].population)
        
        
        if let urlImageCountry = array[indexPath.row].flag{
            
            let queue = DispatchQueue(label: "q")
            
            queue.async {
                do{
                    let url = URL(string: urlImageCountry)
                    let data = try Data(contentsOf: url!)
                    
                    DispatchQueue.main.async {
                        
                        let imageSVG : SVGKImage = SVGKImage(data: data)
                        cell.imageCountry.image = imageSVG.uiImage
                    }
                }
                catch{}
            }
            
        }
        return cell
    }
    
    
    func getData(urlString: String)  {
        
        var status = 0
        
       let url =  URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, respons, err) in
            
            guard let data = data else { return }
            
            do{
                
                if let jsonDataErr = try? JSONDecoder().decode(dataResponErr.self, from: data){
                    
                    status = jsonDataErr.status
                    if status != 0{
                        DispatchQueue.main.async {
                            self.setAlertError(status: status)
                        }
                        print("-----Eror \(status)")
                    }
                    
                }else{
                    let jsonData = try JSONDecoder().decode([failableDecod<Country>].self, from: data).flatMap { $0.base }
                    
                    self.array = jsonData
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            }catch let respons {
                
                print(respons)
                
            }
            }.resume()
        
    }
    
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

