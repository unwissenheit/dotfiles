# Neovim C# 開発環境

Neovim 0.12 + lazy.nvim + easy-dotnet.nvim による .NET 開発環境。
Microsoft 公式の Roslyn 言語サーバー（VS Code の C# 拡張と同じもの）を使用。

## 何ができるか

| | 手段 |
|---|---|
| 補完・定義ジャンプ・リネーム | Roslyn LSP |
| ビルド・実行 | `:Dotnet build` / `:Dotnet run` |
| テスト | Rider 風テストランナー（EasyDotnet） |
| デバッグ | netcoredbg（EasyDotnet に同梱） |
| フォーマット | CSharpier（保存時に自動実行） |
| 検索 | Telescope（`bin/` `obj/` は除外済み） |
| 配色 | nightfox.nvim（duskfox） |
| 補完・スニペット | blink.cmp + LuaSnip（friendly-snippets） |
| 起動画面 | alpha.nvim |
| ステータスライン | lualine.nvim |
| LSP進行状況表示 | fidget.nvim |

## 必要なもの

```bash
# .NET SDK 10 以降がインストール済みであること
dotnet tool install -g EasyDotnet   # テストランナー・デバッグ連携に必須
dotnet tool install -g csharpier    # 保存時フォーマット用
```

Roslyn 言語サーバーは手動インストール不要。easy-dotnet.nvim が C# ファイルを
初めて開いたときに `dotnet tool install --global roslyn-language-server --prerelease`
を自動実行してくれる（初回は少し時間がかかる）。更新したい場合は
`:Dotnet _server update` または `dotnet tool install -g EasyDotnet` を再実行。

あとは以下が必要。

- Neovim 0.12 以降
- git、ripgrep（Telescope の全文検索に使用）
- lazygit（`<leader>gg` で起動。`brew install lazygit`）
- make と C コンパイラ（`telescope-fzf-native.nvim` のビルドと、Treesitter
  パーサー（`main` ブランチ）の `:TSUpdate` に必要。macOS は
  `xcode-select --install` で入る）
- Nerd Font（アイコン表示用）

`~/.dotnet/tools` を PATH に通しておく。

## 導入

設定ファイルを `~/.config/nvim` に置いて `nvim` を起動するだけ。
lazy.nvim が自動で入り、プラグインを揃えたあと再起動すれば使える。

## ファイル構成

```
~/.config/nvim/
├── init.lua                   読み込み順を決めるだけ
├── lazy-lock.json             自動生成（git にコミットする）
└── lua/
    ├── bookmarks.lua          登録ディレクトリへジャンプ（M.dirs に追記して拡張）
    ├── config/
    │   ├── lazy.lua           lazy.nvim のブートストラップ
    │   ├── options.lua        インデント4、undofile、診断表示など
    │   ├── keymaps.lua        全体で効くキーマップ（<leader>fp）
    │   └── autocmds.lua       LSP のキーマップとハイライト(treesitter)の起動
    └── plugins/               ここは lazy が自動で読む
        ├── dotnet.lua         easy-dotnet（Roslyn LSP を含む）
        ├── dap.lua            デバッグ
        ├── treesitter.lua     ハイライト（main ブランチ）
        ├── telescope.lua      ファイル・シンボル検索
        ├── completion.lua     blink.cmp + LuaSnip + friendly-snippets
        ├── format.lua         conform + CSharpier
        ├── gitsigns.lua       git hunk表示・ステージ・blame
        ├── lazygit.lua        LazyGit をフローティングで起動
        ├── which-key.lua      leader キーマップのヒント表示
        ├── oil.lua            ディレクトリをバッファとして編集
        ├── editing.lua        mini.pairs / mini.surround / trouble
        ├── fidget.lua         LSP進行状況表示
        ├── lualine.lua        ステータスライン
        ├── alpha.lua          起動画面
        └── colorscheme.lua    nightfox（duskfox）
```

プラグイン本体は `~/.local/share/nvim/lazy/` に入るので、
`~/.config/nvim` はそのまま git 管理してよい。

## プロジェクトの開き方

```
MyApp/
├── MyApp.sln          ← ここで nvim を開く
├── src/
└── tests/
```

`.sln` のあるディレクトリから起動するのが最も確実。
初回はソリューション読み込みに数十秒かかるので、補完が出なくても少し待つ。

## キーマップ

Leader は `<Space>`。

