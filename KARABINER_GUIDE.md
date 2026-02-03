# Karabiner-Elements + gitsigns設定ガイド

このガイドでは、Karabiner-Elementsを使ってVSCode風のGitキーマップを実現します。

## 🎯 設計方針

### なぜKarabinerを使うのか

1. ✅ **左右Cmdを区別できる**
2. ✅ **同時押しが可能**（`左Cmd+k+n` 同時押し）
3. ✅ **Neovim側はシンプル**（標準的なキーマップだけ）
4. ✅ **他のアプリでも使える**（VS Code, ターミナル全般）

### アーキテクチャ

```
左Cmd+k+n (同時押し)
    ↓
[Karabiner-Elements]
    ↓
Space, h, s (順番に送信)
    ↓
[Neovim] Space+hs = ステージング
```

---

## 📋 Neovim側の標準キーマップ

Karabinerから変換するターゲットキーマップ：

| 機能 | Neovimキーマップ | 説明 |
|------|-----------------|------|
| ステージング | `Space + hs` | 現在行をステージング |
| アンステージング | `Space + hu` | アンステージング |
| 変更を戻す | `Space + hr` | 現在行の変更を元に戻す |
| プレビュー | `Space + hp` | 変更をプレビュー |
| Blame表示 | `Space + hb` | Blame表示 |
| 差分表示 | `Space + hd` | 差分表示 |
| ファイル全体ステージ | `Space + hS` | ファイル全体をステージング |
| ファイル全体を戻す | `Space + hR` | ファイル全体を元に戻す |

---

## ⚙️  Karabiner設定

### 設定ファイルの場所

```
~/.config/karabiner/karabiner.json
```

### 設定例（JSON）

以下を `karabiner.json` の `rules` セクションに追加：

```json
{
  "description": "Neovim Git操作 (左Cmd+k+キー → Space+h+キー)",
  "manipulators": [
    {
      "description": "左Cmd+k+n → Space+hs (ステージング)",
      "type": "basic",
      "from": {
        "key_code": "n",
        "modifiers": {
          "mandatory": ["left_command"],
          "optional": ["any"]
        }
      },
      "to": [
        {
          "key_code": "spacebar"
        },
        {
          "key_code": "h"
        },
        {
          "key_code": "s"
        }
      ],
      "conditions": [
        {
          "type": "frontmost_application_if",
          "bundle_identifiers": [
            "^com\\.mitchellh\\.ghostty$"
          ]
        }
      ]
    },
    {
      "description": "左Cmd+k+shift+n → Space+hu (アンステージング)",
      "type": "basic",
      "from": {
        "key_code": "n",
        "modifiers": {
          "mandatory": ["left_command", "shift"],
          "optional": ["any"]
        }
      },
      "to": [
        {
          "key_code": "spacebar"
        },
        {
          "key_code": "h"
        },
        {
          "key_code": "u"
        }
      ],
      "conditions": [
        {
          "type": "frontmost_application_if",
          "bundle_identifiers": [
            "^com\\.mitchellh\\.ghostty$"
          ]
        }
      ]
    },
    {
      "description": "左Cmd+k+p → Space+hp (プレビュー)",
      "type": "basic",
      "from": {
        "key_code": "p",
        "modifiers": {
          "mandatory": ["left_command"],
          "optional": ["any"]
        }
      },
      "to": [
        {
          "key_code": "spacebar"
        },
        {
          "key_code": "h"
        },
        {
          "key_code": "p"
        }
      ],
      "conditions": [
        {
          "type": "frontmost_application_if",
          "bundle_identifiers": [
            "^com\\.mitchellh\\.ghostty$"
          ]
        }
      ]
    },
    {
      "description": "左Cmd+k+r → Space+hr (変更を戻す)",
      "type": "basic",
      "from": {
        "key_code": "r",
        "modifiers": {
          "mandatory": ["left_command"],
          "optional": ["any"]
        }
      },
      "to": [
        {
          "key_code": "spacebar"
        },
        {
          "key_code": "h"
        },
        {
          "key_code": "r"
        }
      ],
      "conditions": [
        {
          "type": "frontmost_application_if",
          "bundle_identifiers": [
            "^com\\.mitchellh\\.ghostty$"
          ]
        }
      ]
    },
    {
      "description": "左Cmd+k+b → Space+hb (Blame)",
      "type": "basic",
      "from": {
        "key_code": "b",
        "modifiers": {
          "mandatory": ["left_command"],
          "optional": ["any"]
        }
      },
      "to": [
        {
          "key_code": "spacebar"
        },
        {
          "key_code": "h"
        },
        {
          "key_code": "b"
        }
      ],
      "conditions": [
        {
          "type": "frontmost_application_if",
          "bundle_identifiers": [
            "^com\\.mitchellh\\.ghostty$"
          ]
        }
      ]
    },
    {
      "description": "左Cmd+k+d → Space+hd (差分表示)",
      "type": "basic",
      "from": {
        "key_code": "d",
        "modifiers": {
          "mandatory": ["left_command"],
          "optional": ["any"]
        }
      },
      "to": [
        {
          "key_code": "spacebar"
        },
        {
          "key_code": "h"
        },
        {
          "key_code": "d"
        }
      ],
      "conditions": [
        {
          "type": "frontmost_application_if",
          "bundle_identifiers": [
            "^com\\.mitchellh\\.ghostty$"
          ]
        }
      ]
    }
  ]
}
```

