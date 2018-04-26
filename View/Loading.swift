//
//  Loading.swift
//  Test
//
//  Created by Admin on 4/26/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class Loading: UIView {

    let acInd : UIActivityIndicatorView = UIActivityIndicatorView()
    
    let viewContent = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewContent()
        startAc()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewContent(){
        self.addSubview(viewContent)
        viewContent.frame = CGRect(x: 0, y: 0, width: 300  , height: 400)
        viewContent.backgroundColor = UIColor.black
        viewContent.alpha = 0.5
    }
    
    func startAc(){
        acInd.hidesWhenStopped = true
        acInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        acInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        acInd.center = viewContent.center
        self.viewContent.addSubview(acInd)
        acInd.startAnimating()
        
    }

}
