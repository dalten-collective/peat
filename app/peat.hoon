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
      saved=(map resource [index @dr])
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
         (depart:pete:hc per.pete)
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
         %kick       `this                                ::  quiet failure on kick and
         %watch-ack  `this                                ::  watch-ack to avoid duplication
         %poke-ack   `this                                ::  - and this thrown in to avoid wutlus
      ::
          %fact
        |^
        ?.  ?=(%jam p.cage.sign)
          ~_(leaf+"%peat-fail -bad-fact-on-remake" !!)
        =+  gra=;;(graph:store (cue !<(@ q.cage.sign)))
        ?+    t.t.t.t.wire  (on-agent:def wire sign)     ::  finish path parsing, from above
            ~
          :_  this
          ^-  (list card)
          ;:  welp
            ^-  (list card)
            (~(rep by gra) ~(renew cod:pl n))
          ::
            ^-  (list card)
            (add-to-new-group n s (slav %tas i.t.t.t.wire))
          ::
            =-  [%give %fact ~[/website] json+!>(`json`-)]~
            (frond status-msg+s+(crip "%peat-success -remade-{(trip (scot %tas +.n))}"))
          ==
        ::
            [@ ~]
          :_  this
          ;:  welp
            ^-  (list card)
            (~(rep by gra) ~(renew cod:pl n))
          ::
            ^-  (list card)
            %^  add-to-old-group  n  s
            :-  (slav %p i.t.t.t.wire)
            (slav %tas i.t.t.t.t.wire)
          ::
            =-  [%give %fact ~[/website] json+!>(`json`-)]~
            =-  (frond status-msg+s+(crip -))
            "%peat-success -remade-{(trip (scot %tas +.n))}"
          ==
        ==
        ++  add-to-old-group
          |=  [r=resource s=shape gr=resource]           ::  graph shape group
          ?.  (~(has in groups:pek:pl) gr)               ::  - are we a group admin?
            ~_(leaf+"%peat-fail -bad-group-remake" !!)
          :~  (graph:biz:pl name.r s)
              (metas:biz:pl r s gr)
              (pushy:biz:pl name.gr %graph-push-hook)
          ==
        ++  add-to-new-group
          |=  [r=resource s=shape n=term]                ::  graph shape group-name
          :~  (group:biz:pl n)
              (pushy:biz:pl n %group-push-hook)
              (metag:biz:pl n)
              (pushy:biz:pl n %metadata-push-hook)
              (pushy:biz:pl n %contact-push-hook)
              (graph:biz:pl name.r s)
              (metas:biz:pl r s [our.bowl n])
              (pushy:biz:pl n %graph-push-hook)
              (joins:biz:pl n)
          ==
        --
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
    ^-  (quip card _this)
    `this
    :: ?+    path  (on-watch:def path)
    ::     [%ogertalk %peat ~]
    ::   ?>  (~(has by given) src.bowl)
    ::   =-  [%give %fact ~ [%peat-peep !>(`peep`-)]]~
    ::   [%hav (sy ~[src.bowl] (~(got by given) src.bowl))]
    :: ::
    ::     [%website ~]
    ::   :_  this
    ::   =-  [%give %fact ~ json+!>(`json`-)]~
    ::   %-  pairs
    ::   :~  saved+shave:john:hc
    ::       given+(jargon:john:hc %given)
    ::       doled+(jargon:john:hc %doled)
    ::       known+(jargon:john:hc %known)
    ::   ==
    :: ::
    ::     [%remake @ @ @ ~]
    ::   =/  r=resource
    ::     [(scot %p i.t.path) (scot %tas i.t.t.path)]
    ::   =+  s=;;(shape (scot %tas i.t.t.t.path))
    ::   ?~  gvn=(~(get ba-s given) src.bowl s)
    ::     ~_(leaf+"%peat-fail -no-permissions" !!)
    ::     ::
    ::   ?.  (~(has in u.gvn) res)
    ::     ~_(leaf+"%peat-fail -wrong-permissions" !!)
    ::     ::
    ::   =/  upd=update:store
    ::     =-  (gra-s:pek:pl ,update:store -)
    ::     /graph/(scot %p -.r)/(scot %tas +.r)/noun
    ::   ?>  ?=(%add-graph -.q.upd)
    ::   :_  this
    ::   :~  [%give %fact ~ [%jam !>(`@`(jam graph.q.upd))]]
    ::       [%give %kick ~ `src.bowl]
    ::   ==
    :: ==
  ::
  ++  on-peek
    |=  pek=path
    ^-  (unit (unit cage))  
    ~
    ::^-  (unit (unit cage))
    ::=,  enjs:format
    ::?+    pek  (on-peek:def pek)
    ::  ::  wholes
    ::::  saved all
    ::    [%x %saved ~]
    ::  ``[%json !>(`json`(frond saved+shave:john:hc))]
    ::::  given all
    ::    [%x %given ~]
    ::  ``[%json !>(`json`(frond given+(jargon:john:hc %given)))]
    ::::  doled all
    ::    [%x %doled ~]
    ::  ``[%json !>(`json`(frond doled+(jargon:john:hc %doled)))]
    ::::  known all
    ::    [%x %known ~]
    ::  ``[%json !>(`json`(frond known+(jargon:john:hc %known)))]
    ::  ::  searches
    ::::  given (ship)
    ::    [%x %given @ ~]
    ::  =+  who=(scot %p i.t.t.path)
    ::  =-  ``[%json !>(`json`-)]
    ::  %-  pairs
    ::  %+  turn  ~(tap by (~(gut by given) who ~))
    ::  |=  [s=shape rs=resources]
    ::  :-  s  :-  %a
    ::  %+  turn  ~(tap in rs)
    ::  |=  [e=@p n=@tas]
    ::  (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
    ::::  doled (ship)
    ::    [%x %doled @ ~]
    ::  =+  who=(scot %p i.t.t.path)
    ::  =-  ``[%json !>(`json`-)]
    ::  %-  pairs
    ::  %+  turn  ~(tap by (~(gut by doled) who ~))
    ::  |=  [s=shape rs=resources]
    ::  :-  s  :-  %a
    ::  %+  turn  ~(tap in rs)
    ::  |=  [e=@p n=@tas]
    ::  (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
    ::::  known (shape)
    ::    [%x %known @ ~]
    ::  =+  who=(scot %p i.t.t.path)
    ::  =-  ``[%json !>(`json`-)]
    ::  %-  pairs
    ::  %+  turn  ~(tap by (~(gut by doled) who ~))
    ::  |=  [g=(unit resource) rs=resources]
    ::  :-  ?~(g 'ungrouped' name.u.g)  :-  %a
    ::  %+  turn  ~(tap in rs)
    ::  |=  [e=@p n=@tas]
    ::  (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
    ::::  given (ship) (shape)
    ::    [%x %given @ @ ~]
    ::  =+  who=(scot %p i.t.t.path)
    ::  =+  wic=;;(shape (scot %tas i.t.t.t.path))
    ::  =-  ``[%json !>(`json`-)]
    ::  :-  %a
    ::  %+  turn
    ::    ~(tap in (~(gut by (~(gut by given) who ~)) wic))
    ::  |=  [e=@p n=@tas]
    ::  (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
    ::::  doled (ship) (shape)
    ::    [%x %doled @ @ ~]
    ::  =+  who=(scot %p i.t.t.path)
    ::  =+  wic=;;(shape (scot %tas i.t.t.t.path))
    ::  =-  ``[%json !>(`json`-)]
    ::  :-  %a
    ::  %+  turn
    ::    ~(tap in (~(gut by (~(gut by doled) who ~)) wic))
    ::  |=  [e=@p n=@tas]
    ::  (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
    ::::  known (shape) (unit resource)
    ::    [%x %known @ *]
    ::  =+  who=(scot %p i.t.t.path)
    ::  ?+    t.t.t.path  !!
    ::      ~
    ::    =-  ``[%json !>(`json`-)]
    ::    :-  %a
    ::    %+  turn
    ::      ~(tap in (~(gut by (~(gut by known) who ~)) ~))
    ::    |=  [e=@p n=@tas]
    ::    (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
    ::  ::
    ::      [@ @ ~]
    ::    =+  wer=(scot %p i.t.t.t.path)
    ::    =+  wat=(scot %tas i.t.t.t.t.path)
    ::    =-  ``[%json !>(`json`-)]
    ::    :-  %a
    ::    %+  turn  %~  tap  in
    ::      (~(gut by (~(gut by known) who ~)) `[wer wat])
    ::    |=  [e=@p n=@tas]
    ::    (pairs ~[entity+s+(scot %p e) name+s+(scot %tas n)])
    ::  ==
    ::==
  ++  on-leave  on-leave:def
  ++  on-arvo  on-arvo:def
  ++  on-fail  on-fail:def
  --
  ::