---

## 🔧 設定のポイント

### 1. `left_command` で左Cmdを指定

```json
"modifiers": {
  "mandatory": ["left_command"]
}
```

- `left_command` → 左Cmdキーのみ
- `right_command` → 右Cmdキーのみ（別の用途に使える）

### 2. Ghosttyでのみ有効化

```json
"conditions": [
  {
    "type": "frontmost_application_if",
    "bundle_identifiers": [
      "^com\\.mitchellh\\.ghostty$"
    ]
  }
]
```

他のアプリには影響しません。

### 3. キーを順番に送信

```json
"to": [
  { "key_code": "spacebar" },
  { "key_code": "h" },
  { "key_code": "s" }
]
```

`Space → h → s` の順番で送信されます。

---

## 📊 キーマップ一覧

### 基本操作
| Karabiner（入力） | Neovim（変換後） | 機能 |
|------------------|-----------------|------|
| `左Cmd+k+n` | `Space + hs` | ステージング |
| `左Cmd+k+Shift+n` | `Space + hu` | アンステージング |
| `左Cmd+k+p` | `Space + hp` | プレビュー |
| `左Cmd+k+r` | `Space + hr` | 変更を戻す |
| `左Cmd+k+b` | `Space + hb` | Blame表示 |
| `左Cmd+k+d` | `Space + hd` | 差分表示 |

### 追加で設定可能
| Karabiner（入力） | Neovim（変換後） | 機能 |
|------------------|-----------------|------|
| `左Cmd+k+s` | `Space + hS` | ファイル全体ステージ |
| `左Cmd+k+Shift+r` | `Space + hR` | ファイル全体を戻す |

---

## 🚀 設定手順

### 1. Karabiner-Elementsをインストール

```bash
brew install --cask karabiner-elements
```

### 2. 設定ファイルを編集

```bash
# バックアップ
cp ~/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json.backup

# 編集
open ~/.config/karabiner/karabiner.json
```

上記のJSONを `rules` セクションに追加。

### 3. Ghosttyのbundle_identifierを確認

```bash
osascript -e 'id of app "Ghostty"'
```

出力されたIDをJSONの `bundle_identifiers` に設定。

### 4. Karabiner-Elementsを再起動

設定が自動で反映されます。

### 5. 動作確認

1. Ghosttyを開く
2. Neovimでファイルを開く
3. `左Cmd+k+n` を同時押し
4. ステージングされるか確認

---

## 💡 応用例

### 右Cmdを別の用途に

```json
{
  "description": "右Cmd+k+... → 別の機能",
  "from": {
    "modifiers": {
      "mandatory": ["right_command"]
    }
  }
}
```

### VS Codeでも同じキーマップ

```json
"conditions": [
  {
    "type": "frontmost_application_if",
    "bundle_identifiers": [
      "^com\\.mitchellh\\.ghostty$",
      "^com\\.microsoft\\.VSCode$"
    ]
  }
]
```

---

## ❓ トラブルシューティング

### Q: 動かない

A: Karabinerの権限を確認
- システム設定 → プライバシーとセキュリティ → アクセシビリティ

### Q: 他のアプリでも動いてしまう

A: `bundle_identifiers` を確認

### Q: キーが連続で入力されてしまう

A: キーリピートの問題。Karabinerで調整可能。

---

このアプローチなら、左右Cmdを区別でき、同時押しも可能です！
