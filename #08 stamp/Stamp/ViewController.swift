//
//  ViewController.swift
//  Stamp
//
//  Created by Aoi Sakaue on 2016/11/23.
//  Copyright © 2016年 Sakaue Aoi. All rights reserved.
//

import UIKit
//デリゲートとはなんぞや

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //スタンプ画像の名前が入った配列
    var imageNameArray: [String] = ["hana", "hoshi", "onpu", "shitumon","tobisuke"]
    
    //選択しているスタンプ画像の番号
    var imageIndex : Int = 0
    
    //背景画像を表示するImageView
    @IBOutlet var haikeiImageView: UIImageView!
    
    //スタンプ画面が入るImageView
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func selectedFirst(){
        imageIndex = 1
    }
    
    @IBAction func selectedSecond(){
        imageIndex = 2
    }
    
    @IBAction func selectedThird(){
        imageIndex = 3
    }
    
    @IBAction func selectedFourth(){
        imageIndex = 4
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //タッチされた位置を取得
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        //もしimageIndexが0でない（押すスタンプが選ばれていない）とき
        if imageIndex != 0 {
            //スタンプサイズを40pxの正方形に指定
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            
            //押されたスタンプの画像を指定
            let image : UIImage = UIImage(named: imageNameArray[imageIndex - 1])!
            imageView.image = image
            
            //タッチされた位置に画像を置く
            imageView.center = CGPoint(x: location.x ,y : location.y)
            
            //画像を表示する
            self.view.addSubview(imageView)
        
        }
    }
    
    
    
    //戻るボタンを宣言、スタンプの画像を取り除く
    //スタンプ画像（imageView）をViewController上のView(SuperView)から（from）取り除く（remove）
    @IBAction func back(){
        self.imageView.removeFromSuperview()
    }
    
    //フォトライブラリを表示させて背景を選ぶ
    @IBAction func selectBackground() {
        //UIImagePickerControllerのインスタンスを作る
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        //フォトライブラリを使う設定をする
        //フォトライブラリのソース
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //
        imagePickerController.delegate = self
        //編集を許可
        imagePickerController.allowsEditing = true
        
        //フォトライブラリを呼び出す（画面遷移）
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    //フォトライブラリから画像の選択が終わったら呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String : Any]) {
        //imageに選んだ画像を設定する
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //imageを背景に設定する
        self.haikeiImageView.image = image
        //フォトライブラリを閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    //スタンプを押した画像を保存するメソッド
    @IBAction func save() {
        //画面上のスクリーンショットを取得
        let rect:CGRect = CGRect(x: 0, y: 30, width: 320, height: 380)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //フォトライブラリに保存
        UIImageWriteToSavedPhotosAlbum(capture!,nil, nil, nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

