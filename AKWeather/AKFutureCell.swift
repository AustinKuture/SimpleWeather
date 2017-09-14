//
//  AKFutureCell.swift
//  AKWeather
//
//  Created by 李亚坤 on 2017/9/12.
//  Copyright © 2017年 Kuture. All rights reserved.
//

import UIKit

class AKFutureCell: UICollectionViewCell {
    
    //date
    public lazy var dateL = UILabel()
    //pic
    public lazy var picL = UIImageView()
    //weather
    public lazy var weatherL = UILabel()
    //wind
    public lazy var windL = UIButton()
    //tempreture
    public lazy var tempreture = UIButton()
    
    override init(frame: CGRect) {
        
       super.init(frame: frame)
        
        setupWeatherView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:视图布局
extension AKFutureCell{
    
    fileprivate func setupWeatherView(){
        
        //日期
        dateL.font = FONT_S(12)
        dateL.numberOfLines = 0
        dateL.textAlignment = ALIG_CENTER
        
        self.addSubview(dateL)
        dateL.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: self.bounds.size.width * 0.7, height: 30))
            make.top.equalTo(self.snp.top).offset(5)
        }
        
        //weatherPic
        picL.layer.cornerRadius = 25
        picL.layer.masksToBounds = true
        
        self.addSubview(picL)
        picL.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(dateL.snp.centerX)
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerY.equalTo(self.snp.centerY).offset(-10)
        }
        
        //Weather
        weatherL.font = FONT_S(16)
        weatherL.textAlignment = ALIG_CENTER
        
        self.addSubview(weatherL)
        weatherL.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(picL.snp.centerX)
            make.top.equalTo(picL.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: self.bounds.size.width * 0.7, height: 20))
        }
        
        //风向
        windL.titleLabel?.font = FONT_S(12)
        windL.titleLabel?.textAlignment = ALIG_CENTER
        windL.setImage(UIImage(named:"weather_wind"), for: UIControlState.normal)
        windL.backgroundColor = COLORS_RANDOM(0.5)
        
        self.addSubview(windL)
        windL.snp.makeConstraints { (make) in
            
            make.height.equalTo(30)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right).offset(-SCREEN_WIDTH * 0.2)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        //温度范围
        tempreture.titleLabel?.font = FONT_S(12)
        tempreture.titleLabel?.textAlignment = ALIG_CENTER
        tempreture.setImage(UIImage(named:"weather_tm"), for: UIControlState.normal)
        tempreture.backgroundColor = COLORS_RANDOM(0.5)
        
        self.addSubview(tempreture)
        tempreture.snp.makeConstraints { (make) in
            
            make.height.equalTo(30)
            make.left.equalTo(windL.snp.right)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }

    }
}


























