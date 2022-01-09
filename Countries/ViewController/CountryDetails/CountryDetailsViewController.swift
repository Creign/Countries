//
//  CountryDetailsViewController.swift
//  Countries
//
//  Created by Excell Nicolas on 1/9/22.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryCommonLabel: UILabel!
    @IBOutlet weak var countryOfficialLabel: UILabel!
    @IBOutlet weak var countryRegionLabel: UILabel!
    @IBOutlet weak var countryPopulationLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var viewModel: CountriesViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let country = viewModel?.currentCountry else { return }
        
        countryImageView.image = getImage(url: country.flags.png)
        countryCommonLabel.text = country.name.common
        countryOfficialLabel.text = country.name.official
        countryRegionLabel.text = country.region
        countryPopulationLabel.text = "\(country.population)"
        
        closeButton.layer.cornerRadius = 5
        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                action: #selector(didTapClose)))
    }
    
    func getImage(url: String) -> UIImage {
        guard let url = URL(string: url) else { return UIImage() }
        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data) ?? UIImage()
        }
        
        return UIImage()
    }
    
    @objc func didTapClose() {
        self.dismiss(animated: true, completion: nil)
    }
}
