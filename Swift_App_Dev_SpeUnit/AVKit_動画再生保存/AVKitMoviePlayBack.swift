//
//  AVKitMoviePlayBack.swift
//  Swift_App_Dev_SpeUnit
//
//  Created by 桑田翔平 on 2022/06/29.
//

import Foundation
import AVKit
import UIKit
import Photos

import NCMB

class ViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var thumbnailImageView:UIImageView!
    let imagePickerController = UIImagePickerController()
    private var videoUrl: NSURL?
    private let playerViewController = AVPlayerViewController()
    var urlArray = [String()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePickerController.delegate = self
        
        self.confirmPhotoLibraryAuthenticationStatus()
    }
    
    //MARK: - フォトライブラリ 決定
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let key = UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerMediaURL")
        videoUrl = info[key] as? NSURL
        
        
        thumbnailImageView.image = generateThumbnailFromVideo((videoUrl?.absoluteURL)!)
        
        thumbnailImageView.contentMode = .scaleAspectFit
        
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    //MARK: - サムネ生成
    private func generateThumbnailFromVideo(_ url: URL) -> UIImage? {
        //以下の３行で縦動画から画像を取り出しても横向きの画像にならないようにしてる
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        imageGenerator.appliesPreferredTrackTransform = true
        //切り取るタイミングの指定
        var time = asset.duration
        time.value = min(time.value, 2)
        
        do {
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            return nil
        }
    }
    //MARK: - ビデオ再生
    private func playVideo(from url: URL) {
        //プレイヤーに受けとったurlをセット
        let player = AVPlayer(url: url)
        //先ほど初期化したplayerViewControllerのプレイヤーに上記のプレイヤーをセット
        playerViewController.player = player
        //playerViewControllerの表示・再生
        self.present(playerViewController, animated: true) {
            print("playing video")
            self.playerViewController.player!.play()
        }
    }
    //MARK: - 写真フォルダ権限
    private func confirmPhotoLibraryAuthenticationStatus() {
        //権限の現状確認(許可されているかどうか)
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            //許可(authorized)されていない・ここで初回のアラートが出る
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                    //もし状態(status)が、初回(notDetermined)もしくは拒否されている(denied)の場合
                case .notDetermined, .denied:
                    self.appearChangeStatusAlert()
                default:
                    break
                }
            }
        }
    }
    //MARK: - フォトライブラリ権限付与
    private func appearChangeStatusAlert() {
        //フォトライブラリへのアクセスを許可していないユーザーに対して設定のし直しを促す。
        //タイトルとメッセージを設定しアラートモーダルを作成する
        let alert = UIAlertController(title: "Not authorized", message: "we need to access photo library to upload video", preferredStyle: .alert)
        //アラートには設定アプリを起動するアクションとキャンセルアクションを設置
        let settingAction = UIAlertAction(title: "setting", style: .default, handler: { (_) in
            guard let settingUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingUrl, options: [:], completionHandler: nil)
        })
        let closeAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        //アラートに上記の２つのアクションを追加
        alert.addAction(settingAction)
        alert.addAction(closeAction)
        //アラートを表示させる
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: - フォトライブラリ動画選択
    private func selectVideo() {
        //選択できるメディアは動画のみを指定
        self.imagePickerController.mediaTypes = ["public.movie"]
        //選択元はフォトライブラリ
        self.imagePickerController.sourceType = .photoLibrary
        //実際にimagePickerControllerを呼び出してフォトライブラリを開く
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func didTapMoviePostButton(_ sender: Any) {
        selectVideo()
    }
    @IBAction func didTapPlayButton(_ sender: Any) {
        //選択された動画の絶対パスがオプショナル(nilの可能性がある)ので
        //guard(railsでいうunless)でパスがnilなら早期リターンにしてる
        guard let url = videoUrl?.absoluteURL else { return }
        playVideo(from: url)
        
    }
    
    //動画アップロード
    @IBAction func uploadVideo() {
        //urlと名前がなければ早期リターンさせる
        let videoData = try? NSData(contentsOfFile: (self.videoUrl?.path)!, options: .mappedIfSafe)
        
        
        saveMovieFileUrl(movieData: videoData! as Data) { (url, error) in
            if error {
                print("成功")
                print(url)
            }else{
                print("error")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewController = segue.destination as! PlayerViewwwController
        secondViewController.urlnames = self.urlArray
        
    }
}
func saveMovieFileUrl(movieData: Data, _ completion: @escaping (String, Bool) -> Void) {
    let imageFile = NCMBFile.file(with: movieData) as! NCMBFile
    imageFile.saveInBackground({ (error) in
        if error != nil {
            print("error")
            completion(String(), false)
        }else{
            print("sucsess")
            let url = "https://mbaas.api.nifcloud.com/2013-09-01/applications/2y731eqwYZT8OQOA/publicFiles/" + imageFile.name
            
            completion(url, true)
        }
    })
}