|_  bol=bowl:gall
++  john
  =,  enjs:format
  |%
  ++  gibbs                                              ::  got a new resource from a friend
    |=  [p=@p s=shape]
    ^-  (list json)
    %+  turn  ~(tap in (~(get (ba _p _s resource) given) p s))
    |=  r=resource
    (pairs ~[entity+s+(scot %p entity.r) name+s+name.r])
  ::
  ++  jagon                                              ::  shorthand for turning gupps/mupps
    |=  t=?(%given %doled %known)
    |^
      ^-  json
      ?-  t
        %given  a+~ ::(turn ~(tap ba-s given) gupps)
        %doled  a+~ ::(turn ~(tap ba-s doled) gupps)
        %known  a+~ ::(turn ~(tap (ba shape (unit resource) resource) known) mupps)
      ==
    ++  gupps                                            ::  translate (jag ship shape resource)
      |=  [p=ship q=(jug shape resource)]
      ^-  json
      =,  enjs:format
      %+  frond  'test'
      =/  ql=(list [shape resources])  ~(tap in q)
      =|  twins=(list json)
      |-
      ?~  ql  a+twins
      %=    $
        ql  t.ql
      ::
          twins
        :_  twins
        %-  pairs
        :~  shape+s+(scot %tas -.i.ql)
        ::
          :-  'resources'
          :-  %a
          %+  turn  ~(tap in +.i.ql)
          |=  [e=@p n=@tas]
          %-  pairs
          ~[ship+s+(scot %p e) name+s+(scot %tas n)]
        ==
      ==
    ::
    ++  mupps                                            ::  translate (jag shape (unit resource) resource)
      |=  [q=shape r=(jug (unit resource) resource)]
      ^-  json
      =,  enjs:format
      %+  frond  (scot %tas q)
      =/  rl=(list [(unit resource) resources])  ~(tap by r)
      =|  twins=(list [@t json])
      |-
      ?~  rl  (pairs twins)
      %=    $
        rl  t.rl
      ::
          twins
        %+  welp  twins
        :~
          :-  'group'
          ?~  g=-.i.rl  s+'ungrouped'
          %-  pairs
          :~  ship+s+(scot %p entity.u.-.i.rl)
              name+s+(scot %tas name.u.-.i.rl)
          ==
        ::
          :-  'resources'
          :-  %a
          %+  turn  ~(tap in +.i.rl)
          |=  [e=@p n=@tas]
          %-  pairs
          ~[ship+s+(scot %p e) name+s+(scot %tas n)]
        ==
      ==
    --
  ::
  ++  shave                                              ::  all saved
    ^-  json
    =/  shave=(list [r=resource [i=index f=@dr]])
      ~(tap by saved)
    =|  twins=(list [@t json])
    |-
    ?~  shave  (pairs twins)
    =+  yep=(yell f.i.shave)
    %=    $
      shave  t.shave
    ::
        twins
      :_  twins
      :-  `@t`(scot %da -.i.i.shave)
      ^-  json
      %-  pairs
      ^-  (list [@t json])
      :~  ['entity' `json`s+(scot %p entity.r.i.shave)]
          ['name' `json`s+(scot %tas name.r.i.shave)]
        ::
          :-  'frequency'
          %-  pairs 
          :~  ['days' n+(scot %ud d.yep)]
              ['hours' n+(scot %ud h.yep)]
              ['minutes' n+(scot %ud m.yep)]
          ==
        ::
          ['last-indexed' (sect now.bol)]
          ::['last-indexed' (sect -.i.i.shave)]
      ==
    ==
  --
