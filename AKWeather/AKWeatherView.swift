//
//  AKWeatherView.swift
//  AKWeather
//
//  Created by 李亚坤 on 2017/9/8.
//  Copyright © 2017年 Kuture. All rights reserved.
//

import UIKit


//属性参数
let fontLarge = FONT_S(SCREEN_WIDTH * 0.2)
let fontLittle = FONT_S(17)

let picCenter = (SCREEN_WIDTH + SCREEN_WIDTH * 0.4 + 65) * 0.5

class AKWeatherView: UIView {

    //MARK:控件
    //currentTempreture
    public lazy var currentTempreture = UILabel()
    //weatherState
    public lazy var weatherState = UILabel()
    //pm2.5
    public lazy var currentPM = UIButton()
    //wind
    public lazy var weatherWind = UILabel()
    //tempretureScope
    public lazy var tempretureScope = UIButton()
    
    //白天图片
    public lazy var dayPicImg = UIImageView()
    //晚上图片
    public lazy var nightPicImg = UIImageView()
    

    override func draw(_ rect: CGRect) {
        
        setupCurrentWeather()
    }
    
    //图形初始化
    //MARK:实时布局
    func setupCurrentWeather(){
        
        //当前温度
        currentTempreture.font = fontLarge
        currentTempreture.textAlignment = ALIG_CENTER
        currentTempreture.backgroundColor = COLORS_RANDOM(0.5)
        
        self.addSubview(currentTempreture)
        currentTempreture.snp.makeConstraints { (make) in
            
            make.left.equalTo(self.snp.left).offset(10)
            make.top.equalTo(self.snp.top)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH * 0.4, height: SCREEN_WIDTH * 0.4))
        }
        
        //天气状况
        weatherState.font = fontLittle
        weatherState.textAlignment = ALIG_CENTER
        weatherState.numberOfLines = 0;
        weatherState.backgroundColor = COLORS_RANDOM(0.5)
        
        self.addSubview(weatherState)
        weatherState.snp.makeConstraints { (make) in
            
            make.left.equalTo(currentTempreture.snp.right).offset(5)
            make.bottom.equalTo(currentTempreture.snp.centerY)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        //PM2.5
        currentPM.titleLabel?.font = FONT_S(12)
        currentPM.titleLabel?.textAlignment = ALIG_CENTER
        currentPM.titleLabel?.numberOfLines = 0
        currentPM.setImage(UIImage(named: "pm25_"), for: UIControlState.normal)
        currentPM.backgroundColor = COLORS_RANDOM(0.5)
        
        self.addSubview(currentPM)
        currentPM.snp.makeConstraints { (make) in
            
            make.left.equalTo(currentTempreture.snp.right).offset(5)
            make.top.equalTo(currentTempreture.snp.centerY)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        //风向
        weatherWind.font = FONT_S(12)
        weatherWind.textAlignment = ALIG_CENTER
        weatherWind.backgroundColor = COLORS_RANDOM(0.5)
        
        self.addSubview(weatherWind)
        weatherWind.snp.makeConstraints { (make) in
            
            make.height.equalTo(30)
            make.left.equalTo(currentTempreture.snp.left)
            make.right.equalTo(currentTempreture.snp.right).offset(-SCREEN_WIDTH * 0.2)
            make.top.equalTo(currentTempreture.snp.bottom)
        }
        
        //温度范围
        tempretureScope.titleLabel?.font = fontLittle
        tempretureScope.titleLabel?.textAlignment = ALIG_CENTER
        tempretureScope.setImage(UIImage(named:"weather_tm"), for: UIControlState.normal)
        tempretureScope.backgroundColor = COLORS_RANDOM(0.5)
        
        self.addSubview(tempretureScope)
        tempretureScope.snp.makeConstraints { (make) in
            
            make.height.equalTo(30)
            make.left.equalTo(weatherWind.snp.right)
            make.right.equalTo(currentPM.snp.right)
            make.top.equalTo(weatherWind.snp.top)
        }
        
        //白天图片
        dayPicImg.layer.cornerRadius = 25
        dayPicImg.layer.masksToBounds = true
        
        self.addSubview(dayPicImg)
        dayPicImg.snp.makeConstraints { (make) in
            
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.left.equalTo(self.snp.left).offset(picCenter - 25)
            make.top.equalTo(weatherState.snp.top)
        }
        
        //晚上图片
        nightPicImg.layer.cornerRadius = 25
        nightPicImg.layer.masksToBounds = true
        
        self.addSubview(nightPicImg)
        nightPicImg.snp.makeConstraints { (make) in
            
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.top.equalTo(dayPicImg.snp.bottom)
            make.centerX.equalTo(dayPicImg.snp.centerX)
        }
        
    }


}































