# 初期にGithubからセットアッププログラムを使用して、環境セットアップを行う方法

git clone https://github.com/MH200012/setup-mac.git

cd ~/Developer/setup-mac

chmod +x install.sh bootstrap.sh

./install.sh

# セットアッププログラム修正のGithubへの反映
### 変更内容を確認
git status

### 差分を確認
git diff

### ステージング
git add bootstrap.sh

or

git add .

### ステージング内容を確認（おすすめ）
git status


### コミット(コミットメッセージは、何を変更したかが分かる内容にします。(

git commit -m "Remove obsolete ai.sh from bootstrap”

### GitHubへPush
git push
git push -u origin main (初回のみ)