**LSP**

| `gd` 定義 | `gr` 参照 | `gi` 実装 | `K` ホバー |
|---|---|---|---|
| `<leader>rn` リネーム | `<leader>ca` コードアクション | `<leader>e` 診断 | `]d` `[d` 診断移動 |

**.NET**

| `<leader>dr` 実行 | `<leader>db` ビルド | `<leader>dt` テスト | `<leader>ds` シークレット |
|---|---|---|---|

**デバッグ**

| `<F5>` 開始/続行 | `<F10>` ステップオーバー | `<F11>` ステップイン | `<leader>b` ブレークポイント |
|---|---|---|---|

**検索**

| `<leader>ff` ファイル | `<leader>fg` 全文 | `<leader>fb` バッファ | `<leader>fs` シンボル |
|---|---|---|---|

**Git（gitsigns / lazygit）**

| `]c` `[c` hunk移動 | `<leader>gs` ステージ | `<leader>gr` リセット | `<leader>gp` プレビュー | `<leader>gb` blame | `<leader>gg` LazyGit |
|---|---|---|---|---|---|

**編集・診断一覧（mini.pairs / mini.surround / trouble）**

| `saiw"` 囲み追加 | `sd"` 囲み削除 | `sr"'` 囲み置換 | `<leader>xx` 診断一覧 | `<leader>xr` 参照一覧 |
|---|---|---|---|---|

括弧・引用符は挿入モードで自動的に閉じる（mini.pairs）。

**ファイラー（oil.nvim）**

| `-` | 現在のファイルの親ディレクトリを開く（ディレクトリバッファ内は通常の編集操作で削除・リネーム・作成ができ、`:w` で確定） |
|---|---|

**補完（blink.cmp）**

`default` preset のキーバインド。スニペットは LuaSnip + friendly-snippets。

| `<C-space>` メニュー表示/ドキュメント | `<Tab>` / `<S-Tab>` 選択・スニペットのプレースホルダー移動 | `<CR>` 確定 | `<C-e>` 閉じる |
|---|---|---|---|

**起動画面（alpha.nvim）**

引数なしで `nvim` を起動したときだけ表示される。

| `f` ファイル検索 | `g` 全文検索 | `r` 最近使ったファイル | `o` ファイラー(oil) | `p` 登録ディレクトリへ移動 | `e` 新規ファイル | `q` 終了 |
|---|---|---|---|---|---|---|

**ディレクトリブックマーク**

| `<leader>fp` | `lua/bookmarks.lua` の `M.dirs` に登録した場所から選んで `:cd`＋`find_files`。場所を増やしたいときは `M.dirs` に1行足すだけ |
|---|---|

**その他**

`lua/config/keymaps.lua` には `<leader>fp`（ディレクトリブックマーク）と
`<leader>e`（診断のフロート表示）のみ定義。
それ以外は Neovim 標準のキー（`:w`、`<C-w>` 系）をそのまま使う。
`<leader>` を押すと which-key がグループ・キーの一覧をポップアップ表示する。

## 日常の操作

| プラグイン更新 | `:Lazy update` |
|---|---|
| 更新前に戻す | `:Lazy restore` |
| 不調の切り分け | `:checkhealth easy-dotnet` |
| ソリューション確認 | `:Dotnet solution select` |
| EasyDotnet サーバー更新 | `:Dotnet _server update` |

## 詰まったら

| 症状 | 見るところ |
|---|---|
| LSP が起動しない | `dotnet` と `~/.dotnet/tools` が PATH にあるか |
| 他プロジェクトの参照が解決しない | 掴んでいるソリューションが正しいか |
| 診断が2つ出る | roslyn.nvim と easy-dotnet の LSP を併用していないか |
| 起動直後に補完が出ない | 仕様。読み込み完了まで待つ |
| 初回起動が異様に遅い | Roslyn の自動インストール中の可能性。しばらく待つ |
| Treesitter でエラー | main ブランチの API 変更。一旦外して切り分ける |

## 注意点

- デバッグ時は対象プロジェクトを自分で先に起動しない。必ずデバッガから起動する。
- `mapleader` は lazy より前に設定する。後にするとキーマップがずれる。
- .NET Framework 4.x は制約あり。編集は Windows なら概ね動くが、
  netcoredbg が CoreCLR 専用のためデバッグはできない。
  Framework 案件はデバッグのみ Visual Studio を併用する。
