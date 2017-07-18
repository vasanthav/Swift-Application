//
//  ViewController.swift
//  WhatToWear
//
//  Created by Vasantha Vurakaranam on 9/29/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var getWeatherButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activity.isHidden = true;
           /* self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!) */
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background3.jpg")
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
    @IBAction func getWeatherAction(_ sender: AnyObject) {
        self.resultLabel.isHidden = true
        activity.isHidden = false
        activity.startAnimating();
        
        requestGET(nameText.text!) { (success, object) in
            DispatchQueue.main.async(execute: {
                if(success){
                    self.activity.stopAnimating()
                    self.activity.isHidden = true
                    //self.getMessage.isHidden = true
                   // let message = object!["base"] as! String
                   // print("Hello : Here is my actual message", object)
                    let mainWeather = object!["weather"] as? [[String:AnyObject]]
                   // print("Hello : Here is my weather", mainWeather)
                    for weather in mainWeather! {
                        if let weaDescription = weather["description"] as? String {
                            print("weather description is:::", weaDescription)
                            //self.resultLabel.text! = weaDescription;
                           
                            let imageView = UIImageView();
                            let image = UIImage(named: "umbrella.jpg");
                            imageView.image = image;
                            imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                            self.resultLabel.addSubview(imageView)
                            /* Change resultLabel to textField and try the code below */
                            //let leftView = UIView.init(frame: CGRectMake(10, 0, 30, 30))
                            //self.resultLabel.leftView = leftView;
                            //self.resultLabel.leftViewMode = UITextFieldViewMode.Always
                            //Add another image
                            let imageView1 = UIImageView();
                            let image1 = UIImage(named: "raincoat.jpg");
                            imageView1.image = image1;
                            imageView1.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                            self.resultLabel.addSubview(imageView1)
                            
                            // create an NSMutableAttributedString that we'll append everything to
                            /*let fullString = NSMutableAttributedString(string: "")
                            
                            // create our NSTextAttachment
                            let image1Attachment = NSTextAttachment()
                            image1Attachment.image = UIImage(named: "umbrella.jpg")
                            
                            // wrap the attachment in its own attributed string so we can append it
                            let image1String = NSAttributedString(attachment: image1Attachment)
                            
                            // add the NSTextAttachment wrapper to our full string, then add some more text.
                            fullString.append(image1String)
                            fullString.append(NSAttributedString(string: "End of text"))
                            
                            // draw the result in a label
                            self.resultLabel.attributedText = fullString */
                        }
                    }
                    self.resultLabel.textColor = UIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1.0)
                    self.resultLabel.font = self.resultLabel.font.withSize(40)
                    self.resultLabel.isHidden = false
                }
            } )
        }
    }

    @IBAction func getMessageAction(_ sender: AnyObject) {
        self.resultLabel.isHidden = true
        activity.isHidden = false
        activity.startAnimating();
        
        requestGET(nameText.text!) { (success, object) in
            DispatchQueue.main.async(execute: {
                if(success){
                    self.activity.stopAnimating()
                    self.activity.isHidden = true
                    //self.getMessage.isHidden = true
                    let message = object!["base"] as! String
                    do {
                        let jsonData = try! JSONSerialization.data(withJSONObject: object!,options: .prettyPrinted)
                        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options: [])
                        print("Hello : Here is my another message", jsonObject)
                        /*if let weatherObject = jsonObject["weather"] as? [String:String] {
                            for blog in weatherObject {
                                if let name = blog["description"] as? String {
                                    self.resultLabel.text! = name
                                }
                            }
                        } */
                        self.resultLabel.text! = message
                        //self.resultLabel.text! = json as! String;
                    }

                    
                   
                    
                    self.resultLabel.textColor = UIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1.0)
                    self.resultLabel.font = self.resultLabel.font.withSize(40)
                    self.resultLabel.isHidden = false
                }
            } )
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

