-- Cedar 診断（nvim-lint）
-- Cedar には公式 LSP が無いため、cedar-wasm ベースの検証(validate 相当)を
-- 外部 linter として噛ませ、保存/読込/挿入抜け時に inline 診断を出す。
-- 診断源は petting-zoo の cage(src/cli.mjs lint)。cage が無い環境では黙ってスキップ。
local CEDAR_CLI = vim.fn.expand("~/dev/petting-zoo/cedar/src/cli.mjs")

return {
  "mfussenegger/nvim-lint",
  ft = { "cedar" }, -- ftdetect が *.cedar / *.cedarschema を cedar に割り当てる
  config = function()
    local lint = require("lint")

    -- `node <cli> lint <file>` → `file:line:col: severity: message` を errorformat で拾う。
    lint.linters.cedar = {
      cmd = "node",
      args = { CEDAR_CLI, "lint" },
      stdin = false,
      append_fname = true,
      stream = "stdout",
      ignore_exitcode = true,
      parser = require("lint.parser").from_errorformat(
        "%f:%l:%c: %t%*[^:]: %m",
        { source = "cedar" }
      ),
    }

    local function run()
      if vim.fn.filereadable(CEDAR_CLI) == 1 then
        lint.try_lint("cedar")
      end
    end

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("CedarLint", { clear = true }),
      pattern = { "*.cedar", "*.cedarschema" },
      callback = run,
    })
    -- ft ロードのトリガーとなった現在バッファは上記 autocmd を取り逃すので一度明示実行。
    vim.schedule(run)
  end,
}
