" Thomas Bennett's .vimrc
"------------------------------------------------------------------------------
" PREFERENCES
"------------------------------------------------------------------------------
" Allows multiple lines to be pasted correctly
"vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" startup
":NERDTreeToggle<CR>
":TlistToggle<CR>

"------------------------------------------------------------------------------
" VARIABLE SETTINGS
"------------------------------------------------------------------------------

if has('statusline')
  " always show a status line
  set laststatus=2
  set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
endif

" make sure vim sees 256 colors
set t_Co=256

" show the ruler
set ruler

" a ruler on steroids
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

if has('gui_running') 
  set guioptions-=T          " remove the toolbar
  set lines=999
  set transparency=10
  :color molokai

  if has("mac")
    set guifont=Monaco:h14
  elseif has("unix")
    "set guifont=Monospace\ 9
    set guifont=Liberation\ Mono\ 9
  elseif has("win32") || has("win64")
    set guifont=Consolas:h10:cANSI
  endif

  set cursorline
endif

:color molokai
au BufRead,BufNewFile *.twig set syntax=htmljinja

set go-=T
set backspace=indent,eol,start
set sidescrolloff=10
set nobackup
set noswapfile
"set fdm=marker
set history=50
set incsearch
set nocompatible
"set foldmethod=marker
"set foldenable
"set fdm=marker
"set foldclose=all
set nowrap
set number
set ruler
set showcmd
set showmatch
set autoindent
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set undolevels=500
set showtabline=18
"set mouse=r
set showmode
syntax on

" LESS
nnoremap ,m :w <BAR> !lessc % > %:t:r.css<CR><space>

" PATHOGEN
call pathogen#infect()
syntax on
filetype plugin indent on

"------------------------------------------------------------------------------
" KEY MAPPINGS
"------------------------------------------------------------------------------

" Symfony Keys
map ,scc :!./symfony cc<CR>
map ,sbar :!./symfony doctrine:build --all --and-load<CR>

" Wrap your crap
:vmap sem    "zdi<em><C-R>z</em><ESC>
:vmap sli    "zdi<li><C-R>z</li><ESC>
:vmap sform  "zdi<form><C-R>z</form><ESC>
:vmap sst    "zdi<strong><C-R>z</strong><ESC>
:vmap sp     "zdi<p><C-R>z</p><ESC>
:vmap sdiv   "zdi<div><C-R>z</div><ESC>
:vmap span   "zdi<span><C-R>z</span><ESC>

" Various shortcuts for working with tabs
map ,t :tabnew  
map ,c ,t<CR>:CommandT<CR>
map ,d :tabp<CR> 
map ,f :tabn<CR>

" Edit our .vimrc file
map ,vimrc :tabnew ~/.vimrc<CR><CR>

" What's been mounted?
map ,mount :!watch mount<CR>

map	,<TAB> :NERDTreeToggle<CR>
"map	,<TAB><SPACE> :TlistToggle<CR>

" working on this
map <silent>xy mk<CR>:silent<CR>yy'k

" Let's use jj as an alternative to the ESC key
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Nobody likes typing about :set nu and :set nonu to toggle line numbers
map ,# :set nu<CR>
map ,## :set nonu<CR>

" Same goes for :set wrap and set nowrap
map ,w :set wrap<CR>
map ,ww :set nowrap<CR>

" Boy, typing :w sure is a pain!
map ; :w<CR>

" Need a new line? BR below...
map brb o<ESC>k

" BR above...
map bra O<ESC>j

" search and replace
map ,sr :%s/

" c-x
map <C-x> :q<CR>

" g + direction for window change
map g <C-w>

" sort visual mode in ABC order
:nmap <F5> :g#\({\n\)\@<=#.,/}/sort<CR>

" run file with PHP CLI (CTRL-M)
:autocmd FileType php noremap <C-M> :w!<CR>:!$HOME/bin/php %<CR>

" Set TAB to allow for auto-completion (note: this RULES)
fun! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
       return "\<tab>"
    else
       return "\<c-p>"
    endif
endfun

fun! ShiftInsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
       return "\<s-tab>"
    else
       return "\<c-n>"
    endif
endfun

inoremap <tab> <c-r>=InsertTabWrapper()<CR>
inoremap <s-tab> <c-r>=ShiftInsertTabWrapper()<CR>

"------------------------------------------------------------------------------
" FILE MOVEMENT 
"------------------------------------------------------------------------------

"map <F1> :w<CR>:!sudo cp <C-R>=expand("%")<CR> /mnt/jmflava/home/jfusion/public_html/<C-R>=expand("%")<CR>

" Move It!
map <F1> :w<CR>:!php ~/bin/file_mover <C-R>=expand("%")<CR> 1<CR>
map ,up1 :w<CR>:!php ~/bin/file_mover <C-R>=expand("%")<CR> 1<CR>

