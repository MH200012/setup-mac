# setup-mac

新しい Mac の開発環境を自動で構築・更新するための個人用セットアップリポジトリです。

Homebrew パッケージ、開発ランタイム、dotfiles、macOS の設定、Dock、エディタやデスクトップアプリをまとめてセットアップします。スクリプトは再実行できるように設計されており、導入済みの項目は可能な範囲でスキップされます。

## 主なセットアップ内容

- Xcode Command Line Tools、Homebrew、Git、GitHub CLI
- chezmoi と個人用 dotfiles
- mise による Python、Node.js、Go、Java の管理
- uv と Python ツール
- VS Code、Cursor、Raycast、Granola、Trello、MacWhisper
- Homebrew Bundle による用途別パッケージ
- 開発用ディレクトリの作成
- macOS の初期設定と Dock の構成
- セットアップ後の環境診断

## 対象環境

- macOS
- Apple Silicon または Intel Mac
- インターネット接続
- 管理者権限
- GitHub アカウント

セットアップ中に、sudo パスワード、GitHub へのログイン、Git のユーザー名とメールアドレスの入力を求められる場合があります。

## 初回セットアップ

ターミナルを開き、次のコマンドを順番に実行します。

```bash
mkdir -p ~/Developer
cd ~/Developer
git clone https://github.com/MH200012/setup-mac.git
cd setup-mac
chmod +x install.sh bootstrap.sh update.sh
./install.sh
```

`install.sh` は、必要に応じて以下を行った後、`bootstrap.sh` を実行します。

1. Xcode Command Line Tools の導入
2. Homebrew、Git、GitHub CLI の導入
3. GitHub CLI の認証
4. リポジトリの取得または更新
5. 開発環境全体のセットアップ

処理が完了したら、設定を反映するためにターミナルや Mac の再起動が必要になることがあります。

## セットアップ内容の選択

実行前に `config/` 配下の TOML ファイルを編集すると、構成を調整できます。

| ファイル | 用途 |
| --- | --- |
| `config/packages.toml` | Homebrew のパッケージグループを有効・無効化 |
| `config/dock.toml` | Dock に配置するアプリを指定 |
| `config/folders.toml` | 作成するフォルダーの設定 |
| `config/repositories.toml` | GitHub ユーザー、作業場所、リポジトリ情報を設定 |
| `config/vscode.toml` | VS Code の導入、拡張機能、設定を制御 |

Homebrew のパッケージは、次の Brewfile に用途別で定義されています。

- `Brewfile`: 基本ツール
- `Brewfile.dev`: 開発ツール
- `Brewfile.ai`: AI 関連ツール
- `Brewfile.database`: データベース関連ツール
- `Brewfile.cloud`: クラウド関連ツール
- `Brewfile.productivity`: 生産性向上アプリ
- `Brewfile.optional`: 任意のツール

たとえば任意ツールも導入する場合は、`config/packages.toml` の `optional` を `true` に変更します。

```toml
[brew]
optional = true
```

## 再実行

セットアップだけを再実行する場合は、リポジトリ内で次を実行します。

```bash
./bootstrap.sh
```

詳細な実行ログを表示したい場合は、デバッグモードを利用できます。

```bash
DEBUG=true ./bootstrap.sh
```

## 環境の更新

Homebrew、mise、uv、dotfiles、Dock の構成をまとめて更新するには、次を実行します。

```bash
cd ~/Developer/setup-mac
git pull --ff-only
./update.sh
```

`update.sh` は Homebrew パッケージのアップグレードとクリーンアップも行います。

## 環境診断

通常は `bootstrap.sh` の最後に自動実行され、Git、GitHub CLI、Homebrew、mise、uv、Python、VS Code CLI、Cursor の状態を確認します。

問題の切り分けには、各ツールの状態も個別に確認できます。

```bash
gh auth status
brew doctor
mise doctor
chezmoi doctor
```

## ディレクトリ構成

```text
setup-mac/
├── bootstrap.sh          # 環境構築のメイン処理
├── install.sh            # 初回導入用スクリプト
├── update.sh             # 導入済み環境の更新
├── Brewfile*             # Homebrew パッケージ定義
├── config/               # ユーザー設定
└── scripts/
    ├── common/           # 共通関数と定数
    ├── doctor/           # 環境診断
    ├── dotfiles/         # dotfiles 関連処理
    ├── folders/          # ディレクトリ作成
    ├── install/          # ツール別の導入処理
    ├── macos/            # macOS と Dock の設定
    ├── tools/            # 補助ツール
    └── update/           # 更新処理
```

## トラブルシューティング

### GitHub の認証に失敗する

```bash
gh auth login
gh auth setup-git
gh auth status
```

### Homebrew が見つからない

Apple Silicon Mac では、現在のシェルに Homebrew の環境設定を読み込みます。

```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Intel Mac では `/usr/local/bin/brew` が使用されます。

### `git push` が拒否される

GitHub 側に新しいコミットがある場合は、リモートの変更を取り込んでから push します。

```bash
git pull --rebase origin main
git push origin main
```

競合が発生した場合は、対象ファイルを修正してから次を実行します。

```bash
git add <修正したファイル>
git rebase --continue
git push origin main
```

## 開発時の基本操作

変更内容を確認し、コミットして GitHub に反映します。

```bash
git status
git diff
git add <変更したファイル>
git commit -m "変更内容を表すメッセージ"
git push
```

## 注意事項

- このリポジトリは個人環境向けです。GitHub ユーザー名、dotfiles リポジトリ、アプリ構成などは実行前に確認してください。
- `bootstrap.sh` は macOS の設定や Dock を変更します。既存の構成を残したい場合は、`scripts/macos/` と `config/dock.toml` の内容を確認してください。
- Homebrew のパッケージ定義を変更した場合は、対応する Brewfile と `config/packages.toml` の両方を確認してください。
