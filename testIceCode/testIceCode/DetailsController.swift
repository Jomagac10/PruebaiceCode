//
//  DetailsController.swift
//  testIceCode
//
//  Created by Jose Manuel García Chávez on 5/30/19.
//  Copyright © 2019 Unam. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    
    var ami: amiibo?{
        didSet{
            if let image = ami?.image{
                let url = URL(string: image)
                amiiboImage.kf.setImage(with: url)
            }
            
            if let name = ami?.name{
                nameLabel.text = name
            }
            if let series = ami?.amiiboSeries{
                seriesLabel.text = series
            }
            if let release = ami?.release{
                releaseDates.text = "AU: \(release.au ?? "-") \n EU: \(release.eu ?? "-") \n JP: \(release.jp ?? "-") \n NA: \(release.na ?? "-")"
            }
        }
    }
    
    let amiiboImage : UIImageView = {
        let iv = UIImageView()
        //iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLabel : UILabel = {
        let tf = UILabel()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.textColor = UIColor(red: 252/255, green: 215/255, blue: 173/255, alpha: 1)
        //        tf.attributedPlaceholder = NSAttributedString(string: "Número de cuenta", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.text = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let seriesLabel : UILabel = {
        let tf = UILabel()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.textColor = UIColor(red: 252/255, green: 215/255, blue: 173/255, alpha: 1)
        //        tf.attributedPlaceholder = NSAttributedString(string: "Número de cuenta", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.text = "Series"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let releaseDates : UILabel = {
        let tf = UILabel()
        tf.textColor = .black
        tf.textAlignment = .center
        tf.numberOfLines = 4
        tf.textColor = UIColor(red: 37/255, green: 161/255, blue: 142/255, alpha: 1)
        //        tf.attributedPlaceholder = NSAttributedString(string: "Número de cuenta", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        tf.text = "Release Dates"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    func setupLayout(){
        view.backgroundColor = UIColor(red: 127/255, green: 216/255, blue: 190/255, alpha: 1)
        view.addSubview(amiiboImage)
        
        amiiboImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        amiiboImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 20).isActive = true
        amiiboImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        amiiboImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: amiiboImage.bottomAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: amiiboImage.centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: amiiboImage.widthAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(seriesLabel)
        seriesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        seriesLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
        seriesLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
        seriesLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        view.addSubview(releaseDates)
        releaseDates.topAnchor.constraint(equalTo: seriesLabel.bottomAnchor, constant: 10).isActive = true
        releaseDates.centerXAnchor.constraint(equalTo: seriesLabel.centerXAnchor).isActive = true
        releaseDates.widthAnchor.constraint(equalTo: seriesLabel.widthAnchor).isActive = true
        releaseDates.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }

}