"------------------------------------------------------------------------------
" PROGRAMMER SHORTCUTS
"------------------------------------------------------------------------------

" SVN
map ,com :!svn commit <C-R>=expand("%")<CR><CR>
map ,lock :!svn lock <C-R>=expand("%")<CR><CR>
map ,up :!svn update <C-R>=expand("%")<CR><CR>
map ,add :!svn add <C-R>=expand("%")<CR><CR>

" PHP
inoremap ,pif if() {<TAB><ESC>o}<ESC>kf(a
inoremap ,pwh while() {<TAB><ESC>o}<ESC>kI<ESC>f(a
inoremap ,pfe foreach($arr as $key => $val) {<RETURN><RETURN>}<ESC>2kf$a
inoremap ,pfo for($i = 0;$i < WHATEVER; $i++) {<TAB><ESC>o}<ESC>kI<ESC>f;a,
inoremap ,psw switch() {<TAB><ESC>o}<ESC>k_f(a
inoremap ,pca case '':<CR>break;<ESC>k_f"a
inoremap ,pde default:<CR>break;<ESC>k_f:a
inoremap ,psw switch() {<RETURN><RETURN>}<ESC>2k_f(a
inoremap ,pia if(isset($_REQUEST['action'])){<ESC>o<TAB>switch($_REQUEST['action']) {<ESC>o<TAB>case:<ESC>obreak;<ESC>o<RETURN>default:<ESC>obreak;<ESC>o<ESC>i<TAB>}<ESC>o<ESC>i}<ESC>6kf'a
inoremap ,pwf while($row = mysql_fetch_assoc($query)) {<ESC>o}<ESC>kf{o<TAB>
inoremap ,pqu $query = '<ESC>o';<ESC>kf'o<TAB>
inoremap ,psq $query = mysql_query($query) or die(mysql_error());<ESC>
inoremap ,pqq $query = '<RETURN><TAB>SELECT *<RETURN>FROM table<RETURN><BACKSPACE>';<RETURN><RETURN>$query = mysql_query($query) or die(mysql_error());<RETURN><RETURN>while($row = mysql_fetch_assoc($query))<RETURN>{<RETURN><TAB>$rtn[] = $row;<RETURN><BACKSPACE>}<ESC>7kf<SPACE>l
inoremap ,pts date('Y-m-d H:i:s');<ESC>o<ESC>
inoremap ,ppo $_POST['']<ESC>F'i
inoremap ,pre $_REQUEST['']<ESC>F'i
inoremap ,pge $_GET['']<ESC>F'i
inoremap ,pip $_SERVER["REMOTE_ADDR"]
inoremap ,ppr print_r();<ESC>2ha
inoremap ,prq require();<ESC>2ha
inoremap ,pfu function () {<RETURN><RETURN>}<ESC>2k_f(i

" HTML Shortcuts
inoremap ,hul <ul><RETURN><TAB><li></li><RETURN><BACKSPACE></ul><ESC>k_f>a
inoremap ,hol <ol><RETURN><TAB><li></li><RETURN><BACKSPACE></ol><ESC>k_f>a
inoremap ,hli <li></li><ESC>F>a
inoremap ,hpp <p></p><ESC>F>a
inoremap ,hdv <div></div><ESC>F>a
inoremap ,hse <select name=""><RETURN><RETURN></select><ESC>2kf"a
inoremap ,hop <option value=""></option><ESC>F"i
inoremap ,hem <em></em><ESC>F>a
inoremap ,hsr <strong></strong><ESC>F>a
inoremap ,hbr <br/>
inoremap ,hfo <form action="" id=""></form><ESC>F"i
inoremap ,hti <title></title><ESC>F>a
inoremap ,hpr <pre></pre><ESC>F>a
inoremap ,the <textarea></textarea><ESC>F>a
inoremap ,hst <style type="text/css"><RETURN><RETURN></style><ESC>ki
inoremap ,hsc <script type="text/javascript"><RETURN><RETURN></script><ESC>ki<TAB>
inoremap ,hin <input type="" value="" name="" />

" Javascript
inoremap ,jif if()<RETURN>{<ESC>o}<ESC>2kf(a
inoremap ,jwh while()<RETURN>{<ESC>o}<ESC>kI<ESC>kf(a
inoremap ,jfo for(i; i < 10; i++)<RETURN>{<ESC>o}<ESC>2kfi
inoremap ,jfi for(var in ob)<RETURN>{<ESC>o}<ESC>kI<ESC>fv
inoremap ,jtc try()<RETURN>{<RETURN><RETURN>}<ESC>2k_f(a

" CSS
inoremap ,bo border: 1px solid #000;<ESC>hhhh<ESC>cw
inoremap ,wi width:;<ESC>ha<SPACE>
inoremap ,he height:;<ESC>ha<SPACE>
inoremap ,fl float:;<ESC>ha<SPACE>
inoremap ,pa padding:;<ESC>ha<SPACE>
inoremap ,cl clear:;<ESC>ha<SPACE>
inoremap ,ba background:;<ESC>ha<SPACE>
inoremap ,cbp background-position:;<ESC>ha<SPACE>
inoremap ,fo font:;<ESC>ha<SPACE>

"------------------------------------------------------------------------------
" SEMANTAC CORRECTION
"------------------------------------------------------------------------------
abbreviate ehco echo
abbreviate qeury query
abbreviate pritn print
abbreviate GLBOASL GLOBALS
abbreviate GLBOALS GLOBALS
abbreviate GLoBALS GLOBALS
abbreviate teh the
abbreviate strDtat strData
abbreviate accesories accessories
abbreviate accomodate accommodate
abbreviate acheive achieve
abbreviate acheiving achieving
abbreviate acn can
abbreviate acommodate accommodate
abbreviate acomodate accommodate
abbreviate acommodated accommodated
abbreviate acomodated accommodated
abbreviate adn and
abbreviate agian again
abbreviate ahppen happen
abbreviate ahve have
abbreviate ahve have
abbreviate allready already
abbreviate almsot almost
abbreviate alos also
abbreviate alot a lot
abbreviate alreayd already
abbreviate alwasy always
abbreviate amke make
abbreviate anbd and
abbreviate andthe and the
abbreviate appeares appears
abbreviate aplyed applied
abbreviate artical article
abbreviate aslo also
abbreviate audeince audience
abbreviate audiance audience
abbreviate awya away
abbreviate bakc back
abbreviate balence balance
abbreviate baout about
abbreviate bcak back
abbreviate beacuse because
abbreviate becasue because
abbreviate becomeing becoming
abbreviate becuase because
abbreviate becuse because
abbreviate befoer before
abbreviate begining beginning
abbreviate beleive believe
abbreviate bianry binary
abbreviate bianries binaries
abbreviate boxs boxes
abbreviate bve be
abbreviate changeing changing
abbreviate charachter character
abbreviate charcter character
abbreviate charcters characters
abbreviate charecter character
abbreviate charector character
abbreviate cheif chief
abbreviate circut circuit
abbreviate claer clear
abbreviate claerly clearly
abbreviate cna can
abbreviate colection collection
abbreviate comany company
abbreviate comapny company
abbreviate comittee committee
abbreviate commitee committee
abbreviate committe committee
abbreviate committy committee
abbreviate compair compare
abbreviate compleated completed
abbreviate completly completely
abbreviate comunicate communicate
abbreviate comunity community
abbreviate conected connected
abbreviate cotten cotton
abbreviate coudl could
abbreviate cpoy copy
abbreviate cxan can
abbreviate danceing dancing
abbreviate definately definitely
abbreviate develope develop
abbreviate developement development
abbreviate differant different
abbreviate differnt different
abbreviate diffrent different
abbreviate disatisfied dissatisfied
abbreviate doese does
abbreviate doign doing
abbreviate doller dollars
abbreviate donig doing
abbreviate driveing driving
abbreviate drnik drink
abbreviate ehr her
abbreviate embarass embarrass
abbreviate equippment equipment
abbreviate esle else
abbreviate excitment excitement
abbreviate exmaple example
abbreviate exmaples examples
abbreviate eyt yet
abbreviate familar familiar
abbreviate feild field
abbreviate fianlly finally
abbreviate fidn find
abbreviate firts first
abbreviate follwo follow
abbreviate follwoing following
abbreviate foriegn foreign
abbreviate fro for
abbreviate foudn found
abbreviate foward forward
abbreviate freind friend
abbreviate frmo from
abbreviate fwe few
abbreviate gerat great
abbreviate geting getting
abbreviate giveing giving
abbreviate goign going
abbreviate gonig going
abbreviate govenment government
abbreviate gruop group
abbreviate grwo grow
abbreviate haev have
abbreviate happend happened
abbreviate haveing having
abbreviate hda had
abbreviate helpfull helpful
abbreviate herat heart
abbreviate hge he
abbreviate hismelf himself
abbreviate hsa has
abbreviate hsi his
abbreviate hte the
abbreviate htere there
abbreviate htey they
abbreviate hting thing
abbreviate htink think
abbreviate htis this
abbreviate hvae have
abbreviate hvaing having
abbreviate idae idea
abbreviate idaes ideas
abbreviate ihs his
abbreviate immediatly immediately
abbreviate indecate indicate
abbreviate insted intead
abbreviate inthe in the
abbreviate iwll will
abbreviate iwth with
abbreviate jsut just
abbreviate knwo know
abbreviate knwos knows
abbreviate konw know
abbreviate konws knows
abbreviate levle level
abbreviate libary library
abbreviate librarry library
abbreviate librery library
abbreviate librarry library
abbreviate liek like
abbreviate liekd liked
abbreviate liev live
abbreviate likly likely
abbreviate littel little
abbreviate liuke like
abbreviate liveing living
abbreviate loev love
abbreviate lonly lonely
abbreviate makeing making
abbreviate mkae make
abbreviate mkaes makes
abbreviate mkaing making
abbreviate moeny money
abbreviate mroe more
abbreviate mysefl myself
abbreviate myu my
abbreviate neccessary necessary
abbreviate necesary necessary
abbreviate nkow know
abbreviate nwe new
abbreviate nwo now
abbreviate ocasion occasion
abbreviate occassion occasion
abbreviate occurence occurrence
abbreviate occurrance occurrence
abbreviate ocur occur
abbreviate oging going
abbreviate ohter other
abbreviate omre more
abbreviate onyl only
abbreviate optoin option
abbreviate optoins options
abbreviate opperation operation
abbreviate orginized organized
abbreviate otehr other
abbreviate otu out
abbreviate owrk work
abbreviate peopel people
abbreviate perhasp perhaps
abbreviate perhpas perhaps
abbreviate pleasent pleasant
abbreviate poeple people
abbreviate porblem problem
abbreviate preceed precede
abbreviate preceeded preceded
abbreviate probelm problem
abbreviate protoge protege
abbreviate puting putting
abbreviate pwoer power
abbreviate quater quarter
abbreviate questoin question
abbreviate reccomend recommend
abbreviate reccommend recommend
abbreviate receieve receive
abbreviate recieve receive
abbreviate recieved received
abbreviate recomend recommend
abbreviate reconize recognize
abbreviate recrod record
abbreviate religous religious
abbreviate rwite write
abbreviate rythm rhythm
abbreviate selectoin selection
abbreviate sentance sentence
abbreviate seperate separate
abbreviate shineing shining
abbreviate shiped shipped
abbreviate shoudl should
abbreviate similiar similar
abbreviate smae same
abbreviate smoe some
abbreviate soem some
abbreviate sohw show
abbreviate soudn sound
abbreviate soudns sounds
abbreviate statment statement
abbreviate stnad stand
abbreviate stopry story
abbreviate stoyr story
abbreviate stpo stop
abbreviate strentgh strength
abbreviate struggel struggle
abbreviate sucess success
abbreviate swiming swimming
abbreviate tahn than
abbreviate taht that
abbreviate talekd talked
abbreviate tath that
abbreviate teh the
abbreviate tehy they
abbreviate tghe the
abbreviate thansk thanks
abbreviate themselfs themselves
abbreviate theri their
abbreviate thgat that
abbreviate thge the
abbreviate thier their
abbreviate thme them
abbreviate thna than
abbreviate thne then
abbreviate thnig thing
abbreviate thnigs things
abbreviate thsi this
abbreviate thsoe those
abbreviate thta that
abbreviate tihs this
abbreviate timne time
abbreviate tje the
abbreviate tjhe the
abbreviate tkae take
abbreviate tkaes takes
abbreviate tkaing taking
abbreviate tlaking talking
abbreviate todya today
abbreviate tongiht tonight
abbreviate tonihgt tonight
abbreviate towrad toward
abbreviate tpyo typo
abbreviate truely truly
abbreviate tyhat that
abbreviate tyhe the
abbreviate useing using
abbreviate veyr very
abbreviate vrey very
abbreviate waht what
abbreviate watn want
abbreviate wehn when
abbreviate whcih which
abbreviate whic which
abbreviate whihc which
abbreviate whta what
abbreviate wief wife
abbreviate wierd weird
abbreviate wihch which
abbreviate wiht with
abbreviate windoes windows
abbreviate withe with
abbreviate wiull will
abbreviate wnat want
abbreviate wnated wanted
abbreviate wnats wants
abbreviate woh who
abbreviate wohle whole
abbreviate wokr work
abbreviate woudl would
abbreviate wriet write
abbreviate wrod word
abbreviate wroking working
abbreviate wtih with
abbreviate wya way
abbreviate yera year
abbreviate yeras years
abbreviate ytou you
abbreviate yuo you
abbreviate yuor your
abbreviate yoru your
abbreviate sunday Sunday
abbreviate monday Monday
abbreviate tuesday Tuesday
abbreviate wednesday Wednesday
abbreviate thursday Thursday
abbreviate friday Friday
abbreviate saturday Saturday
