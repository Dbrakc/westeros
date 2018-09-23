//
//  HouseCollectionViewController.swift
//  Westeros
//
//  Created by David Braga  on 19/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

class HouseCollectionViewController: UIViewController {
    enum Constants{
        static let columms : CGFloat = 1
    }

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            let nib = UINib(nibName: "HouseCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: HouseCollectionViewCell.reuseIdentifier)
        }
    }
    
    let houses : [House]
    let colectionViewLayout : UICollectionViewFlowLayout
    
    //Mark: Inicialization
    init(withModel model: [House], layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()){
        self.houses = model
        colectionViewLayout = layout
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    //Mark
    
    func setupUI(){
        //Asignar el dataSource
        collectionView.dataSource = self
        
        //setup del layout
        let width = calculateItemWidth()
        colectionViewLayout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = colectionViewLayout
    }
    
    func calculateItemWidth()->CGFloat{
        let viewWidth = view.frame.width
        let spacing  = (Constants.columms - 1)*colectionViewLayout.minimumInteritemSpacing
        let width = (viewWidth-spacing) / Constants.columms
        return width
        
    }


    

}

extension HouseCollectionViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return houses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Obtenemor la casa
        let house = houses [indexPath.row]

        
        //Creamos (o cache) una celad
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HouseCollectionViewCell.reuseIdentifier, for: indexPath) as! HouseCollectionViewCell
        
        
        //Sync Model View
        cell.imageLabel.image = house.sigil.image
        cell.nameLabel.text = house.name
        
        //Devolver la celda
        return cell
    }
    
    
}