::
++  pete
  |%
  ++  export
    |=  [r=resource b=(unit @dr)]
    `state
    ::|^
    ::^-  (quip card _state)
    ::?>  (~(has in llaves:pek:pl) r)                      ::  the resource must exist
    ::?~  b
    ::  [~[(put-file r)] state]
    ::[~[(put-file r) (start-behn r u.b)] state]
    ::++  put-file
    ::  =*  ent  (scot %p entity.res.vaz)                    :: then get the resource ready
    ::  =*  nam  (scot %tas name.res.vaz)
    ::::
    ::?~  ass=~(assoc scry (en-path:res-lib res.vaz))      :: could we find an association in metadata
    ::  %.  `state  %-  slog
    ::  :~  leaf+"%peat-export"
    ::      leaf+"-export-failed"
    ::      leaf+"-no-metadata-found"
    ::  ==
    ::  ::
    ::?.  ?=(%graph -.config.metadatum.u.ass)              :: this product only works on graph modules as of the present
    ::  %.  `state  %-  slog
    ::  :~  leaf+"%peat-export"
    ::      leaf+"-export-failed"
    ::      leaf+"-strange-request"
    ::  ==
    ::=*  app  (scot %tas %graph)                          :: if we're a graph, we know the app and type now
    ::=*  typ  (scot %tas module.config.metadatum.u.ass)
    ::::
    ::=/  upd=update:store  ~(graph scry [ent nam ~])      :: does our scry give us what we expect
    ::?.  ?=(%add-graph -.q.upd)
    ::  %.  `state  %-  slog
    ::  :~  leaf+"%peat-export"
    ::      leaf+"-export-failed"
    ::      leaf+"-strange-display"
    ::  ==
    ::::
    ::::  export will now form a list of cards to drum put
    ::::  
    ::=|  cop=(list card)
    ::=/  pag=@ud  1
    ::=/  par
    ::  %+  sort  ~(tap by graph.q.upd)
    ::  |=([a=[@ node:store] b=[@ node:store]] (gth -.a -.b))
    ::|-
    ::=/  jeff                                             ::  my name-a
    ::  (rap 3 ~[nam '|' app '|' typ '|' (scot %ud pag)])
    ::?:  (lte (lent par) 500)
    ::  %-  %-  slog
    ::      :~  leaf+"%peat-export"
    ::          leaf+"-export-starting"
    ::          leaf+"-check-directory /pier/.urb/put"
    ::          leaf+"-expected-file-count {<pag>}"
    ::      ==
    ::  :_  state
    ::  %+  welp  cop
    ::  :~  :*
    ::    %pass   /peat/export/(scot %ud pag)/(scot %da now.bol)
    ::    %agent  [our.bol %hood]
    ::    %poke   %drum-put
    ::    !>([/(scot %tas nam)/(scot %tas jeff)/jam (jam par)])
    ::  ==  ==
    ::%=    $
    ::  par  (oust [0 500] par)
    ::  pag  +(pag)
    ::::
    ::    cop
    ::  %+  welp  cop
    ::  :~  :*
    ::    %pass   /peat/export/(scot %ud pag)/(scot %da now.bol)
    ::    %agent  [our.bol %hood]
    ::    %poke   %drum-put
    ::    !>([/(scot %tas nam)/(scot %tas jeff)/jam (jam (scag 500 par))])
    ::  ==  ==
    ::==
    ::--
  ++  cancel
    |=  r=resource
    ^-  (quip card _state)
    `state
  ::
  ++  import
    |=  [f=path g=(each resource @tas) n=@tas]
    ^-  (quip card _state)
    `state
  ::
  ++  permit
    |=  [pr=(set ship) rs=(set resource)]
    ^-  (quip card _state)
    `state
  ::
  ++  record
    ^-  (quip card _state)
    `state
  ::
  ++  remove
    |=  [pr=(set ship) rs=(set resource)]
    ^-  (quip card _state)
    `state
  ::
  ++  remake
    |=  $:  w=(each resource [ship resource])
            g=resource
            n=term
        ==
        ^-  (quip card _state)
    `state
  ::
  ++  depart
    |=  pr=(set ship)
    ^-  (quip card _state)
    `state
  --
--