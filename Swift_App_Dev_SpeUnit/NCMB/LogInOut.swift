//
//  SighInOut.swift
//  Swift_App_Dev_SpeUnit
//
//  Created by 桑田翔平 on 2022/06/29.
//

import Foundation
import NCMB

func <# ログイン関数名 #>(){
    guard let _hoge = <# 条件文 #> ,_hoge = <# 条件文 #> else{ return }
    
    NCMBUser.logInWithUsername(inBackground: <# ユーザネーム #>, password: <# パスワード #>){(user, error) in
        if error != nil {
            <#エラー処理#>
        }else{
            <# 成功処理 #>
        }
    }
    
}

