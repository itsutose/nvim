
**大前提**

karabiner-elementによってmacOS（JIS配列）の標準的なキーボード配列から↓の変更がされている。
- 基本的なキーの入れ替え
    - capslock → japanese_eisuu
        - capslockの操作はshift+cmdによって行う
    - japanese_eisuu → japanese_kana
    - japanese_kana → right_control
- ショートカット
    - **right_control（かなキー）+ キー**: ホームポジションでの基本操作
        - `u`: Backspace
        - `i`: ↑（上矢印）
        - `o`: Delete
        - `p`: （未使用）
        - `h`: Home（行頭, Ctrl+A相当）
        - `j`: ←（左矢印）
        - `k`: ↓（下矢印）
        - `l`: →（右矢印）
        - `;`: End（行末, Ctrl+E相当）
    - **right_command（未定義だがシステム上のcmdキー）+ キー**: タブ・ウィンドウ操作
        - `h`: Cmd+Shift+T（新しいタブ）
        - `j`: タブ移動（左/前）※アプリによって異なる
        - `k`: アプリ固有の操作
        - `l`: タブ移動（右/次）※アプリによって異なる
        - `;`: タブ移動
        - `u`: デスクトップを左へ（Control+←）
        - `p`: デスクトップを右へ（Control+→）
        - `i`: Cmd+Shift+[（順序変更）
        - `o`: Cmd+[（戻る）
    - **right_control + right_shift + x/c/v**: カット/コピー/ペースト（Cmd+x/c/v）

    ただし、right_controlについては現状のjiklによる矢印移動をvimライクなhjklに変えることの検討はしている。理解してほしいのは自分はright_controlによるショートカットを多用してきたということである。

**操作方法が統一的でない++
    - モードによって移動の時のキーが変わる
        - ある行を編集しているときに、insertモードで修正している時に、そこから移動して別の修正をしようとすると、一旦normalに入って修正をする羽目になる
            - これは、日本語入力をしている時だとより顕著。
                1. insertでの編集
                2. （移動したい）
                3. escに移る
                    - 自分はescではなく, jjによってnormalモードに移るという設定をしている
                    - この時、jjでnormalモードに移るには英数入力になっていなければならない。日本語入力中での場合は英数へのキーを押す、
                4. normalモードでの移動
                5. insertモードに入る（iキーを押す）
                6. 日本語キーを押す
                7. 編集
        - normal→insertで改行しながら文字入力について、oは便利であるが、2だん改行したい、という場合、o,oではダメで、o, enterとしなければならないのが面倒

**あると良さそうな点, 改善できそうな方法**
    - inserモードでもある程度、（せめて同じ行での移動など）でnormalモードの操作をできる
        - せめて行頭、行末、単語単位での移動というのができるようにしたい
    - normalモードへの切り替えを日本語入力・英語入力に関係なく行えること
        - 少なくとも、日本語入力がある場合でのvimのモード切り替えは日本語入力→英数入力を行って、vimモード切り替えというようなに段階になる場合が多々ある
        - これを改善するだけでも、insert中にnormalにいこうとして「っj」を入力してしまうというようなことは防げる
        - jjによるnormalへの切り替えは絶対ではない。候補としては英数キーを関連させたキーバインドを作る。他にもいい案があれば提案してほしい。


**必要ない操作**
    - shift+j(normal)
    - ctrl+u(normal)

**気になっていること**

    - command, control, shiftなどは左右で区別することができるか？
    - どのモードからでも強制的にモード変更できるようなキーを各モードの起動キーとすることはできるか？
        - 自分が困っている点は↓のようなもの
            - 今はnormalだからinsertにするためにiを打ってから文字を入力しないと。あ、でも日本語入力モードだったから「い」になっちゃった。削除して、英数にして、iを打って、さあ入力
                - ↑非常に面倒に思う。
            - visualで行を選択していたけどやっぱり文字を入力したい。この場合はいったんvを押してvisualモードを抜けて、iを押す
            - insertで文字入力中の時に範囲選択したいけどいったんnormalに行ってからvisualにしないと、、、
        - 解決方法。↓のようにできないかと思った。またこれの実現性と利便性について確認、考察
            - visual, normal時にxxキーを入力したらinsert
            - insert, normal時にyyキーを入力したらvisual
            - insert, visual時にzzキーを入力したらnormal
        - 日本語モードでも関係なくモード切り替えができるようにするというだけでもかなり恩恵があると思う。
            - ただし、escは遠いので論外、別のキー割り当てで対処したい。
            - まだ詳しい制限などは考えていないが、japanese_eisuu, japanese_kanaのキーをこれに用いることができないかと考えている。
                - japanese_eisuuを押すと強制的にnormalにするとか、ただしこれだとinsertで日本語から英数入力への切り替えができなくなるので、right_control+japanese_eisuuのようにしてできそうかなどの検討をしたい。
    - normalでのw,e,b
        - w,eは簡単に入力できるがbは打ちづらい。そもそも、w,eは似たような操作であるにも関わらず、それと反対のキーが全く統一的でない別のところにあるのがややこしいし打ちづらい。
    -



*+わからない操作の方法(単純)**
- insert, normalでのBS, Delの方法
- visualでの行頭、行末への行き方
    - Shift+Vで起動すれば良いということは知っているが、vで起動してしまった時にこのような操作はしたい。
- tab移動
    - vscodeとかの場合はtabを押すだけで行のインデントの操作ができる。これをやるためにinsert→normal→(>>)→insertとするのが面倒くさい。insertでできるようにしたい。
    - normalでは>>でのインデントができない？
    - インデントを下げるやつについては↑のと同様に解決できる？（vimでは<<でできるのは知っている）


**設定しておきたいもの**
これはvimのpluginとかを入れることで対処できそうなもの. vimが悪いというよりかは、運用でなんとかできそうなもの
詳しく調べていないので、lazy.nvimで管理できるかも含めて調査する


- markdownをいい感じに表示するやつ
    - previewではなく、plain textのmdをいい感じにしたい
        - ハイライト
        - 折りたたみ
        - 色をいい感じにする
        - etc
    - mermaidグラフを表示させるためのpreview用のものも必要
        - mdファイルと、その中でmermaidグラフを見ることができるもの
            - peek.nvim:https://github.com/toppair/peek.nvim
                - Denoが必要

- vimのキーバインディング管理
    どのキーが何かというのをGUI的に把握できるようにしたい。
- git関連
    - git-messanger.nvim:https://github.com/rhysd/git-messenger.vim
        - その行のcommitメッセージを遡ってみれる
    - blamer.nvim:https://github.com/APZelos/blamer.nvim
        - git blameをghost textとして出せる
    - diffview.nvim:https://github.com/sindrets/diffview.nvim
        - diffガミやすく可視化できる

- easymotion
    lazy.nvimなので、pluginに↓を追加
    ```hop.lua
    return {
      "phaazon/hop.nvim",
      branch = "v2",
      config = function()
        require("hop").setup {
          multi_windows = true,
        }
      end,
      keys = {
        {mode = "", "<leader>s", "<cmd>HopChar<CR>", desc = "説明"},
      }
    }
    ```
