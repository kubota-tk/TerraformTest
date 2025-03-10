# 第2工程で行ったこと（2_SetCF2.md）

## 概要
第1工程（1_SetCF.md）で、サーバー組み込み環境で、Webアプリケーションのデプロイを完成している。  
本工程では、以下のとおり進めた
- puma、nginx、RDS(Mysql)を使って3層構造にサーバーを組み替え
- アプリのユーザーはALB経由でEC2にアクセス
- 画像の保管場所をEC2からS3に指定
  
![構成図](images2/構成図2.png)

## 1.CircleCIの環境変数追加状況
- CircleCI上で、環境変数に前回から「RDS_ENDPOINT」、「AWS_S3_BUCKET_NAME」を追加設定した。
![1.1_environment](images2/2.1_environment.png)    

template
- [**config.yml（ホストのIPアドレスの変更のみ）**](/template2/circleci/config.yml)  


## 2. Cloudformationの各テンプレート実行(resources.yml、ALBリスナーデフォルト数値の微修正のみ)
![2.1_cloudformation1](images2/2.1_cloudformation1.png)  
![2.2_cloudformation1](images2/2.2_cloudformation1.png)
![2.3_cloudformation1](images2/2.3_cloudformation1.png)

template
- [**vpc.yml（前回から変更なし）**](/template1/cloudformation/vpc.yml)  
- [**security.yml（前回から変更なし）**](/template1/cloudformation/security.yml) 
- [**resources.yml（前回から変更あり）**](/template1/cloudformation/resources.yml)  



## 3. Ansibleのアプリ等のセットアップ設定
Railsアプリケーションのインストールに必要な設定を実行。
- roles（ruby）はrbenvからrvmを使ったインストールに切り替え
- roles（ruby,setup,setup_server）でpuma,nginx,socket接続等で大きく追加
　→ development.rb（setup_serverのtemplates）でALBとの接続と、画像保存先の変更
  → database.yml（setup_serverのtemplates）でRDSへの接続
  → puma.rb他（setup_serverのtemplates）でpumaのソケット設定等
　→ nginx.conf（setup_serverのtemplates）でnginxの設定
  
- その他rolesは微修正
![3.1_ansible](images1/3.1_ansible1.png)  
![3.2_ansible](images1/3.2_ansible2.png) 


Template(Ansibleの設定ファイル、全て前回から変更あり)
 - [**inventory.yml**](/template2/ansible/inventory)  
 - [**playbook.yml**](/template2/ansible/playbook.yml)  
 - [**main.yml(swap)**](/template2/ansible/roles/swap/tasks/main.yml)  
 - [**main.yml(git)**](/template2/ansible/roles/git/tasks/main.yml)  
 - [**main.yml(app-in)**](/template2/ansible/roles/app-in/tasks/main.yml)  
 - [**main.yml(yum)**](/template2/ansible/roles/yum/tasks/main.yml) 
 - [**main.yml(mysql)**](/template2/ansible/roles/mysql/tasks/main.yml)
 - [**main.yml(ruby)**](/template2/ansible/roles/ruby/tasks/main.yml)
 - [**main.yml(rails)**](/template2/ansible/roles/rails/tasks/main.yml)
 - [**main.yml(bundler)**](/template2/ansible/roles/bundler/main.yml)
 - [**main.yml(node)**](/template2/ansible/roles/node/tasks/main.yml)
 - [**main.yml(yarn)**](/template2/ansible/roles/yarn/tasks/main.yml)
 - [**main.yml(imagemagick)**](/template2/ansible/roles/imagemagick/tasks/main.yml)
 - [**main.yml(nginx)**](/template2/ansible/roles/nginx/tasks/main.yml)
 - [**main.yml(setup)**](/template2/ansible/roles/setup/tasks/main.yml)
 - [**main.yml(setup_server)**](/template2/ansible/roles/setup_server/tasks/main.yml)

## 4. Serverspecのテスト
git,nginxのインストール確認（前回と変更なし）
![4.1_serverspec](images2/4.1_serverspec1.png)  
![4.2_serverspec](images2/4.2_serverspec2.png)

template（前回と変更なし）
 - [**Gemfile**](/template2/serverspec/Gemfile)  
 - [**sample_spec.rb**](/template2/serverspec/sample_spec.rb)

## 5. アプリの実行結果
自動デプロイした Webアプリケーションに、ALBのDNS名を使ってブラウザーから接続。画像を保存してS3に追加、削除されるまでを確認した。  
- Webアプリケーションのトップページを表示    
![5.1_app_top_page](images1/5.1_app_top_page.png)  
  
-画像を表示させて表示
![5.2_app_pic_create](images2/5.2_app_pic_create.png)

-S3に画像が保存された状況  
![5.3_app_s3_create](images2/5.3_app_pic_create.png)

-S3から画像を削除した状況  
![5.4_app_s3_delite](images2/5.4_app_pic_create.png)

-S3からの画像削除が反映された状況
![5.5_app_pic_delite](images2/5.5_app_pic_create.png)
 
## 6. 考察
puma、nginx、RDS(Mysql)の3層構造に、RailsのWebアプリケーションをデプロイし、さらにS3での画像保管と、ALBでの分散をCloudFormationで反映させた。  
今後、Terraformの活用、CloudWatchのアラーム導入、Fargate導入と構築していく予定。
