local nnoremap = require("jamie.keymap").nnoremap
local nmap = require("jamie.keymap").nmap
local imap = require("jamie.keymap").imap
local tnoremap = require("jamie.keymap").tnoremap
local inoremap = require("jamie.keymap").inoremap
nmap("f", "<Plug>Sneak_f")
nmap("F", "<Plug>Sneak_F")
nmap("t", "<Plug>Sneak_t")
nmap("T", "<Plug>Sneak_T")
nnoremap("<leader>fo", "<cmd>lua vim.lsp.buf.format()<CR>")
inoremap("<C-o>f", "<C-o>:call Toword()<CR>")
nnoremap("<leader>cluster", ":Nread scp://jds@uhhpc.herts.ac.uk//beegfs/car/jds/gandalftest/mk_stars/")
inoremap("<C-o>t", "<C-o>f")
inoremap("<C-o>b", "<C-o>T")
nnoremap("-", "<CMD>Oil<CR>")
inoremap("<C-o>B", "<C-o>F")
inoremap("<C-o>o", "<C-o>*")
inoremap("<up>", "<ESC><up>")
inoremap("<down>", "<ESC><down>")


inoremap("<C-s>", "<ESC>:%s//&/gc<left><left><left><left><left>")

nnoremap("<leader>;", ":")
nnoremap(",p", "p")
nnoremap(",P", "P")
nnoremap("<leader><left>", "<cmd>TmuxNavigateLeft<CR>")
nnoremap("<leader><right>", "<cmd>TmuxNavigateRight<CR>")
nnoremap("<leader><up>", "<cmd>TmuxNavigateUp<CR>")
nnoremap("<leader><down>", "<cmd>TmuxNavigateDown<CR>")
-- nnoremap("<leader><left>", "<cmd>wincmd h<CR>")
-- nnoremap("<leader><right>", "<cmd>wincmd l<CR>")
-- nnoremap("<leader><up>", "<cmd>wincmd k<CR>")
-- nnoremap("<leader><down>", "<cmd>wincmd j<CR>")
nnoremap("<leader>v", "<cmd>vs<CR>")
nnoremap("<leader>h", "<cmd>split<CR>")
nnoremap("<leader>l", "<cmd>on<CR>")
nnoremap("p", '"0p')
nnoremap("P", '"0P')
nnoremap("<left>", "h")
nnoremap("<up>", "gk")
nnoremap("<down>", "gj")
nnoremap("<right>", "l")
nnoremap("j", "10j")
nnoremap("k", "10k")
tnoremap("<ESC>", "<C-\\><C-n>")
nnoremap("<leader><BS>", "dT")
nnoremap("<leader>d", "df")
nnoremap("<leader>as", ":s///g<left><left>&<left><left>")
nnoremap("<leader>ss", ":%s///g<left><left>&<left><left>")
nnoremap("<BS>", "b")
nnoremap("<leader><leader>", "w")
nnoremap("<leader>su", "ddggP``")
nnoremap("J", "<Plug>(CybuPrev)")
nnoremap("K", "<Plug>(CybuNext)")
nnoremap("<leader>sd", "ddGp``")
inoremap("<C-i>", "<ESC>")
nnoremap("<leader>qq", "<cmd>q<CR>")
nnoremap("<leader>te", "<cmd>FloatermNew<CR>")
nnoremap("<leader>tt", "<cmd>FloatermToggle<CR>")
nnoremap("<leader>te", "<cmd>FloatermNew<CR>")
tnoremap("<leader>tt", "<C-\\><C-n><cmd>FloatermToggle<CR>")
nnoremap("<leader>nn", "<C-w>w")
-- nmap("<C-n>", "<Plug>BujoAddnormal")
-- imap("<C-n>", "<Plug>BujoAddinsert")
-- nmap("<C-d>", "<Plug>BujoChecknormal")
-- imap("<C-d>", "<Plug>BujoCkeckinsert")
nnoremap("<leader>dn", "<Plug>Bujochecknormal")
nnoremap("<leader>to", "<cmd>botright Todo<CR>")
nnoremap("<leader>tg", "<cmd>botright Todo g<CR>")
nnoremap("<C-s>", "<cmd>w<CR>")
-- nnoremap("<leader>bb", "<cmd>bnext<CR>")
nnoremap("<leader>ff", ":Telescope find_files<CR>")
nnoremap("<leader>fg", ":Telescope live_grep<CR>")
nnoremap("<leader>up", "ddkP")
nnoremap("<leader>fb", ":Telescope file_browser<CR>")
inoremap("<C-w>", "<C-\\><C-o>dB")
inoremap("<C-h>", "<C-\\><C-o>dB")
