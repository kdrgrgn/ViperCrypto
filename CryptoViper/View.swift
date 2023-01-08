//
//  View.swift
//  CryptoViper
//
//  Created by kadir on 8.01.2023.
//

import Foundation
import UIKit
// Talks to -> presenter
// class, protocol


protocol AnyView{

    var presenter : AnyPresenter? { get set }
    
    func update(with cryptos: [Crypto])
    func update(with error: String)

    
}


class DetailViewController : UIViewController {
    
    var currency : String = ""
    var price : String = ""

    
    private let currencyLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Currency Label"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        label.numberOfLines = 1


        return label
    }()
    
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Price Label"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        label.numberOfLines = 1


        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(currencyLabel)
        view.addSubview(priceLabel)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currencyLabel.frame = CGRect(x: view.frame.width / 2 - 100 , y: view.frame.height / 2 - 25, width: 200, height: 50)
        priceLabel.frame = CGRect(x: view.frame.width / 2 - 100 , y: view.frame.height / 2 + 50, width: 200, height: 50)
        
        view.backgroundColor = .cyan
        currencyLabel.text = currency
        priceLabel.text = price

    }
    
}




class  CryptoViewController: UIViewController, AnyView , UITableViewDelegate, UITableViewDataSource{
    var presenter: AnyPresenter?
    
    var cryptos : [Crypto] = []

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        nextVC.currency  = cryptos[indexPath.row].currency
        nextVC.price = cryptos[indexPath.row].price
        self.present(nextVC, animated: true)
    }
    
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.sizeToFit()
        label.numberOfLines = 6


        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100 , y: view.frame.height / 2 - 100, width: 200, height: 200)
        
    }
    

    
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false

        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
            self.view.backgroundColor = .red
        }
    }
    
    
}
