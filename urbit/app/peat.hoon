::  peat - backup and restore socials
::  by quartus
::
/-  *peat,
    post,
    res=resource,
    store=graph-store,
    metas=metadata-store,
    d=diary,
    h=heap,
    c=chat,
    g=groups
/+  agentio,
    default-agent,
    dbug,
    multipart,
    plib=peat,
    *server
::
|%
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==
::  $state-1: reducing complexity
::
+$  state-1
  $:  %1
  ::
    $=  saved
    $:  graphs=(map resource [=shape:graphs (pair @da @dr)])
        diaries=(map flag:d (pair @da @dr))
        chats=(map flag:c (pair @da @dr))
        heaps=(map flag (pair @da @dr))
    ==
  ::
    $=  known
    $:
      $=  graphs
      $:  chats=(jug (unit flag) flag)
          notes=(jug (unit flag) flag)
          halls=(jug (unit flag) flag)
          dms=resource
      ==
    ::
      $=  groups
      $:  chats=(jug flag flag)
          diaries=(jug flag flag)
          heaps=(jug flag flag)
      ==
    ==


  ==
::
::  $state-0: see last version
::
+$  state-0
  $:  %0
      saved=(map resource [@da @dr])
      given=(jag ship shape resource)
      doled=(jag ship shape resource)
      known=(jag shape (unit resource) resource)
  ==
--
::
%-  agent:dbug
=|  state-1
=*  state  -
^-  agent:gall
=<
  |_  =bowl:gall
  +*  this  .
      def   ~(. (default-agent this %|) bowl)
      gen    ~(. +> bowl)
  ::
  ++  on-init
    ^-  (quip card _this)
    ~>  %bout.[0 '%hari +on-init']
    =^  cards  state
      abet:init:gen
    [cards this]
  ::
  ++  on-save
    ^-  vase
    ~>  %bout.[0 '%hari +on-save']
    !>(state)
  ::
  ++  on-load
    |=  ole=vase
    ~>  %bout.[0 '%hari +on-load']
    ^-  (quip card _this)
    =^  cards  state
      abet:(load:gen ole)
    [cards this]
  ::
  ++  on-poke
    |=  [mar=mark vaz=vase]
    ~>  %bout.[0 '%hari +on-poke']
    ^-  (quip card _this)
    =^  cards  state
      abet:(poke:gen mar vaz)
    [cards this]
  ::
  ++  on-peek
    |=  =path
    ~>  %bout.[0 '%hari +on-peek']
    ^-  (unit (unit cage))
    [~ ~]
  ::
  ++  on-arvo
    |=  [wir=wire sig=sign-arvo]
    ~>  %bout.[0 '%hari +on-arvo']
    ^-  (quip card _this)
    =^  cards  state
      abet:(arvo:gen wir sig)
    [cards this]
  ::
  ++  on-agent
    |=  [wir=wire sig=sign:agent:gall]
    ~>  %bout.[0 '%hari +on-agent']
    ^-  (quip card _this)
    =^  cards  state
      abet:(dude:gen wir sig)
    [cards this]
  ::
  ++  on-watch
  |=  pat=path
  ~>  %bout.[0 '%hari +on-watch']
  ^-  (quip card _this)
  =^  cards  state
    abet:(peer:gen pat)
  [cards this]
  ::
  ++  on-fail
    ~>  %bout.[0 '%hari +on-fail']
    on-fail:def
  ++  on-leave
    ~>  %bout.[0 '%hari +on-init']
    on-leave:def
  --
|_  [bol=bowl:gall dek=(list card)]
+*  dat   .
    dok   [our.bol %groups]
    dia   [our.bol %diary]
    hep   [our.bol %heap]
    cha   [our.bol %chat]
    gra   [our.bol %graph-store]
    our   (scot %p our.bol)
    now   (scot %da now.bol)
::  +abet: flop the dek, produce [dek state]
::
++  abet  [(flop dek) state]
::  +emit: add a single card to the dek
::
++  emit  |=(=card dat(dek [card dek]))
::  +emil: add a list of cards to the dek
::
++  emil  |=(lac=(list card) dat(dek (welp lac dek)))
::  +tick: tick-tock, next second
::
++  tick  (emit [%pass /tock %arvo %b %wait +(now.bol)])
::  +next: set next timer for recurring save
::
++  next
  |=  [f=flag t=@dr]
  =+  pat=/peat/(scot %p p.f)/[q.f]/(scot %dr t)
  (emit %pass pat %arvo %b %wait (add now.bol t))
