//
//  CountriesTableViewCell.swift
//  Countries
//
//  Created by Excell Nicolas on 1/9/22.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func setCountryCell(country: Country?) {
        
        countryLabel.text = country?.name.common
        
        guard let url = URL(string: country?.flags.png ?? "") else { return }
        if let data = try? Data(contentsOf: url) {
            flagImageView.image = UIImage(data: data)
        }
    }
}
