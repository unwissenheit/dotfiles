# dotfiles (chezmoi)

このリポジトリは [chezmoi](https://www.chezmoi.io/) で管理している dotfiles です。

## 管理対象

| ソース側ファイル | 配置先 | 内容 |
|---|---|---|
| `dot_zshrc` | `~/.zshrc` | zsh設定 |
| `dot_gitconfig` | `~/.gitconfig` | Gitのユーザー名・メール設定 |
| `dot_ssh/config` | `~/.ssh/config` | SSH接続設定（ホスト定義） |
| `dot_config/nvim/` | `~/.config/nvim/` | Neovim設定一式（`init.lua`, `lua/`, `lazy-lock.json`） |
| `dot_config/wezterm/` | `~/.config/wezterm/` | ターミナル(WezTerm)設定 |
| `dot_config/karabiner/karabiner.json` | `~/.config/karabiner/karabiner.json` | キーリマップ設定 |

## 管理していないもの（意図的に除外）

- **SSH秘密鍵** (`~/.ssh/id_rsa`, `~/.ssh/kinchan` など)
  - Gitリポジトリに平文/暗号化ファイルとして残すリスクを避けるため、**Bitwarden**で別途管理する
  - 保存: Bitwardenに「SSH Key」タイプまたは「Secure Note + ファイル添付」で登録
  - 復元:
    ```bash
    brew install bitwarden-cli
    bw login && bw unlock
    bw get attachment id_rsa --itemid <ITEM_ID> --output ~/.ssh/id_rsa
    chmod 600 ~/.ssh/id_rsa
    ```
- **`~/.ssh/known_hosts`** — マシン固有の接続履歴のため管理不要
- **`~/.config/karabiner/automatic_backups/`** — karabinerが自動生成するバックアップ。`.chezmoiignore`で除外
- **認証情報・履歴・キャッシュ類** (`~/.claude/`, `~/.docker/`, `~/.npm/`, `~/.zsh_history` など) — 機密情報やマシン固有のキャッシュのため対象外

## 基本コマンド

```bash
chezmoi add <file>      # 管理対象に追加
chezmoi edit <file>     # ソース側を編集（$EDITORが開く）
chezmoi diff             # 適用前に差分確認
chezmoi apply             # 差分をホームディレクトリに反映
chezmoi status            # 管理対象の変更状況を一覧表示
chezmoi managed           # 管理対象ファイル一覧
chezmoi cd                # ソースディレクトリへ移動
```

## よくある操作

**設定を編集して反映する:**
```bash
chezmoi edit ~/.config/nvim/init.lua --apply
```

**新しいマシンにセットアップする:**
```bash
brew install chezmoi
chezmoi init <このリポジトリのURL>
chezmoi apply
# その後、Bitwardenから秘密鍵を復元する
```

**変更をコミットする:**
```bash
chezmoi cd
git add <変更したファイル>
git status   # 意図した差分だけかを確認
git commit -m "..."
git push
```

## ファイル名の属性（プレフィックス）

chezmoiはファイル名のプレフィックスで属性を表現します。

| プレフィックス/拡張子 | 意味 |
|---|---|
| `dot_` | 先頭に `.` を付けて配置 |
| `private_` | パーミッション `600` |
| `executable_` | 実行権限を付与 |
| `.tmpl` | テンプレートとして展開してから配置 |

詳細: https://www.chezmoi.io/reference/target-types/