::  +eyre: connect eyre
::
++  eyre
  %-  emit
  [%pass /eyre %arvo %e %connect `/apps/peat/upload dap.bol]
::  +show: forward to web-ui
::
++  show  |=(=cage (emit [%give %fact ~[/web-ui] cage]))
::  +init: on-init
::
++  init
  ^+  dat
  %-  (slog leaf+"%peat started" ~)
  (emil:eyre ~[watch:groups watch:graphs])
::  +dude: on-agent handler
::
++  dude
  |=  [pol=(pole knot) sig=sign-arvo]
  ?+    pol  ~(bad-or-old-wire/pol !!)
      [%peat %keys dude=@ ~]
    ?+    (scot %tas dude.pol)  ~|(bad-keys/dude !!)
        %group
      ?+    -.sig  dat
        %fact  (fact:groups cage.sig)
        %kick  (emit watch:groups)
      ::
          %watch-ack
        %.  dat
        ?~  p.sig  same
        (slog 'peat can\'t watch groups - maybe kick' ~)
      ==
    ::
        %graph
      ?+    -.sig  dat
        %fact  (fact:graphs cage.sig)
        %kick  (emit watch:graphs)
      ::
          %watch-ack
        %.  dat
        ?~  p.sig  same
        (slog 'peat can\'t watch graphs - maybe kick' ~)
      ==
    ==
  ==
::  +arvo: on-arvo handler
::
++  arvo
  |=  [pol=(pole knot) sig=sign-arvo]
  ?+    pol  ~(bad-wire-arvo/pol !!)
      [%eyre ~]
    ?>  ?=([%eyre %bound *] sig)
    %.  dat
    ?:  accepted.sign  same
    (slog leaf+"%peat-fail -bind-eyre-for-import" ~)
  ::
      [%tock ~]
    ?>  ?=([%wake *] sig)
    %.  churn
    ?~  p.sig  same
    (slog leaf+"%peat-fail -behn-fail-wat-happen" u.p.sig)
  ::
      [%peat who=@ wat=@ wen=@ ~]
    ?.  ?=([%behn %wake *] sig)  ~|(weird-sign-arvo/sig !!)
    =+  who=(slav %p who.pol)
    =+  wat=(slav %tas wat.pol)
    =+  wen=(slav %dr wen.pol)
    =+  las=(need (last:scry who wat))
    ?~  hav=(~(get by graphs.saved) [who wat])  dat
    ?^  error.sig
      =.  graphs.saved  (~(del by saved) [who wat])
      %.  dat  %-  slog
      :~  leaf+"%peat-fail -a-timer-broke"
          leaf+"-check-resource [{<who>} {<wat>}]"
      ==
    ?.  =(wen q.u.hav)  dat



    
  ==
::  +groups: groups handling
::
++  groups
  |%
  ++  watch
    [%pass /peat/keys/groups %agent dok %watch /groups]
  ++  scry
    |%
    ++  cha-p   /[our]/chat/[now]
    ++  dia-p   /[our]/diary/[now]
    ++  hea-p   /[our]/heap/[now]
    ++  gro-p   /[our]/groups/[now]
    ::
    ++  chats   .^(chats:c %gx (weld cha-p /chats/noun))
    ++  shelf   .^(shelf:d %gx (weld dia-p /shelf/noun))
    ++  stash   .^(stash:h %gx (weld hea-p /stash/noun))
    ++  groups  .^(groups:g %gx (weld gro-p /groups/noun))
    --
  ::  +setup: one time double-loop to get all channels
  ::
  ++  setup
    =/  groups=(list [flag group:g])
      ~(tap by groups:scry)
    |-  ^+  dat
    ?~  groups  dat
    =/  channels=(list [nest:g c=channel:g])
      ~(tap by channels.i.groups)
    %=    $
      groups  t.groups
    ::
        state
      |-  ^+  state
      ?~  channels  state
      %=  $
        channels  t.channels
      ::
          state
        =+  new=[-.i.groups q.i.channels]
        =,  groups.known
        ?+    p.i.channels
            %chat
          state(chats.groups.known (~(put ju chats) new))
            %heap
          state(heaps.groups.known (~(put ju heaps) new))
            %diary
          state(diaries.groups.known (~(put ju diaries) new))
        ==
      ==
    ==
  ::  +fact: handle incoming facts
  ::
  ++  fact
    |=  [mar=mark vaz=vase]
    ^+  dat
    ?+    mark  dat
        %group-leave
      =/  f=flag  !<(flag vaz)
      =,  groups.known
      %.  peat-groups-change+!>([%rem %all & f])
      %=  show
        chats.groups.known    (~(del by chats) f)
        heaps.groups.known    (~(del by heaps) f)
        diaries.groups.known  (~(del by diaries) f)
      ==
    ::
        %group-action
      =/  act=action:g  !<(action:g vaz)
      ?+    -.q.q.act
          %del
        =,  groups.known
        %.  peat-groups-change+!>([%rem %all & p.act])
        %=  show
          chats.groups.known    (~(del by chats) p.act)
          heaps.groups.known    (~(del by heaps) p.act)
          diaries.groups.known  (~(del by diaries) p.act)
        ==
      ::
          %channel
        =,  groups.known
        =+  new=[p.act q.p.q.q.act]
        ?:  ?=([%del ~] q.q.q.act)
          ?+    p.p.q.q.act  dat
              %chat
            %.  peat-groups-change+!>([%rem %chat | new])
            show(chats.groups.known (~(del ju chats) new))
          ::
              %heap
            %.  peat-groups-change+!>([%rem %heap | new]
            show(heaps.groups.known (~(del ju heaps) new))
          ::
              %diary
            %.  peat-groups-change+!>([%rem %diary | new]
            show(diaries.groups.known (~(del ju diaries) new))
          ==
        ?.  ?=([%add *] q.q.q.act)  dat
        ?+    p.p.q.q.act  dat
            %chat
          %.  peat-groups-chage+!>([%add %chat | new])
          show(chats.groups.known (~(put ju chats) new))
        ::
            %heap
          %.  peat-groups-chage+!>([%add %chat | new])
          show(heaps.groups.known (~(put ju heaps) new))
        ::
            %diary
          %.  peat-groups-chage+!>([%add %chat | new])
          show(diaries.groups.known (~(put ju diaries) new))
        ==
      ==
    ==
  --
++  graphs
  |%
  ++  watch
    [%pass /peat/keys/graphs %agent gra %watch /keys]
  ++  scry
    |%
    ++  gra-p  /[our]/graph-store/[now]
    ++  gro-p  /[our]/group-store/[now]
    ++  met-p  /[our]/metadata-store/[now]
    ::
    ++  test
      ^-  [gra=? gro=? met=?]
      =;  online=$-(dude:gall ?)
        :+  (online [%graph-store %.y])
          (online [%group-store %.y])
        (online [%metadata-store %.y])
      |=  =dude:gall
      .^(? %gu /[our]/[dude]/[now])
    ++  keys
      ^-  (set flag)
      ?.  gra.test  ~
      =;  upd=update:store
        ?>  ?=(%keys -.q.upd)
        resources.q.upd
      .^(update:store %gx (weld gra-p /keys/noun))
    ++  meta
      ^-  (map md-resource:metas assocation:metas)
      ?.  met.test  ~
      ?.  gro.test  ~
      .^  (map md-resource:metas association:metas)
        %gx
        (weld met-p /associations/noun)
      ==
    ++  mark
      |=  flag
      ^-  (unit term)
      ?.  gra.test  ~
      .^  (unit term)
        %gx
        (weld gra-p /graph/(scot %p p)/[q]/mark)
      ==
    ++  last
      |=  flag
      ;;  (unit time)
      .^  *
        %gx
        (weld gra-p /update-log/(scot %p p)/[q]/latest/noun)
      ==
    --
  ++  meta
    |=  f=flag
    ^-  (unit flag)
    ?~(h=(~(get by meta:scry) [%graph f]) ~ `group.u.h)
  ++  fact
    |=  [mar=mark vaz=vase]
    ?.  ?=(%graph-update-3 mar)  dat
    =/  upd=update:store  !<(update:store vaz)
    ?+    -.q.upd  dat
      %keys          tick
      %remove-graph  tick
    ==
  ++  run-thread
    |=  flag
    %-  emit
    :+  %pass  /peat/do/exp/(scot %p p)/[q]
    [%arvo %k %fard %peat %disk-out %noun !>([bol [p q]])]
  ++  cancel
    |=  flag
    ^+  dat
    =.  graphs.saved
      (~(del by graphs.saved) [p q])
    (show re-graph+!>([%cancel [p q]]))
  ++  import
    |=  [p=path g=(each flag term) n=term]
    |^  ^+  dat
      =/  arc=arch
        .^(arch %cy (welp /[our]/peat/[now]/hav p))
      ?<  |((~(has in keys:scry) [our.bol n]) ?=(~ dir.arc))
      =+  jams=~(tap in dir.arc)
      ?~  lid=(rush p:(head jams) ;~((glue cab) sym sym dem))
        ~|(bad-files-found/p:(head jams) !!)
      =/  sap=shape:graphs
        ?+  +<.u.lid  !!
          %dm       ;;(shape:graphs +<.u.lid)
          %chat     ;;(shape:graphs +<.u.lid)
          %link     ;;(shape:graphs +<.u.lid)
          %publish  ;;(shape:graphs +<.u.lid)
        ==
      ?-  sap
        %dm  (dm jams)
      ::
          ?(%chat %link %publish)
        (do jams ?:(-.g p.g [our.bol p.g]) [our.bol n])
      ==
    ++  dm
      |=  dem=(list [p=@t q=?])
      =|  q=(map index node:store)
      |-
      ?~  dem
        
    --
  ++  export
    |=  [=flag fuse=(unit @dr)]
    ^+  dat
    ?>  (~(has in keys:scry) flag)
    ?~  fuse
      %-  show:(run-thread flag)
      re-graph+!>([%export flag fuse]
    =?    u.fuse
        (lth u.fuse ~h12)
      ~h12
    ?~  ole=(~(get by graphs.saved) flag)
      =;  sap=shape:graphs
        =.  graphs.saved
          %-  ~(put by graphs.saved)
          [flag [sap ~2000.1.1 u.fuse]]
        %-  show:(run-thread flag)
        re-graph+!>([%export flag fuse]
      %+  rash  (need (mark:scry flag))
      ;~  pfix
        (jest 'graph-validator-')
        (cook |=(@tas ;;(shape:graphs +<)) sym)
      ==
    ?<  =(q.u.ole u.fuse)
    =.  graphs.saved
      %-  ~(put by graphs.saved)
      [flag [shape.u.ole p.u.ole u.fuse]]
    %-  show:(run-thread flag)
    re-graph+!>([%export flag fuse])
  ++  churn
    =+  mine=~(tap in keys:scry)
    =.  graphs.known  [~ ~ ~ [our.bol %dm-inbox]]
    |-  ^+  dat
    ?~  mine  (show known-graphs+!>(graphs.known))
    ?~  mar=(mark:scry i.mine)  $(mine t.mine)
    %=  $
      mine t.mine
    ::
        state
      ?+    u.mar  state
          %graph-validator-dm
        ?.  ?=([our.bol %dm-inbox] i.mine)  state
        state(dms.graphs.known i.mine)
      ::
          %graph-validator-chat
        %=    state
            chats.graphs.known
          %-  ~(put ju chats.graphs.known)
          [(meta i.mine) i.mine]
        ==
      ::
          %graph-validator-link
        %=    state
            halls.graphs.known
          %-  ~(put ju halls.graphs.known)
          [(meta i.mine) i.mine]
        ==
      ::
          %graph-validator-publish
        %=    state
            notes.graphs.known
          %-  ~(put ju notes.graphs.known)
          [(meta i.mine) i.mine]
        ==
      ==
    ==
  --
--





  ++  on-arvo
    |=  [=wire sign=sign-arvo]
    :: ~>  %bout.[0 'on-arvo-peat']
    ^-  (quip card _this)
    ?+    wire  (on-arvo:def wire sign)
        [%init ~]
      :_  this
      ~[(~(connect pass /eyre) [~ /apps/peat/upload] %peat)]
        [%eyre ~]
      ?>  ?=([%eyre %bound *] sign)
      ?:  accepted.sign  `this
      %.  `this
      (slog leaf+"%peat-fail -binding-eyre-for-import" ~)
    ::
        [%keys ~]
      ::  we're using a delay to avoid a timing issue
      ::  with watching /keys on %graph-store.
      ::  the timing issue is a result of constructing
      ::  groups and graphs simultaneously in one series
      ::  of pokes, rather than using threads that allow
      ::  for new events.
      ::
      =.  known  
        %-  ~(car (ba shape (unit resource) resource) ~)
        (murn ~(tap in llaves:pek:pl) mippet:pek:pl)
      :_  this
      =-  [%give %fact ~[/website] json+!>(`json`-)]~
      (frond:enjs:format known+(jagon:john:hc %known))
    ::
        [%peat @ @ @ ~]
      =*  ent  (slav %p i.t.wire)
      =*  nam  (slav %tas i.t.t.wire)
      =*  fre  (slav %dr i.t.t.t.wire)
        ::
      =/  las=time
        %-  need  ;;  (unit time)
        =-  (gra-s:pek:pl * -)
        /update-log/(scot %p ent)/(scot %tas nam)/latest
        ::
      ?.  ?=([%behn %wake *] sign)  (on-arvo:def wire sign)
      ?~  error.sign
        ?~  hab=(~(get by saved) [ent nam])  `this
        ?.  =(fre +.u.hab)  `this
        =^  cards  state
          (export:pete:hc [ent nam] ~)
        [cards this(saved (~(put by saved) [ent nam] [las fre]))]
      =.  saved
        (~(del by saved) [ent nam])
      %.  `this  %-  slog
      :~  leaf+"%peat-fail -a-timer-broke"
          leaf+"-check-resource [{<ent>} %{<nam>}]"
      ==
    ::
        [%peat %do *]
      ?+    t.t.wire  (on-arvo:def wire sign)
          [%exp @ @ ~]
        ?.  ?=([%khan %arow %& *] sign)
          ?>  ?=([%khan %arow %| @ *] sign)
          ((slog tang.p.p.+.sign) `this)
        ?>  ?=(%noun -.p.p.sign)
        =/  res=resource
          [(slav %p i.t.t.t.wire) (slav %tas i.t.t.t.t.wire)]
        =/  tim=time  !<(time +.p.p.+.sign)
        ?~  cur=(~(get by saved) res)
          :_  this
          =-  [%give %fact ~[/website] json+!>(`json`-)]~
          %+  frond:enjs:format  'diff-export'
          %-  pairs:enjs:format
          :~  last+(sect:enjs:format tim)
            :-  'resource'
              %-  pairs:enjs:format
              :~  name+s+(scot %tas name.res)
                  entity+s+(scot %p entity.res)
              ==
            ::
              frequency+s+'once'
          ==
        =.  saved
          (~(put by saved) res [tim +.u.cur])
        :_  this
        :~  =-  [%give %fact ~[/website] json+!>(`json`-)]
            %+  frond:enjs:format  'diff-export'
            %-  pairs:enjs:format
            :~  last+(sect:enjs:format tim)
                :-  'resource'
                %-  pairs:enjs:format
                :~  name+s+(scot %tas name.res)
                    entity+s+(scot %p entity.res)
                ==
              ::
                :-  'frequency'
                =+  yep=(yell +.u.cur)
                %-  pairs:enjs:format
                :~  ['days' n+(scot %ud d.yep)]
                    ['hours' n+(scot %ud h.yep)]
                    ['minutes' n+(scot %ud m.yep)]
                ==
            ==
          ::
            :+  %pass  /peat/(scot %p -.res)/[+.res]/(scot %dr +.u.cur)
            [%arvo %b [%wait (add now.bowl +.u.cur)]]
        ==
      ==
    ==














  ::
  ++  on-init
    ^-  (quip card _this)
    :: ~>  %bout.[0 'on-init-peat']
    %-  (slog leaf+"%peat-init" ~)
    ::=.  known
    ::  %.  (murn ~(tap in llaves:pek:pl) mippet:pek:pl)
    ::  ~(car (ba shape (unit ,resource) resource) known)
    :_  this
    :~  :^  %pass  /peat/keys  %agent
        [[our.bowl %graph-store] %watch /keys]
        (~(wait pass /init) now.bowl)
    ==
  ::
  ++  on-save
    ^-  vase
    !>(state)
  ::
  ++  on-load
    |=  ole=vase
    :: ~>  %bout.[0 'on-load-peat']
    ^-  (quip card _this)
    =/  old=versioned-state  !<(versioned-state ole)
    |^  ^-  (quip card _this)
    |-
    ?-  -.old
     %0  
     :_  this(state old)
     :(welp check-watch fix-timers set-timers)
    ==
    ++  check-watch
     ?:  %-  ~(has in wex.bowl)
         [[/peat/keys our.bowl %graph-store] [%.y /keys]]
       ~
     =-  [%pass /peat/keys %agent -]~
     [[our.bowl %graph-store] %watch /keys]
    ++  fix-timers
      %+  murn
        .^  (list [@da duct])
          %bx
          /(scot %p our.bowl)//(scot %da now.bowl)/debug/timers
        ==
      |=  [t=@da lw=duct]
      ?~  lw
        ~
      ?.  ?=([%gall %use %peat @ @ %peat @ @ @ ~] i.lw)
        ~
      `[%pass t.t.t.t.t.i.lw %arvo %b %rest t]
    ++  set-timers
      %-  ~(rep by saved.old)
      |=  [[k=resource v=[@da @dr]] o=(list card)]
      =/  wir=path
        /peat/(scot %p entity.k)/[name.k]/(scot %dr +.v)
      [[%pass wir %arvo %b %wait (add now.bowl +.v)] o]
    --
  ::
  ++  on-poke
    |=  [=mark =vase]
    :: ~>  %bout.[0 'on-poke-peat']
    ^-  (quip card _this)
    ?+    mark  (on-poke:def mark vase)
        %handle-http-request
      =+  !<([id=@ta req=inbound-request:eyre] vase)
      =^  cards  state
        (handle-http-request:hc id req)
      [cards this]
        %peat-repete
     =/  pete=repete  !<(repete vase)
     =^  cards  state
        ?-  -.pete
            %export
          ?>  (team:title our.bowl src.bowl)  
          (export:pete:hc res.pete rec.pete)
            %cancel
          ?>  (team:title our.bowl src.bowl)  
          (cancel:pete:hc res.pete)
            %import
          ?>  (team:title our.bowl src.bowl)  
          (import:pete:hc fol.pete gro.pete wer.pete)
        ::
            %permit
          ?>  (team:title our.bowl src.bowl)  
          (permit:pete:hc per.pete rys.pete)
            %record                                     ::  note: only foreign allowed
          ?>(!=(our.bowl src.bowl) record:pete:hc)
            %remove
          ?>  (team:title our.bowl src.bowl)  
          (remove:pete:hc per.pete rys.pete)
            %depart
          ?>  (team:title our.bowl src.bowl)  
          (depart:pete:hc p.pete)
        ::
            %remake
          ?>  (team:title our.bowl src.bowl)  
          (remake:pete:hc wat.pete gro.pete wer.pete)
        ::
            %relay
          ?>  (team:title our.bowl src.bowl)
          :_  state
          [%give %fact ~[/website] json+!>(`json`jon.pete)]~
        ==
      [cards this]
    ==
  ::
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    ^-  (quip card _this)
    =,  enjs:format
    ?+    wire  `this
        [%ogertalk %peat @ ~]
      ?>  =(src.bowl (slav %p +>-.wire))
      ?+    -.sign  (on-agent:def wire sign)
          %watch-ack
        ?~  =(~ p.sign)  `this
        =.  given
          (~(del by given) src.bowl)
        :_  this
        =-  [%give %fact ~[/website] json+-]~
        !>(`json`(frond given+(jagon:john:hc %given)))
      ::
          %kick
        :_  this
        =-  [%pass /ogertalk/peat/(scot %p src.bowl) -]~
        [%agent [src.bowl %peat] %watch /ogertalk/peat]
      ::
          %fact
        ?.  =(%peat-peep p.cage.sign)  !!
        =/  pep=peep  !<(peep q.cage.sign)
        ?-    -.pep
            %kil
          ?.  (~(has in to.pep) our.bowl)  `this
          ?^  sup.pep
            ?.  %.  res.pep
                ~(has in (~(get ba-s given) src.bowl u.sup.pep))
             `this
            =.  given
              (~(del ba-s given) src.bowl u.sup.pep res.pep)
            :_  this
            =-  [%give %fact ~[/website] json+!>(`json`-)]~
            =-  (frond:enjs:format diff-kil+(pairs -))
            :~  ship+s+(scot %p src.bowl)
                shape+s+(scot %tas u.sup.pep)
                resources+a+(gibbs:john:hc src.bowl u.sup.pep)
            ==
          =/  tag=(list [p=@p q=shape r=resources])
            ~(tap (ba @p shape resource) given)
          =|  mag=@tas
          |-
          ?~  tag
            :_  this
            =-  [%give %fact ~[/website] json+!>(`json`-)]~
            =-  (frond diff-kil+(pairs -))
            :~  ship+s+(scot %p src.bol)
                shape+s+(scot %tas mag)
                resources+a+(gibbs:john:hc src.bowl ;;(shape mag))
            ==
          =?    given
              (~(has in r.i.tag) res.pep)
            (~(del ba-s given) src.bowl q.i.tag res.pep)
          =?    mag
              (~(has in r.i.tag) res.pep)
            q.i.tag
          $(tag t.tag)
        ::
            %hav
          ?.  (~(has in to.pep) our.bowl)  `this
          =+  kez=~(tap in ~(key by raj.pep))
          =|  caz=(list card)
          |-
          ?~  kez  [caz this]
          =.  given
            %+  ~(put-s ba-s given)  src.bowl
            [i.kez (~(get ju raj.pep) i.kez)]
          %=    $
            kez  t.kez
          ::
              caz
            :_  caz
            =-  [%give %fact ~[/website] json+!>(`json`-)]
            =-  %+  frond  'diff-hav'
                (frond (scot %p src.bowl) (pairs -))
            :~  ship+s+(scot %p src.bowl)
                shape+s+(scot %tas i.kez)
                resources+a+(gibbs:john:hc src.bowl i.kez)
            ==
          ==
        ==
      ==
    ::
        [%remake @ @ @ *]                               ::  partial path parsing,
      =/  n=resource  [our.bowl (slav %tas i.t.wire)]   ::    see below
      =+  s=;;(shape (slav %tas i.t.t.wire))
      ?-    -.sign                                      ::  we quiet pass on
        %kick       `this                               ::    kick, watch-ack, 
        %watch-ack  `this                               ::    and poke-ack
      ::                                                ::  to avoid duplication
        %poke-ack   `this                               ::  and wutlus
      ::
          %fact
        ?.  ?=(%jam p.cage.sign)
          ~_(leaf+"%peat-fail -bad-fact-on-remake" !!)
        =+  gra=;;(graph:store (cue !<(@ q.cage.sign)))
        ?+    t.t.t.t.wire  (on-agent:def wire sign)    ::  finish path parsing
            ~
          :_  this
          ;:  welp
            (add-to-new-group:biz:pl n s (slav %tas i.t.t.t.wire))
          ::
            =-  [%give %fact ~[/website] json+!>(`json`-)]~
            %+  frond  'diff-remake'
            %-  pairs
            :~  :-  'group'
                %-  pairs
                :~  entity+s+(scot %p our.bowl)
                    name+s+(scot %tas i.t.t.t.wire)
                ==
              ::
                :-  'resource'
                %-  pairs
                :~  entity+s+(scot %p our.bowl)
                    name+s+(scot %tas name.n)
                ==
            ==
          ::
            =;  [pat=^path nod=cage]
              [%pass pat %agent [our.bowl %graph-store] %poke nod]~
            :-  /import/[+.n]/(scot %da now.bowl)
            :-  %graph-update-3
            !>  ^-  update:store
            :^  (add now.bowl ~s1)  %add-nodes  n
            ^-  (map index node:store)
            %-  ~(rep by gra)
            |=  [[a=atom n=node:store] q=(map index node:store)]
            ?.(?=(%.y -.post.n) q (~(put by q) index.p.post.n n))
          ==
        ::
            [@ ~]
          :_  this
          ;:  welp
            %^  add-to-old-group:biz:pl  n  s
            :-  (slav %p i.t.t.t.wire)
            (slav %tas i.t.t.t.t.wire)
          ::
            =-  [%give %fact ~[/website] json+!>(`json`-)]~
            %+  frond  'diff-remake'
            %-  pairs
            :~  :-  'group'
                %-  pairs
                :~  entity+s+i.t.t.t.wire
                    name+s+i.t.t.t.t.wire
                ==
              ::
                :-  'resource'
                %-  pairs
                :~  entity+s+(scot %p our.bowl)
                    name+s+(scot %tas name.n)
                ==
            ==
          ::
            =;  [pat=^path nod=cage]
              [%pass pat %agent [our.bowl %graph-store] %poke nod]~
            :-  /import/[+.n]/(scot %da now.bowl)
            :-  %graph-update-3
            !>  ^-  update:store
            :^  (add now.bowl ~s1)  %add-nodes  n
            ^-  (map index node:store)
            %-  ~(rep by gra)
            |=  [[a=atom n=node:store] q=(map index node:store)]
            ?.(?=(%.y -.post.n) q (~(put by q) index.p.post.n n))
          ==
         ==
      ==
    ::
        [%peat %keys ~]
      ?+    -.sign  `this
          %kick
        :_  this
        =-  [%pass /peat/keys %agent -]~
        [[our.bowl %graph-store] %watch /keys]
      ::
          %fact
        ?.  ?=(%graph-update-3 p.cage.sign)  `this
        =/  upd=update:store  !<(update:store q.cage.sign)
        ?+    -.q.upd  `this
            %remove-graph
          =*  ent  (scot %p entity.resource.q.upd)
          =*  nam  (scot %tas name.resource.q.upd)
          =/  gnon=(unit [s=shape g=(unit resource)])
            %+  reel  ~(tap ba-k known)
            |=  $:  p=[s=shape g=(unit resource) r=resources]
                    q=(unit [s=shape g=(unit resource)])
                ==
            ?:(!(~(has in r.p) resource.q.upd) q `[s.p g.p])
          =?    known
              ?=(^ gnon)
            %.  [s.u.gnon g.u.gnon resource.q.upd]
             ~(del (ba shape (unit resource) resource) known)
            ::
          =/  fren=(list [p=@p s=shape])
            %~  tap  in
            %+  reel  ~(tap ba-s doled)
            |=  $:  p=[p=@p s=shape r=resources]
                    q=(set [p=@p s=shape])
                ==
            ^+  q
            ?:  !(~(has in r.p) resource.q.upd)  q
            (~(put in q) [p.p s.p])
          =+  who=~(key by (malt fren))
          |-
          ?~  fren
            :_  this
            =-  [%give %fact ~[/ogertalk/peat] peat-peep+-]~
            !>  ^-  peep
            [%kil who resource.q.upd ?.(?=(^ gnon) ~ `s.u.gnon)]
          %=    $
            fren   t.fren
          ::
              doled  
            (~(del ba-s doled) p.i.fren s.i.fren resource.q.upd)
          ==
        ::
            %keys
          :: =.  known
          ::   %-  ~(car (ba shape (unit resource) resource) ~)
          ::   (murn ~(tap in resources.q.upd) mippet.pek.pl)
          :: :_  this
          :: =-  [%give %fact ~[/website] json+!>(`json`-)]~
          :: (frond known+(jagon:john:hc %known))
          :_  this
           ~[(~(wait pass /keys) now.bowl)]
        ==
      ==
    ==
  ::
  ++  on-watch
    |=  =path
    :: ~>  %bout.[0 'on-watch-peat']
    ^-  (quip card _this)
    ?+    path  (on-watch:def path)
        [%http-response *]
      ?>  (team:title our.bowl src.bowl)
      `this
        [%ogertalk %peat ~]
      ?>  (~(has by doled) src.bowl)
      :_  this
      =-  [%give %fact ~ %peat-peep !>(`peep`-)]~
      [%hav (sy ~[src.bowl]) (~(got by doled) src.bowl)]
    ::
        [%website ~]
        ?>  (team:title our.bowl src.bowl)
      :_  this
      =-  [%give %fact ~ json+!>(`json`-)]~
      %-  pairs:enjs:format
      :~  saved+shave:john:hc
          given+(jagon:john:hc %given)
          doled+(jagon:john:hc %doled)
          known+(jagon:john:hc %known)
      ==
    ::
        [%remake @ @ @ ~]
      =/  r=resource
        [(slav %p i.t.path) (slav %tas i.t.t.path)]
      =+  s=;;(shape (slav %tas i.t.t.t.path))
      ?.  (~(has in (~(gut ba-s doled) src.bowl s ~)) r)
        ~_(leaf+"%peat-fail -wrong-permissions" !!)
        ::
      =/  upd=update:store
        =-  (gra-s:pek:pl update:store -)
        /graph/(scot %p -.r)/(scot %tas +.r)
      ?>  ?=(%add-graph -.q.upd)
      :_  this
      :~  [%give %fact ~ [%jam !>(`@`(jam graph.q.upd))]]
          [%give %kick ~ `src.bowl]
      ==
    ==
  ::
  ++  on-peek
    |=  =path
    :: ~>  %bout.[0 'on-peek-peat']
    ^-  (unit (unit cage))
    =*  frond  frond:enjs:format
    =*  pairs  pairs:enjs:format
    ?+    path  (on-peek:def path)
      ::  wholes
    ::  saved all
        [%x %saved ~]
      ``[%json !>(`json`(frond saved+shave:john:hc))]
    ::  given all
        [%x %given ~]
      ``[%json !>(`json`(frond given+(jagon:john:hc %given)))]
    ::  doled all
        [%x %doled ~]
      ``[%json !>(`json`(frond doled+(jagon:john:hc %doled)))]
    ::  known all
        [%x %known ~]
      ``[%json !>(`json`(frond known+(jagon:john:hc %known)))]
      ::  searches
    ::  given (ship)
        [%x %given @ ~]
      =/  who=@p  (slav %p i.t.t.path)
      =-  ``[%json !>(`json`-)]
      %-  pairs
      %+  turn  ~(tap by (~(gut by given) who ~))
      |=  [s=shape rs=resources]
      :-  s  :-  %a
      %+  turn  ~(tap in rs)
      |=  [e=@p n=@tas]
      (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
    ::  doled (ship)
        [%x %doled @ ~]
      =/  who=@p  (slav %p i.t.t.path)
      =-  ``[%json !>(`json`-)]
      %-  pairs
      %+  turn  ~(tap by (~(gut by doled) who ~))
      |=  [s=shape rs=resources]
      :-  s  :-  %a
      %+  turn  ~(tap in rs)
      |=  [e=@p n=@tas]
      (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
    ::  known (shape)
        [%x %known @ ~]
      =/  wat=shape  ;;(shape (slav %tas i.t.t.path))
      =-  ``[%json !>(`json`-)]
      %-  pairs
      %+  turn  ~(tap by (~(gut by known) wat ~))
      |=  [g=(unit resource) rs=resources]
      :-  ?~(g 'ungrouped' name.u.g)  :-  %a
      %+  turn  ~(tap in rs)
      |=  [e=@p n=@tas]
      (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
    ::  given (ship) (shape)
        [%x %given @ @ ~]
      =/  who=@p  (slav %p i.t.t.path)
      =+  wic=;;(shape (slav %tas i.t.t.t.path))
      =-  ``[%json !>(`json`-)]
      :-  %a
      %+  turn
        %~  tap  in
        (~(gut by (~(gut by given) who ~)) wic ~)
      |=  [e=@p n=@tas]
      (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
    ::  doled (ship) (shape)
        [%x %doled @ @ ~]
      =/  who=@p  (slav %p i.t.t.path)
      =+  wic=;;(shape (scot %tas i.t.t.t.path))
      =-  ``[%json !>(`json`-)]
      :-  %a
      %+  turn
        %~  tap  in
        (~(gut by (~(gut by doled) who ~)) wic ~)
      |=  [e=@p n=@tas]
      (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
    ::  known (shape) (unit resource)
        [%x %known @ *]
      =/  wat=shape  ;;(shape (slav %p i.t.t.path))
      ?+    t.t.t.path  !!
          ~
        =-  ``[%json !>(`json`-)]
        :-  %a
        %+  turn
          ~(tap in (~(gut by (~(gut by known) wat ~)) ~ ~))
        |=  [e=@p n=@tas]
        (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
      ::
          [@ @ ~]
        =+  wer=(slav %p i.t.t.t.path)
        =+  wut=(slav %tas i.t.t.t.t.path)
        =-  ``[%json !>(`json`-)]
        :-  %a
        %+  turn  %~  tap  in
          (~(gut by (~(gut by known) wat ~)) `[wer wut] ~)
        |=  [e=@p n=@tas]
        (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
      ==
      ::  supporting cast
    ::
        [%x %admin ~]
      =-  ``[%json !>(`json`(frond am-admin+a+-))]
      %-  ~(rep in groups:pek:pl)
      |=  [r=resource l=(list json)]
      :_  l  %-  pairs
      ~[entity+s+(scot %p entity.r) name+s+(scot %tas name.r)]
    ::
        [%x %hav ~]
      =-  ``[%json !>(`json`(frond available+a+-))]
      %+  turn  ~(tap by stacks:pek:pl)
      |=  [s=shape av=(set [n=@tas l=@ud])]
      %-  pairs
      :~  shape+s+(scot %tas s)
        ::
          :-  'resources'
          :-  %a
          %+  turn  ~(tap in av)
          |=  [n=@tas l=@ud]
          %-  pairs
          :~  resource+s+(scot %tas n)
              length+(numb:enjs:format l)
          ==
      ==
    ==
  ++  on-arvo
    |=  [=wire sign=sign-arvo]
    :: ~>  %bout.[0 'on-arvo-peat']
    ^-  (quip card _this)
    ?+    wire  (on-arvo:def wire sign)
        [%init ~]
      :_  this
      ~[(~(connect pass /eyre) [~ /apps/peat/upload] %peat)]
        [%eyre ~]
      ?>  ?=([%eyre %bound *] sign)
      ?:  accepted.sign  `this
      %.  `this
      (slog leaf+"%peat-fail -binding-eyre-for-import" ~)
    ::
        [%keys ~]
      ::  we're using a delay to avoid a timing issue
      ::  with watching /keys on %graph-store.
      ::  the timing issue is a result of constructing
      ::  groups and graphs simultaneously in one series
      ::  of pokes, rather than using threads that allow
      ::  for new events.
      ::
      =.  known  
        %-  ~(car (ba shape (unit resource) resource) ~)
        (murn ~(tap in llaves:pek:pl) mippet:pek:pl)
      :_  this
      =-  [%give %fact ~[/website] json+!>(`json`-)]~
      (frond:enjs:format known+(jagon:john:hc %known))
    ::
        [%peat @ @ @ ~]
      =*  ent  (slav %p i.t.wire)
      =*  nam  (slav %tas i.t.t.wire)
      =*  fre  (slav %dr i.t.t.t.wire)
        ::
      =/  las=time
        %-  need  ;;  (unit time)
        =-  (gra-s:pek:pl * -)
        /update-log/(scot %p ent)/(scot %tas nam)/latest
        ::
      ?.  ?=([%behn %wake *] sign)  (on-arvo:def wire sign)
      ?~  error.sign
        ?~  hab=(~(get by saved) [ent nam])  `this
        ?.  =(fre +.u.hab)  `this
        =^  cards  state
          (export:pete:hc [ent nam] ~)
        [cards this(saved (~(put by saved) [ent nam] [las fre]))]
      =.  saved
        (~(del by saved) [ent nam])
      %.  `this  %-  slog
      :~  leaf+"%peat-fail -a-timer-broke"
          leaf+"-check-resource [{<ent>} %{<nam>}]"
      ==
    ::
        [%peat %do *]
      ?+    t.t.wire  (on-arvo:def wire sign)
          [%exp @ @ ~]
        ?.  ?=([%khan %arow %& *] sign)
          ?>  ?=([%khan %arow %| @ *] sign)
          ((slog tang.p.p.+.sign) `this)
        ?>  ?=(%noun -.p.p.sign)
        =/  res=resource
          [(slav %p i.t.t.t.wire) (slav %tas i.t.t.t.t.wire)]
        =/  tim=time  !<(time +.p.p.+.sign)
        ?~  cur=(~(get by saved) res)
          :_  this
          =-  [%give %fact ~[/website] json+!>(`json`-)]~
          %+  frond:enjs:format  'diff-export'
          %-  pairs:enjs:format
          :~  last+(sect:enjs:format tim)
            :-  'resource'
              %-  pairs:enjs:format
              :~  name+s+(scot %tas name.res)
                  entity+s+(scot %p entity.res)
              ==
            ::
              frequency+s+'once'
          ==
        =.  saved
          (~(put by saved) res [tim +.u.cur])
        :_  this
        :~  =-  [%give %fact ~[/website] json+!>(`json`-)]
            %+  frond:enjs:format  'diff-export'
            %-  pairs:enjs:format
            :~  last+(sect:enjs:format tim)
                :-  'resource'
                %-  pairs:enjs:format
                :~  name+s+(scot %tas name.res)
                    entity+s+(scot %p entity.res)
                ==
              ::
                :-  'frequency'
                =+  yep=(yell +.u.cur)
                %-  pairs:enjs:format
                :~  ['days' n+(scot %ud d.yep)]
                    ['hours' n+(scot %ud h.yep)]
                    ['minutes' n+(scot %ud m.yep)]
                ==
            ==
          ::
            :+  %pass  /peat/(scot %p -.res)/[+.res]/(scot %dr +.u.cur)
            [%arvo %b [%wait (add now.bowl +.u.cur)]]
        ==
      ==
    ==
  ++  on-leave
    |=  =path
    :: ~>  %bout.[0 'on-leave-peat']
    ^-  (quip card _this)
    ?:  ?=([%website ~] path)  `this
    ?.  ?=([%ogertalk %peat ~] path)  !!
    =.  doled
      (~(del by doled) src.bowl)
    :_  this
    =-  [%give %fact ~[/website] json+!>(`json`-)]~
    (frond:enjs:format doled+(jagon:john:hc %doled))
  ++  on-fail  on-fail:def
  --
  ::
|_  bol=bowl:gall
+*  ba-k  (ba shape (unit resource) resource)
    ba-s  (ba @p shape resource)
    pl    ~(. plib bol)
::  khan helpers
::
++  kirk
  |%
  ++  tricorder
    |=  [pat=path ted=@tas cay=cage]
    ^-  card
    [%pass pat %arvo [%k %fard %peat ted cay]]
  --
::  json helpers
::
++  john
  =,  enjs:format
  |%
  ::  +gibbs - got a new resource from a friend
  ::
  ++  gibbs
    |=  [p=@p s=shape]
    :: ~>  %bout.[0 'gibbs-john']
    ^-  (list json)
    %+  turn  ~(tap in (~(get (ba _p _s resource) given) p s))
    |=  r=resource
    (pairs ~[entity+s+(scot %p entity.r) name+s+name.r])
  ::  +jagon - shorthand for turning gupps/mupps
  ::
  ++  jagon
    |=  t=?(%given %doled %known)
    |^
    :: ~>  %bout.[0 'jagon-john']
      ^-  json
      ?-  t
        %given  a+(turn ~(tap ba-s given) gupps)
        %doled  a+(turn ~(tap ba-s doled) gupps)
        %known  a+(turn ~(tap ba-k known) mupps)
      ==
    ::  +gupps - translate (jag ship shape resource)
    ::
    ++  gupps
      |=  [p=@p q=shape r=resources]
      :: ~>  %bout.[0 'gupps-jagon--john']
      ^-  json
      =,  enjs:format
      %+  frond  (scot %p p)
      %-  pairs
      :~  shape+s+(scot %tas q)
      ::
        :-  'resources'
        :-  %a
        %+  turn  ~(tap in r)
        |=  [e=@p n=@tas]
        %-  pairs
        ~[entity+s+(scot %p e) name+s+(scot %tas n)]
      ==
    ::  +mupps - translate (jag shape (unit resource resource))
    ::
    ++  mupps
      |=  [q=shape g=(unit resource) r=resources]
      :: ~>  %bout.[0 'mupps-jagon-john']
      ^-  json
      =,  enjs:format
      %+  frond  (scot %tas q)
      %-  pairs
      :~
        :-  'group'
        ?~  g  s+'ungrouped'
        %-  pairs
        :~  entity+s+(scot %p entity.u.g)
            name+s+(scot %tas name.u.g)
        ==
      ::
        :-  'resources'
        :-  %a
        %+  turn  ~(tap in r)
        |=  [e=@p n=@tas]
        %-  pairs
        ~[ship+s+(scot %p e) name+s+(scot %tas n)]
      ==
    --
  ::  +shave - all saved
  ::
  ++  shave
    ^-  json
    =/  shav=(list [r=resource [i=@da f=@dr]])
      ~(tap by saved)
    =|  twins=(list [@t json])
    :: ~>  %bout.[0 'shave-john']
    |-
    ?~  shav  (pairs twins)
    =+  yep=(yell f.i.shav)
    %=    $
      shav  t.shav
    ::
        twins
      :_  twins
      :-  ;;(@t +:(sect i.i.shav))
      ^-  json
      %-  pairs
      ^-  (list [@t json])
      :~  ['entity' `json`s+(scot %p entity.r.i.shav)]
          ['name' `json`s+(scot %tas name.r.i.shav)]
        ::
          :-  'frequency'
          %-  pairs 
          :~  ['days' n+(scot %ud d.yep)]
              ['hours' n+(scot %ud h.yep)]
              ['minutes' n+(scot %ud m.yep)]
          ==
        ::
          ['last-index-captured' (sect i.i.shav)]
      ==
    ==
  --
::  repeat helpers
::
++  pete
  |%
  ++  export
    |=  [r=resource b=(unit @dr)]
    ^-  (quip card _state)
    :: ~>  %bout.[0 'export-pete']
    ?>  (~(has in llaves:pek:pl) r)                     ::  the resource must exist
    =/  coz=card:agent:gall
      :+  %pass  /peat/do/exp/(scot %p -.r)/[+.r]
      [%arvo %k %fard %peat %disk-out %noun !>([bol r])]
    ?~  b
      [~[coz] state]
    =?    u.b
        (lth u.b ~h12)
      ~h12
    ?~  rep=(~(get by saved) r)
      =.  saved
        (~(put by saved) r [~2000.1.1 u.b])
      [~[coz] state]
    ::
    ?<  =(u.b +.u.rep)
    =.  saved
      (~(put by saved) r [-.u.rep u.b])
    [~[coz] state]
  ++  cancel
    |=  r=resource
    :: ~>  %bout.[0 'cancel-pete']
    ^-  (quip card _state)
    =.  saved  (~(del by saved) r)
    :_  state
    =-  [%give %fact ~[/website] json+!>(`json`-)]~
    %+  frond:enjs:format  'diff-cancel-export'
    %-  pairs:enjs:format
    :~  entity+s+(scot %p entity.r)
        name+s+(scot %tas name.r)
    ==
  ::
  ++  import
    |=  [f=path g=(each resource @tas) n=@tas]
    |^  ^-  (quip card _state)
    :: ~>  %bout.[0 'import-pete']
      =/  arc=arch  (arc-s:pek:pl f)
      ?<  (~(has in llaves:pek:pl) [our.bol n])
      ?>  !?=(~ dir.arc)
      =+  dis=~(tap in dir.arc)
      ?~  nos=(rush p:(head dis) ;~((glue cab) sym sym dem))
       ~_(leaf+"%peat-fail -indeterminate-shape" !!)
      =/  sap=shape
       ?+  +<.u.nos  !!
         %dm       ;;(?(%chat %link %publish %dm) +<.u.nos)
         %chat     ;;(?(%chat %link %publish %dm) +<.u.nos)
         %link     ;;(?(%chat %link %publish %dm) +<.u.nos)
         %publish  ;;(?(%chat %link %publish %dm) +<.u.nos)
       ==
      :_  state
      ^-  (list card)
      ?:  ?=(%dm sap)
        (add-dm dis)
      ?.  ?=(%.y -.g)
       ?<  (~(has in groups:pek:pl) [our.bol p.g])
       ;:  welp
         (add-to-new-group:biz:pl [our.bol n] sap p.g)
         (web-do [our.bol p.g] [our.bol n] f)
         (imp-do dis [our.bol p.g] [our.bol n])
        ==
       ::
      ?>  (~(has in groups:pek:pl) p.g)
      ;:  welp
        (add-to-old-group:biz:pl [our.bol n] sap p.g)
        (web-do p.g [our.bol n] f)
        (imp-do dis p.g [our.bol n])
      ==
    ++  web-do
      |=  [g=resource r=resource f=path]
      :: ~>  %bout.[0 'web-do-import-pete']
      ^-  (list card)
      =/  pat=path
        %-  weld  :_  f
        /(scot %p our.bol)/peat/(scot %da now.bol)/hav
      =-  [%give %fact ~[/website] json+!>(`json`-)]~
      %+  frond:enjs:format  'diff-import'
      %-  pairs:enjs:format
      :~  path+(path:enjs:format pat)
          :-  'group'
          %-  pairs:enjs:format
          :~  entity+s+(scot %p entity.g)
              name+s+(scot %tas name.g)
          ==
        ::
          :-  'resource'
          %-  pairs:enjs:format
          :~  entity+s+(scot %p entity.r)
              name+s+(scot %tas name.r)
          ==
      ==
    ++  add-dm                                          ::  reconcile dms (slide in)
      |=  p=(list [p=@t q=~])
      :: ~>  %bout.[0 'add-do-import-pete']
      =|  q=(map index node:store)
      |-
      ?~  p
        %.  :~
              :+  %pass   /import/dm-inbox/(scot %da now.bol)
              :+  %agent  [our.bol %graph-store]
              :+  %poke   %graph-update-3
              !>  ^-  update:store
              [now.bol %add-nodes [our.bol %dm-inbox] q]
            ==
        %-  slog
        :~  '%peat-import'
            '-reconciling-dms'
            leaf+"-imported-dms"
        ==
      =;  old=graph:store
        %=    $
          p  t.p
        ::
            q
          ^+  q
          %-  ~(uni by q)  ^+  q
          %-  ~(rep by old)
          |=  [[a=atom n=node:store] q=(map index node:store)]
          ?.  ?=(%.y -.post.n)  q
          ?:  %+  gra-s:pek:pl  ?
              %+  weld
                /graph/(scot %p our.bol)/dm-inbox/node/exists
              (turn index.p.post.n (cury scot %ud))
            q
          (~(put by q) index.p.post.n n)
        ==
      %-  malt
      ;;  (list [atom node:store])
      %-  cue
      .^  @   %cx 
        ;:  weld
          /(scot %p our.bol)/peat/(scot %da now.bol)/hav
          f
          /[p.i.p]
          /jam
        ==
      ==
    ++  imp-do
      |=  [p=(list [p=@t q=~]) g=resource r=resource]
      :: ~>  %bout.[0 'imp-do-import-pete']
      ^-  (list card)
      =|  q=(list card)
      |-
      ?~  p
        %.  q
        %-  slog
        :~  '%peat-import'
            '-import-starting'
            leaf+"-group: [{<entity.g>} {<name.g>}]"
            leaf+"-resource: [{<entity.r>} {<name.r>}]"
        ==
      =;  old=graph:store
        %=    $
          p  t.p
        ::
            q
         :_  q  
        ::  If you're reading this and you're upset w/ the remapping of references
        ::  just restore the code below and comment out the alternative, beneath.
        ::  Also, call your mother.
        ::   %-  ~(rep by old)
        ::   |=  [[a=atom n=node:store] q=(map index node:store)]
        ::   ?.(?=(%.y -.post.n) q (~(put by q) index.p.post.n n(signatures.p.post ~)))
        :: ==
          =-  :+  %pass   /import/[+.r]/(scot %da now.bol)
              :+  %agent  [our.bol %graph-store]
              :+  %poke   %graph-update-3
              !>  ^-  update:store
              [now.bol %add-nodes r -]
          %-  ~(rep by old)
          |=  [[a=atom n=node:store] q=(map index node:store)]
          ?.  ?=(%.y -.post.n)  q
          =+  pb=p.post.n
          =/  old-rid=@tas  (slav %tas -.f)
          =.  p.post.n
            =-  p.post.n(contents -)
            %+  turn  contents.p.post.n
            |=  con=content
            ?.  ?=([%reference [%graph [@ @] [[@ @] *]]] con)  con
            ?.  =(old-rid +.resource.uid.reference.con)  con
            [%reference %graph g [r index.uid.reference.con]]
          =?    hash.p.post.n
              !=(pb p.post.n)
            ^-  (unit @ux)
            :-  ~  ;;  @ux
            (sham [~ author.p.post.n time-sent.p.post.n contents.p.post.n])
          =?    signatures.p.post.n
              ?|  .^(? %j /(scot %p our.bol)/fake/(scot %da now.bol))
                  !=(pb p.post.n)
              ==
            ~
          (~(put by q) index.p.post.n n)
        ==

      %-  malt
      ;;  (list [atom node:store])
      %-  cue
      .^  @   %cx 
        ;:  weld
          /(scot %p our.bol)/peat/(scot %da now.bol)/hav
          f
          /[p.i.p]
          /jam
        ==
      ==
    --
  ::
  ++  permit
    |=  [pr=(set ship) rs=(set resource)]
    :: ~>  %bout.[0 'permit-pete']
    ^-  (quip card _state)
    =/  nugiv=(jug shape resource)
      %-  ~(rep in rs)
      |=  [r=resource j=(jug shape resource)]
      =;  s=shape
        (~(put ju j) s r)
      %+  rash  %-  need
        %+  gra-s:pek:pl  (unit @tas)
        /graph/(scot %p entity.r)/(scot %tas name.r)/mark
      ;~  pfix
        (jest 'graph-validator-')
        (cook |=(@tas ;;(shape +<)) sym)
      ==
    =/  gibbs=(list [ship shape (set resource)])
      %-  zing
      %+  turn  ~(tap in pr)
      |=(p=@p (turn ~(tap by nugiv) (lead p)))
    =.  doled
      (~(gas ba-s doled) gibbs)
    :_  state
    :+  =-  [%give %fact ~[/website] json+!>(`json`-)]
        (frond:enjs:format doled+(jagon:john %doled))
      =-  [%give %fact ~[/ogertalk/peat] -]
      peat-peet+!>(`peep`[%hav pr nugiv])
    %-  ~(rep in pr)
    |=  [s=@p l=(list card)]
    :_  l
    :^  %pass  /ogertalk/record  %agent
    :^  [s %peat]  %poke  %peat-repete
    !>(`repete`[%record ~])
  ::
  ++  record
    ^-  (quip card _state)
    :: ~>  %bout.[0 'record-pete']
    :_  state
    =-  [%pass /ogertalk/peat/(scot %p src.bol) -]~
    [%agent [src.bol %peat] %watch /ogertalk/peat]
  ::
  ++  remove
    |=  [pr=(set ship) rs=(set resource)]
    :: ~>  %bout.[0 'remove-pete']
    ^-  (quip card _state)
    =/  nutak=(jug shape resource)
      %-  ~(rep in rs)
      |=  [r=resource j=(jug shape resource)]
      =;  s=shape
          (~(put ju j) s r)
      %+  rash  %-  need
      %+  gra-s:pek:pl  (unit @tas)
        /graph/(scot %p entity.r)/(scot %tas name.r)/mark
      ;~  pfix
        (jest 'graph-validator-')
        (cook |=(@tas ;;(shape +<)) sym)
      ==
    =/  takes=(list [s=ship q=shape r=resources])
      %-  zing
      %+  turn  ~(tap in pr)
      |=(p=@p (turn ~(tap by nutak) (lead p)))
    =|  cop=(list card)
    |-
    ?~  takes
      :_  state
      :_  cop
      =-  [%give %fact ~[/website] json+!>(`json`-)]
      (frond:enjs:format doled+(jagon:john %doled))
    %=    $
      doled  (~(del-s ba-s doled) s.i.takes q.i.takes r.i.takes)
      takes  t.takes
    ::
        cop
      %+  welp  cop
      %-  ~(rep in r.i.takes)
      |=  [r=resource l=(list card)]
      :_  l
      =-  [%give %fact ~[/ogertalk/peat] -]
      peat-peep+!>(`peep`[%kil pr r `q.i.takes])
    ==
  ::
  ++  remake
    |=  $:  w=(each resource [p=ship q=shape r=resource])
            g=(each resource term)
            n=term
        ==
    :: ~>  %bout.[0 'remake-pete']
    ^-  (quip card _state)
    ?<  (~(has in llaves:pek:pl) [our.bol n])
    ?:  ?=(%.y -.w)                                     ::  local case first
      ?>  (~(has in llaves:pek:pl) p.w)
      =/  mip=[q=shape *]
        (need (mippet:pek:pl p.w))
      =/  upd=update:store
        =-  (gra-s:pek:pl update:store -)
        /graph/(scot %p entity.p.w)/(scot %tas name.p.w)
      ?>  ?=(%add-graph -.q.upd)
      :_  state
      ?.  ?=(%.y -.g)
        ?<  (~(has in groups:pek:pl) [our.bol p.g])
        %+  snoc
          ^-  (list card)
          (add-to-new-group:biz:pl [our.bol n] q.mip p.g)
        =-  :^  %pass  /import/[n]/(scot %da now.bol)  %agent
            [[our.bol %graph-store] %poke %graph-update-3 -]
        !>  ^-  update:store
        :^  (add now.bol ~s1)  %add-nodes  [our.bol n]
        ^-  (map index node:store)
        %-  ~(rep by graph.q.upd)
        |=  [[a=atom n=node:store] q=(map index node:store)]
        ?.  ?=(%.y -.post.n)  q
        =+  pb=p.post.n
        =.  p.post.n
          =-  p.post.n(contents -)
          %+  turn  contents.p.post.n
          |=  con=content
          ?.  ?=([%reference [%graph [@ @] [[@ @] *]]] con)  con
          ?.  =(+.w resource.uid.reference.con)  con
          :^  %reference  %graph  [our.bol p.g]
          [`resource`[our.bol ^n] index.uid.reference.con]
        =?    hash.p.post.n
            !=(pb p.post.n)
          ^-  (unit @ux)
          :-  ~  ;;  @ux
          (sham [~ author.p.post.n time-sent.p.post.n contents.p.post.n])
        =?    signatures.p.post.n
            ?|  .^(? %j /(scot %p our.bol)/fake/(scot %da now.bol))
                !=(pb p.post.n)
            ==
          ~
        (~(put by q) index.p.post.n n)
        ::
      ?>  (~(has in groups:pek:pl) p.g)
      %+  snoc
        ^-  (list card)
        (add-to-old-group:biz:pl [our.bol n] q.mip p.g)
      =-  :^  %pass  /import/[n]/(scot %da now.bol)  %agent
          [[our.bol %graph-store] %poke %graph-update-3 -]
      !>  ^-  update:store
      :^  (add now.bol ~s1)  %add-nodes  [our.bol n]
      ^-  (map index node:store)
      %-  ~(rep by graph.q.upd)
      |=  [[a=atom n=node:store] q=(map index node:store)]
      ?.  ?=(%.y -.post.n)  q
      =+  pb=p.post.n
      =.  p.post.n
        =-  p.post.n(contents -)
        %+  turn  contents.p.post.n
        |=  con=content
        ?.  ?=([%reference [%graph [@ @] [[@ @] *]]] con)  con
        ?.  =(+.w resource.uid.reference.con)  con
        :^  %reference  %graph  p.g
        [`resource`[our.bol ^n] index.uid.reference.con]
      =?    hash.p.post.n
          !=(pb p.post.n)
        ^-  (unit @ux)
        :-  ~  ;;  @ux
        (sham [~ author.p.post.n time-sent.p.post.n contents.p.post.n])
      =?    signatures.p.post.n
          ?|  .^(? %j /(scot %p our.bol)/fake/(scot %da now.bol))
              !=(pb p.post.n)
          ==
        ~
      (~(put by q) index.p.post.n n)
    ?>  %.  r.p.w                                       ::  now remote case
        ~(has in (~(gut ba-s given) p.p.w q.p.w ~))
    =*  ent  (scot %p entity.r.p.w)
    =*  nam  (scot %tas name.r.p.w)
    =*  new  (scot %tas n)
    =*  sap  (scot %tas q.p.w)
    :_  state
    =-  [%pass -> %agent [p.p.w %peat] %watch -<]~
    :-  [%remake ent nam sap ~]
    ?.  ?=(%.y -.g)
      ?<  (~(has in groups:pek:pl) [our.bol p.g])
      [%remake new sap (scot %tas p.g) ~]
    ?>  (~(has in groups:pek:pl) p.g)
    [%remake new sap (scot %p entity.p.g) (scot %tas name.p.g) ~]
  ::
  ++  depart
    |=  p=ship
    :: ~>  %bout.[0 'depart-pete']
    ^-  (quip card _state)
    :_  state(given (~(del by given) p))
    :~  =-  [%give %fact ~[/website] json+!>(`json`-)]
        (frond:enjs:format diff-left+s+(scot %p p))
      ::
        [%pass /ogertalk/peat/(scot %p p) %agent [p %peat] %leave ~]
    ==
  --
++  handle-http-request
  |=  [eyre-id=@ta inbound-request:eyre]
  ^-  (quip card _state)
  =;  [payload=simple-payload:http caz=(list card) =_state]
    :_  state
    (weld caz (give-simple-payload:app eyre-id payload))
  =*  headers  header-list.request
  =/  req-line  (parse-request-line url.request)
  |^  ?+  method.request  [[405^~ ~] ~ state]
        %'GET'   [[200^~ `(make-upload-page ~)] ~ state]
        %'POST'  take-upload-post
      ==
  ++  take-upload-post
    ^-  [simple-payload:http (list card) _state]
    ?~  parts=(de-request:multipart [header-list body]:request)
      =-  [[400^~ `(make-upload-page -)] ~ state]
      ~['Missing Data in POST - Complete Form']
    =/  form=(each (each resource term) ~)              :: (each extant-group nu-group-name)
      (coax-repete-form (malt u.parts))
    =/  shap=(each [shape @tas] ~)                      :: (each [shape old-resource-name] ~)
      (coax-prior-shape u.parts)
    =/  rizo=(each term ~)                              ::  (each new-resource-name ~)
      (coax-import-name (malt u.parts))
    ?.  &(?=(%& -.form) ?=(%& -.shap) ?=(%& -.rizo))
      =-  [[400^~ `(make-upload-page -)] ~ state]
      ~['Missing Data in POST - Try recompleting the form']
    =;  [cards=(list card) msg=(list @t)]
      =-  [[200^~ `(make-upload-page -)] cards state]
      ?~(msg ~['Upload Completed Successfully'] msg)
      ::
    =/  jams=(list jam)
      %+  murn  u.parts
      |=  [n=@t p=part:multipart]
      ?.(=('files' n) ~ [~ `jam`body:p])
    ?>  ?=(^ jams)
    =*  mc5  ~(. kick-out-the-jams [p.form +.p.shap p.rizo jams])
    ?:  ?=(%dm -.p.shap)
      :-  dm-do:mc5
      ~['%peat-import' '-reconciling-dms' '-importing-dms']
    ?.  ?=(%& -.p.form)
      ?<  (~(has in groups:pek:pl) [our.bol p.p.form])
      :-  %-  welp  :_  imp-do:mc5
          (add-to-new-group:biz:pl [our.bol p.rizo] -.p.shap p.p.form)
      :~  '%peat-import'
          '-import-starting'
          (crip "-group: [{<our.bol>} {<p.p.form>}]")
          (crip "-resource: [{<our.bol>} {<p.rizo>}]")
      ==
    ?>  (~(has in groups:pek:pl) p.p.form)
    :-  %-  welp  :_  imp-do:mc5
        (add-to-old-group:biz:pl [our.bol p.rizo] -.p.shap p.p.form)
    :~  '%peat-import'
        '-import-starting'
        (crip "-group: [{<entity.p.p.form>} {<name.p.p.form>}]")
        (crip "-resource: [{<our.bol>} {<p.rizo>}]")
    ==
  ++  kick-out-the-jams
    |_  [gr=(each resource term) ol=term ne=term ja=(list jam)]
    ++  dm-do
      ^-  (list card)
      =|  q=(map index node:store)
      |-  ?~  ja
        :~  :+  %pass   /import/dm-inbox/(scot %da now.bol)
            :+  %agent  [our.bol %graph-store]
            :+  %poke   %graph-update-3
            !>  ^-  update:store
            [now.bol %add-nodes [our.bol %dm-inbox] q]
        ==
      %=    $
        ja  t.ja
      ::
          q
        ^+  q
        %-  ~(uni by q)  ^+  q
        %-  ~(rep by (malt ;;((list [atom node:store]) (cue i.ja))))
        |=  [[a=atom n=node:store] q=(map index node:store)]
        ?.  ?=(%& -.post.n)  q
        ?:  %+  gra-s:pek:pl  ?
            %+  weld  /graph/(scot %p our.bol)/dm-inbox/node/exists
            (turn index.p.post.n (cury scot %ud))
          q
        (~(put by q) index.p.post.n n)
      ==
    ++  imp-do
      ^-  (list card)
      =|  q=(list card)
      |-  ?~  ja  q
      %=    $
        ja  t.ja
      ::
          q  
        ^+  q
        :_  q
        =-  :+  %pass   /import/[ol]/(scot %da now.bol)
            :+  %agent  [our.bol %graph-store]
            :+  %poke   %graph-update-3
            !>  ^-  update:store
            [now.bol %add-nodes [our.bol ne] -]
        ::  If you're reading this and you're upset w/ the remapping of references
        ::  just restore the code below and comment out the alternative, beneath.
        ::  Also, call your mother.
        :: %-  ~(rep by (malt ;;((list [atom node:store]) (cue i.ja))))
        :: |=  [[a=atom n=node:store] q=(map index node:store)]
        :: ?.(?=(%.y -.post.n) q (~(put by q) index.p.post.n n(signatures.p.post ~)))
        %-  ~(rep by (malt ;;((list [atom node:store]) (cue i.ja))))
        |=  [[a=atom n=node:store] q=(map index node:store)]
        ?.  ?=(%.y -.post.n)  q
        =+  pb=p.post.n
        =.  p.post.n
          =-  p.post.n(contents -)
          %+  turn  contents.p.post.n
          |=  con=content
          ?.  ?=([%reference [%graph [@ @] [[@ @] *]]] con)  con
          ?.  =(ol +.resource.uid.reference.con)  con
          :^  %reference  %graph
            `resource`?:(?=(%& -.gr) p.gr [our.bol p.gr])
          [`resource`[our.bol ne] index.uid.reference.con]
        =?    hash.p.post.n
            !=(pb p.post.n)
          ^-  (unit @ux)
          :-  ~  ;;  @ux
          (sham [~ author.p.post.n time-sent.p.post.n contents.p.post.n])
        =?    signatures.p.post.n
            ?|  .^(? %j /(scot %p our.bol)/fake/(scot %da now.bol))
                !=(pb p.post.n)
            ==
          ~
        (~(put by q) index.p.post.n n)
      ==
    --
  ++  coax-prior-shape
    |=  par=(list [@t =part:multipart])
    ^-  (each [shape @tas] ~)
    =/  files=(list path)
      %+  murn  par
      |=  [t=@t p=part:multipart]
      ?.  =('files' t)  ~
      ?~  file.p  ~
      ?~  type.p  ~
      =-  ?~(filp=(rush u.file.p -) ~ `u.filp)
      =,  de-purl:html
      %+  cook
        |=(pork (weld q (drop p)))
      (cook deft (more fas smeg))
    ?~  files  [%.n ~]
    =/  arche=[old=(unit @t) sap=(unit shape)]
      :-  `(slav %tas (head i.files))
      =-  ?~(- - `;;(shape q.u.-))
      ^-  (unit [p=@tas q=@tas r=@ud])
      (rush +<.i.files ;~((glue cab) sym sym dem))
    ?:  |(?=(~ old.arche) ?=(~ sap.arche))  [%.n ~]
    =-  ?.  -  [%.n ~]
        [%.y [u.sap.arche u.old.arche]]
    %+  levy  `(list path)`files
    |=  p=path
    =;  [old=(unit @t) sap=(unit shape)]
      ?:  |(?=(~ old) ?=(~ sap))  %.n
      &(=(u.old.arche u.old) =(u.sap.arche u.sap))
    :-  `(slav %tas (head i.files))
    =-  ?~(- - `;;(shape q.u.-))
    ^-  (unit [p=@tas q=@tas r=@ud])
    (rush +<.i.files ;~((glue cab) sym sym dem))
  ++  coax-repete-form
    |=  m=(map @t part:multipart)
    ^-  (each (each resource term) ~)
    ?.  ?&  (~(has by m) 'files')
            (~(has by m) 'resource')
        ==
      [%.n ~]
    ?~  gro=(~(get by m) 'group')
      ?~  nug=(~(get by m) 'nugru')
        [%.n ~]
      ?~  gru=(rush body.u.nug ;~(pose ;~(pfix cen sym) sym))
        [%.n ~]
      [%.y [%.n u.gru]]
    ?~  gup=(rush body.u.gro ;~((glue bar) ;~(pfix sig crub:so) sym))
      [%.n ~]
    ?>  ?=(%p -<.u.gup)
    [%.y [%.y [->.u.gup +.u.gup]]]
  ++  coax-import-name
    |=  m=(map @t part:multipart)
    ^-  (each term ~)
    ?~  raw=(~(get by m) 'resource')  [%.n ~]
    ?~  res=(rush body.u.raw ;~(pose ;~(pfix cen sym) sym))
      [%.n ~]
    [%.y u.res]
  ++  make-upload-page
    |=  errs=(list @t)
    ^-  octs
    %-  as-octt:mimes:html
    %-  en-xml:html
    ^-  manx
    ::  groups where we are admin, to which we can restore graphs
    ::
    =/  groups=marl
      %-  ~(rep in groups:pek:pl)
      |=  [r=resource q=marl]
      ^-  marl
      :_  q  ^-  manx
      ;option
        =name   "group"
        =value  "{(scow %p -.r)}|{(scow %tas +.r)}"
        ;+  :/"{(scow %p -.r)} %{(scow %tas +.r)}"
      ==
    ::
    ;html
      ;head
        ;title:"%peat importer"
        ;meta(charset "utf-8");
        ;style:'''
               * { font-family: monospace; margin-top: 1em; }
               '''
      ==
    ::
      ;body
        ;h2:"%peat importer"
        ;+  ?.  =(~ errs)
              :-  [%p ~]
              (join `manx`;br; (turn errs |=(m=@t `manx`:/"{(trip m)}")))
            ;ol
              ;li:"""
                  %peat can import to either an extant group, or a new group.
                  Based on your needs, please use the datrect form, below.
                  """
              ;li:"""
                  Make sure to select the folder in which your backups were
                  saved, and not just the files internal to that folder.
                  We use the folder to get the name of the resource for
                  several things, reference replacements, e.g.
                  """
              ;li:"Include a name for the new resource"
              ;li:"Import!"
            ==
        ;table
          ;tr
            ;td
              ;h3:"Add to Existing Group"
            ==
            ;td
              ;h3:"Add to New Group"
            ==
          ==
          ;tr
            ;td
              ;form(method "post", enctype "multipart/form-data")
                ;label
                  ;+  :/"Import Folder: "
                  ;input
                    =type             "file"
                    =name             "files"
                    =required         ""
                    =directory        ""
                    =mozdirectory     ""
                    =webkitdirectory  "";
                ==
                ;br;
                ;label
                  ;+  :/"Extant Group: "
                  ;select
                    =name      "group"
                    =required  ""
                    ;option(value "", hidden ""):"Import to Groups: "
                    ;*  ?.  ?=(~ groups)  groups
                        ;=  ;option(value "", hidden ""):"Empty"
                        ==
                  ==
                ==
                ;br;
                ;label
                  ;+  :/"New Graph Name: "
                  ;input
                    =name      "resource"
                    =type      "text"
                    =required  "";
                ==
                ;br;
                ;button(type "submit"):"Create Graph -> Add to Group -> Import"
              ==
            ==
            ;td
              ;form(method "post", enctype "multipart/form-data")
                ;label
                  ;+  :/"Import Folder: "
                  ;input
                    =type             "file"
                    =name             "files"
                    =required         ""
                    =directory        ""
                    =mozdirectory     ""
                    =webkitdirectory  "";
                ==
                ;br;
                ;label
                  ;+  :/"New Group Name: "
                  ;input
                    =name      "nugru"
                    =type      "text"
                    =required  "";
                ==
                ;br;
                ;label
                  ;+  :/"New Graph Name: "
                  ;input
                    =name      "resource"
                    =type      "text"
                    =required  "";
                ==
                ;br;
                ;button(type "submit"):"Create Group, Graph -> Import"
              ==
            ==
          ==
        ==
      ==
    ==
  --
--
