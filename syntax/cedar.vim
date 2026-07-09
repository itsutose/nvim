" Vim syntax file for the Cedar policy language (and .cedarschema)
" Cedar には公式 LSP / main ブランチ用 tree-sitter parser が無いため、
" 依存ゼロの正規表現ハイライトで .cedar / .cedarschema を色分けする。
" 型検査・診断は nvim-lint(cedar linter) 側が担当する。

if exists("b:current_syntax")
  finish
endif

syn case match

" --- コメント ---
syn keyword cedarTodo    contained TODO FIXME XXX NOTE
syn match   cedarComment "//.*$" contains=cedarTodo,@Spell

" --- 文字列・数値 ---
syn match  cedarEscape contained "\\."
syn region cedarString start=+"+ skip=+\\"+ end=+"+ contains=cedarEscape
syn match  cedarNumber "\<\d\+\>"

" --- policy: effect / 条件 / スコープ変数 ---
syn keyword cedarEffect    permit forbid
syn keyword cedarCondition when unless
syn keyword cedarScope     principal action resource context

" --- 演算子的キーワード・真偽・制御 ---
syn keyword cedarKeyword in has like is if then else
syn keyword cedarBoolean true false

" --- schema キーワードと組み込み型 ---
syn keyword cedarSchema  namespace entity action type appliesTo enum tags
syn keyword cedarPrimType Bool Long String Set Record Extension Entity ipaddr decimal datetime duration

" --- アノテーション @id(...) ---
syn match cedarAnnotation "@\w\+"

" --- Namespace::Type::\"id\" のうち型パス部分を色分け（`::` の直前まで） ---
syn match cedarType "\<\u\w*\%(::\u\w*\)*\ze::"

" --- 拡張関数・メソッド呼び出し ---
syn match cedarFunction "\<\%(ip\|decimal\|datetime\|duration\)\ze("
syn match cedarMethod   "\.\zs\%(isInRange\|isIpv4\|isIpv6\|isLoopback\|isMulticast\|contains\|containsAll\|containsAny\|lessThan\|lessThanOrEqual\|greaterThan\|greaterThanOrEqual\|getTag\|hasTag\)\ze("

" --- ハイライトリンク ---
hi def link cedarComment    Comment
hi def link cedarTodo       Todo
hi def link cedarString     String
hi def link cedarEscape     SpecialChar
hi def link cedarNumber     Number
hi def link cedarEffect     Statement
hi def link cedarCondition  Conditional
hi def link cedarScope      Identifier
hi def link cedarKeyword    Keyword
hi def link cedarBoolean    Boolean
hi def link cedarSchema     Structure
hi def link cedarPrimType   Type
hi def link cedarAnnotation PreProc
hi def link cedarType       Type
hi def link cedarFunction   Function
hi def link cedarMethod     Function

let b:current_syntax = "cedar"
