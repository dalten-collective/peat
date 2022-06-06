::
:: /app/graf - a graph backup and restoration agent - by Quartus Corporation
::
/-  *peat,
    post,
    res=resource,
    store=graph-store,
    metas=metadata-store
/+  default-agent, dbug, plib=peat, *jag
::
|%
+$  card  card:agent:gall
+$  versioned-state
  $%  state-zero
  ==
::
::    state-zero
::  - saved  (map resource [index @dr]) - resources that are being auto-saved
::  - given  (jag ship shape resource) - resources shared with you
::  - doled  (jag ship shape resource) - resources you've shared out
::  - known  (jag shape (unit resource) resource)
::    - resources you're aware of in graph store by shape, group
::
+$  state-zero
  $:  %0
      saved=(map resource [@da @dr])
      given=(jag ship shape resource)
      doled=(jag ship shape resource)
      known=(jag shape (unit resource) resource)
  ==
--
::
%-  agent:dbug
=|  state-zero
=*  state  -
^-  agent:gall
=<
  |_  =bowl:gall
  +*  this  .
      def   ~(. (default-agent this %|) bowl)
      pl    ~(. plib bowl)
      hc    ~(. +> bowl)
      ba-k  (ba shape (unit resource) resource)
      ba-s  (ba @p shape resource)
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
    |^  ^-  (quip card _this)
    =/  old=versioned-state  !<(versioned-state ole)
    |-
    ?-  -.old
     %0  [check-watch this(state old)]
    ==
    ++  check-watch
     ?:  %-  ~(has in wex.bowl)
         [[/peat/keys our.bowl %graph-store] [%.y /keys]]
       ~
     =-  [%pass /peat/keys %agent -]~
     [[our.bowl %graph-store] %watch /keys]
    --
  ::
  ++  on-poke
    |=  [=mark =vase]
    :: ~>  %bout.[0 'on-poke-peat']
    ^-  (quip card _this)
    ?+    mark  (on-poke:def mark vase)
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
            %record                                      ::  note: only foreign allowed
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
        [%remake @ @ @ *]                                ::  partial path parsing, see below
      =/  n=resource  [our.bowl (slav %tas i.t.wire)]
      =+  s=;;(shape (slav %tas i.t.t.wire))
      ?-    -.sign
         %kick       `this                               ::  quiet failure on kick and
         %watch-ack  `this                               ::  watch-ack to avoid duplication
         %poke-ack   `this                               ::  - and this thrown in to avoid wutlus
      ::
          %fact
        ?.  ?=(%jam p.cage.sign)
          ~_(leaf+"%peat-fail -bad-fact-on-remake" !!)
        =+  gra=;;(graph:store (cue !<(@ q.cage.sign)))
        ?+    t.t.t.t.wire  (on-agent:def wire sign)     ::  finish path parsing, from above
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
          =.  known
            %-  ~(car (ba shape (unit resource) resource) known)
            (murn ~(tap in resources.q.upd) mippet.pek.pl)
          :_  this
          =-  [%give %fact ~[/website] json+!>(`json`-)]~
          (frond known+(jagon:john:hc %known))
        ==
      ==
    ==
  ::
  ++  on-watch
    |=  =path
    :: ~>  %bout.[0 'on-watch-peat']
    ^-  (quip card _this)
    ?+    path  (on-watch:def path)
        [%ogertalk %peat ~]
      ?>  (~(has by doled) src.bowl)
      :_  this
      =-  [%give %fact ~ %peat-peep !>(`peep`-)]~
      [%hav (sy ~[src.bowl]) (~(got by doled) src.bowl)]
    ::
        [%website ~]
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
      ~&  >  ~(tap by stacks:pek:pl)
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
    ?.  ?=([%peat @ @ @ ~] wire)  (on-arvo:def wire sign)
    =*  ent  (slav %p i.t.wire)
    =*  nam  (slav %tas i.t.t.wire)
    =*  fre  (slav %dr i.t.t.t.wire)
    ?.  ?=([%behn %wake *] sign)  (on-arvo:def wire sign)
    ?~  error.sign
      ?~  hab=(~(get by saved) [ent nam])  `this
      ?.  =(fre +.u.hab)  `this
      =^  cards  state
        (export:pete:hc [ent nam] ~)
      :_  this
      :_  cards
      [%pass wire %arvo %b [%wait (add now.bowl fre)]]
    =.  saved
      (~(del by saved) [ent nam])
    %.  `this  %-  slog
    :~  leaf+"%peat-fail -a-timer-broke"
        leaf+"-check-resource [{<ent>} %{<nam>}]"
    ==
  ++  on-leave
    |=  =path
    :: ~>  %bout.[0 'on-leave-peat']
    ^-  (quip card _this)
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
++  john
  =,  enjs:format
  |%
  ++  gibbs                                              ::  got a new resource from a friend
    |=  [p=@p s=shape]
    :: ~>  %bout.[0 'gibbs-john']
    ^-  (list json)
    %+  turn  ~(tap in (~(get (ba _p _s resource) given) p s))
    |=  r=resource
    (pairs ~[entity+s+(scot %p entity.r) name+s+name.r])
  ::
  ++  jagon                                              ::  shorthand for turning gupps/mupps
    |=  t=?(%given %doled %known)
    |^
    :: ~>  %bout.[0 'jagon-john']
      ^-  json
      ?-  t
        %given  a+(turn ~(tap ba-s given) gupps)
        %doled  a+(turn ~(tap ba-s doled) gupps)
        %known  a+(turn ~(tap ba-k known) mupps)
      ==
    ++  gupps                                            ::  translate (jag ship shape resource)
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
    ::
    ++  mupps                                            ::  translate (jag shape (unit resource) resource)
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
  ::
  ++  shave                                              ::  all saved
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
::
++  pete
  |%
  ++  export
    |=  [r=resource b=(unit @dr)]
    |^  ^-  (quip card _state)
    :: ~>  %bout.[0 'export-pete']
      ?>  (~(has in llaves:pek:pl) r)                    ::  the resource must exist
      =/  last=time
        %-  need
        ;;  (unit time)
        =-  (gra-s:pek:pl * -)
        ;:  welp
          /update-log
          /(scot %p entity.r)
          /(scot %tas name.r)
          /latest
        ==
      ?~  b
        [(put-file r) state]
      =?    u.b
          (lth u.b ~h12)
        ~m1
      ?~  rep=(~(get by saved) r)
        =.  saved
          (~(put by saved) r [last u.b])
        [(set-behn r u.b)^(put-file r) state]
      ::
      ?<  =(u.b +.u.rep)
      =.  saved
        (~(put by saved) r [last u.b])
      [(set-behn r u.b)^(put-file r) state]
    ++  web-card
      |=  [r=resource l=@da rec=(unit @dr)]
      :: ~>  %bout.[0 'web-card-export-pete']
      =-  [%give %fact ~[/website] json+!>(`json`-)]~
      %+  frond:enjs:format  'diff-export'
      %-  pairs:enjs:format
      :~  last+(sect:enjs:format l)
        :-  'resource'
          %-  pairs:enjs:format
          :~  name+s+(scot %tas name.r)
              entity+s+(scot %p entity.r)
          ==
        ::
          :-  'frequency'
          ?~  rec  s+'once'
          =+  yep=(yell u.rec)
          %-  pairs:enjs:format
          :~  ['days' n+(scot %ud d.yep)]
              ['hours' n+(scot %ud h.yep)]
              ['minutes' n+(scot %ud m.yep)]
          ==
      ==
    ++  set-behn
      |=  [r=resource t=@dr]
      :: ~>  %bout.[0 'set-behn-export-pete']
      ^-  card
      =/  pat=path
        ;:  welp
          /peat
          /(scot %p entity.r)
          /(scot %tas name.r)
          /(scot %dr t)
        ==
      [%pass pat %arvo %b [%wait (add now.bol t)]]
    ++  put-file
      |=  r=resource
      :: ~>  %bout.[0 'put-file-export-pete']
      ^-  (list card)
      =*  ent  (scot %p entity.r)                        :: then get the resource ready
      =*  nam  (scot %tas name.r)
      =+  ^=  ass                                        :: check metadata association
        %+  met-s:pek:pl  (unit association:metas)
        /metadata/graph/ship/[ent]/[nam]
      =+  ^=  [app=@t typ=@t]
        ?~  ass  
          (scot %tas %dm)^(scot %tas %dm)                :: if we're not in metas, we're a dm
        ?>  ?=(%graph -.config.metadatum.u.ass)          :: if we're a graph, we know the app and type
        :-  (scot %tas %graph)
        (scot %tas module.config.metadatum.u.ass)
      ::
      =/  upd=update:store
        (gra-s:pek:pl update:store /graph/[ent]/[nam])   :: does our scry give us what we expect
      ?>  ?=(%add-graph -.q.upd)
      ::
      ::  export will now form a list of cards to drum put
      ::  
      =|  cop=(list card)
      =/  pag=@ud  1
      =/  par
        %+  sort  ~(tap by graph.q.upd)
        |=  [a=[@ node:store] b=[@ node:store]]
        (gth -.a -.b)
      |-
      =/  jeff                                           ::  my name-a
        (rap 3 ~[app '_' typ '_' (scot %ud pag)])
      ?:  (lte (lent par) 500)
       %-  %-  slog
           :~  leaf+"%peat-export"
               leaf+"-export-starting"
               leaf+"-check-directory /pier/.urb/put"
               leaf+"-expected-file-count {<pag>}"
           ==
        %+  welp  cop
        =-  [%pass -< %agent [our.bol %hood] %poke %drum-put ->]~
        :-  /peat/export/(scot %ud pag)/(scot %da now.bol)
        !>([/[nam]/[jeff]/jam (jam par)])
      %=    $
        par  (oust [0 500] par)
        pag  +(pag)
      ::
          cop
        %+  welp  cop
        =-  [%pass -< %agent [our.bol %hood] %poke %drum-put ->]~
        :-  /peat/export/(scot %ud pag)/(scot %da now.bol)
        !>([/[nam]/[jeff]/jam (jam (scag 500 par))])    
      ==
    --
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
    ++  add-dm                                           ::  reconcile dms (slide in)
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
      =|  q=(map index node:store)
      |-
      ?~  p
        %.  :~
              :+  %pass   /import/[+.r]/(scot %da now.bol)
              :+  %agent  [our.bol %graph-store]
              :+  %poke   %graph-update-3
              !>  ^-  update:store
              [now.bol %add-nodes r q]
            ==
        %-  slog
        :~  '%peat-import'
            '-import-starting'
            leaf+"-group: [{<entity.g>} %{<name.g>}]"
            leaf+"-resource: [{<entity.r>} %{<name.r>}]"
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
          ?.(?=(%.y -.post.n) q (~(put by q) index.p.post.n n))
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
    ?:  ?=(%.y -.w)                                      ::  local case first
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
        ?.(?=(%.y -.post.n) q (~(put by q) index.p.post.n n))
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
      ?.(?=(%.y -.post.n) q (~(put by q) index.p.post.n n))
    ?>  %.  r.p.w                                        ::  now remote case
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
--
