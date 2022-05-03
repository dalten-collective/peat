::
:: oger - a pack rat - by Quartus Corporation
::
/-  *oger,
    post,
    res=resource,
    store=graph-store,
    metas=metadata-store
/+  default-agent, dbug, res-lib=resource, rudder, server
/~  pages  (page:rudder state-1 horde)  /app/oger
::
|%
::
::    state-one
::  - resources (equivalent to ser)
::  - permits   (ships permitted to see your resources)
::  - known     (jug of ship [resource type] for %search-ed ships)
::
+$  state-one   [%1 state-1]
+$  state-zero  [%0 ser=(set resource)]
::
+$  versioned-state
    $%  state-zero
        state-one
    ==
::
+$  card      card:agent:gall
+$  content   content:post
+$  resource  resource:store
--
::
%-  agent:dbug
=|  state-one
=*  state  -
^-  agent:gall
=<
::!.
|_  =bowl:gall
+*  this  .
    pax   /(scot %p our.bowl)/graph-store/(scot %da now.bowl)
    def   ~(. (default-agent this %|) bowl)
    hc    ~(. +> bowl)
::
++  on-init
  ^-  (quip card _this)
  %-  (slog leaf+"%oger-init" ~)
  :_  this
  :~  :^  %pass  /eyre/connect  %arvo
      [%e %connect [[~ [%apps %oger ~]] dap.bowl]]
      [%pass /oger/keys %agent [our.bowl %graph-store] %watch /keys]
  ==
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  ole=vase
  |^  ^-  (quip card _this)
  =/  old=versioned-state  !<(versioned-state ole)
  |-
  ?-  -.old
    %1  `this(state old) ::[check-watch this(state old)]
    %0  $(old [%1 ser.old ~ ~])
  ==
  ++  check-watch
    =|  caz=(list card)
    =?    caz
        =;  eyre-stat=(list [binding:eyre duct action:eyre])
          !(~(has in ~(key by (malt eyre-stat))) [~ /apps/oger])
        .^  (list [binding:eyre duct action:eyre])  %e 
            ~[(scot %p our.bowl) %bindings (scot %da now.bowl)]
        ==
      :_  caz
      =+  [[~ [%apps %oger ~]] dap.bowl]
      [%pass /eyre/connect %arvo %e %connect -]    
    =?    caz
        %-  ~(has in wex.bowl)
        :_  [%.y /keys]
        [/keys/oger/(scot %p our.bowl) our.bowl %graph-store]
      :_  caz
      :+  %pass  /keys/oger/(scot %p our.bowl)
      [%agent [our.bowl %graph-store] %leave ~]
    ?:  %-  ~(has in wex.bowl)
        :_  [%.y /keys]
        [/oger/keys our.bowl %graph-store]
      caz
    :_  caz
    :+  %pass  /oger/keys
    [%agent [our.bowl %graph-store] %watch /keys]
  --
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  (team:title our.bowl src.bowl)
  ?:  =(%handle-http-request mark)
    =;  out=(quip card state-1)
      [-.out this(state [%1 +.out])]
    %.  [bowl !<(order:rudder vase) +.state]
    %:  (steer:rudder state-1 horde)
      pages
    ::
      endor:steer:hc
      golem:steer:hc
      djinn:steer:hc
    ==
  ?>  =(%oger-horde mark)
  =^  cards  state
    (post:hc !<(horde vase))
  [cards this]
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    wire  `this
      [%remake @ @ @ @ ~]
    =/  res=resource  [our.bowl (slav %tas +<.wire)]
    =/  typ=?(%chat %link %publish)
      ;;(?(%chat %link %publish) (slav %tas +>-.wire))
    =/  gro=resource
      [(slav %p +>+<.wire) (slav %tas +>+>-.wire)]
    ::
    ?>  !(~(has in resources) res)
    ?>  %.  gro
        %~  has  in
        %~  group  scry:hc
        /(scot %p our.bowl)/group-store/(scot %da now.bowl)/groups
    ?+    -.sign  `this
      %kick  `this
    ::
        %fact
      ?.  ?=(%jam p.cage.sign)  `this
      =/  gra=graph:store
        ;;(graph:store (cue !<(@ q.cage.sign)))
      :_  this
      =-  :-  %-  graph:make:hc
              [name.res ;;(?(%chat %link %publish) typ)]
          :_  -
          %-  metadata:make:hc 
          [name.res gro ;;(?(%chat %link %publish) typ)]
      (~(rep by gra) ~(renu perk:hc [our.bowl name.res]))
    ==
  ::
      [%oger %keys ~]
    ?+    -.sign  `this
        %kick
      :_  this
      =-  [%pass /oger/keys %agent -]~
      [[src.bowl %graph-store] %watch /keys]
    ::
        %fact
      ?.  ?=(%graph-update-3 p.cage.sign)  `this
      =/  upd=update:store  !<(update:store q.cage.sign)
      ?:  ?=(%remove-graph -.q.upd)
        :_  this(resources (~(del in resources) resource.q.upd))
        :~  :^  %give  %fact  [/search ~]
            [%oger-fritter !>(`fritter`[%kil resource.q.upd])]
        ==
      ?.  ?=(%keys -.q.upd)  `this
      =;  update=[(set resource) (set [resource ?(%chat %link %publish)])]
        :_  this(resources -.update)
        :~  :^  %give  %fact  [/search ~]
            [%oger-fritter !>(`fritter`[%hav +.update])]
        ==
      =-  :_  (silt -)
          %-  silt
          ;;((list resource) (turn - |=([res=resource @] -.+<)))
      ^-  (list [resource ?(%chat %link %publish)])
      (murn ~(tap in resources.q.upd) hav:make:hc)
    ==
  ::
      [%oger %search @ ~]
    =/  sip=ship  (slav %p +>-.wire)
    ?+    -.sign  `this
        %kick
      :_  this
      :~  :+  %pass  /oger/search/(scot %p sip)
          [%agent [sip %oger] %watch /search]
      ==
    ::
        %watch-ack
      ?:  =(~ p.sign)  `this
      =-  `this(known (~(del ju known) -))
      [(slav %p +>-.wire) (~(get ju known) sip)]
    ::
        %fact
      =/  fit=fritter  !<(fritter q.cage.sign)
      ?-    -.fit
          %hav
        =+  cur=(~(get ju known) sip)
        =+  ral=~(tap in rez.fit)
        ?:  =(rez.fit cur)  `this
        ?:  =(~ cur)
          |-
          ?~  ral
            `this
          %=  $
            ral    t.ral
            known  (~(put ju known) sip i.ral)
          ==
        =+  del=~(tap in (~(dif in cur) rez.fit))
        |-
        ?~  ral
        ?~  del  `this
          %=  $
            del  t.del
            known  (~(del ju known) sip i.del)
          ==
        %=  $
          ral    t.ral
          known  (~(put ju known) sip i.ral)
        ==
      ::
          %kil
        =/  sep=(map resource ?(%chat %link %publish))
          %-  malt
          ;;  (list [resource ?(%chat %link %publish)])
          ~(tap in (~(get ju known) sip))
        ?~  typ=(~(get by sep) res.fit)  `this
        `this(known (~(del ju known) sip [res.fit u.typ]))
      ==
    ==
  ==
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  (on-watch:def path)
    [%http-response *]  `this
  ::
      [%search ~]
    ?>  (~(has in permits) src.bowl)
    :_  this
    =-  [%give %fact ~ [%oger-fritter !>(`fritter`[%hav -])]]~
    %-  silt
    ^-  (list [resource ?(%chat %link %publish)])
    (murn ~(tap in resources) hav:make:hc)
  ::
      [%remake @ @ ~]
    ?>  (~(has in permits) src.bowl)
    =/  res=resource
      [(slav %p +<.path) (slav %tas +>-.path)]
    ?>  (~(has in resources) res)
    ::
    =/  upd=update:store
      %~  graph  scry:hc
      [(scot %p -.res) (scot %tas +.res) ~]
    ?>  ?=(%add-graph -.q.upd)
    :_  this
    :~  [%give %fact ~ [%jam !>(`@`(jam graph.q.upd))]]
        [%give %kick ~[path] `src.bowl]
    ==
  ==
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+    wire  (on-arvo:def wire sign-arvo)
      [%eyre %connect ~]
    ?+    sign-arvo  (on-arvo:def wire sign-arvo)
        [%eyre %bound *]
      ~?  !accepted.sign-arvo
        [dap.bowl [%eyre %bind %fail] binding.sign-arvo]
      `this
    ==
  ==
++  on-fail  on-fail.def
++  on-peek  on-peek:def
++  on-leave  on-leave:def
--
::
|_  bol=bowl:gall
::
++  perk
  |_  sor=resource
  ++  renu
    |=  [in=[a=atom n=node:store] out=(list card)]
    %+  welp  out
    :~  :*
      %pass   /import/(scot %da now.bol)
      %agent  [our.bol %graph-store]
      %poke   %graph-update-3
      !>(`update:store`[`@da`a.in %add-nodes sor (my ~[[~[a.in] n.in]])])
    ==  ==
  --
++  make
  |%
  ++  metadata
    |=  [name=term group=resource shape=?(%chat %link %publish)]
    ^-  card:agent:gall
    :^  %pass  `path`/oger/assoc/meta  %agent
    :^  [our.bol %metadata-push-hook]  %poke  %metadata-update-2
    !>  ^-  action:metas
    :^  %add  group  [%graph [our.bol name]]
    [`@t`name '' 0x0 now.bol our.bol [%graph shape] '' %.n %.n %$]
  ++  hav
    |=  res=resource
    ^-  (unit [resource ?(%chat %link %publish)])
    ?~  ass=~(assoc scry (en-path:res-lib res))  ~       :: could we find an association in metadata
    ?.  ?=(%graph -.config.metadatum.u.ass)      ~       :: this product only works on graph modules as of the present
    :+  ~  res
    ;;  ?(%chat %link %publish)
    module.config.metadatum.u.ass
  ::
  ++  graph
    |=  [name=term shape=?(%chat %link %publish)]
    ^-  card:agent:gall
    =;  mark=@tas
      :^  %pass  /oger/form/graph  %agent
      :^  [our.bol %graph-store]  %poke  %graph-update-3
      !>  ^-  update:store 
      [now.bol [%add-graph [our.bol name] ~ `mark %.n]]
    ?-  shape
      %chat     %graph-validator-chat
      %link     %graph-validator-link
      %publish  %graph-validator-publish
    ==
  --
++  scry
  |_  pat=path
  ++  curve
    ~+
    ^-  arch
    .^(arch %cy pat)
  ++  exist
    ^-  ?
    =+  curve
    !?=(~ dir.-)
  ++  notes
    ^-  (list p=path q=*)
    =+  curve
    ~(tap in dir.-)
  ++  group
    ^-  (set resource)
    .^  (set resource)  %gy
      /(scot %p our.bol)/group-store/(scot %da now.bol)/groups
    ==
  ::
  ++  graph
    ^-  update:store
    =-  .^(update:store %gx -)
    ;:  weld
      /(scot %p our.bol)/graph-store/(scot %da now.bol)
      /graph
      pat
      /noun
    ==
  ::
  ++  assoc
    ^-  (unit association:metas)
    =-  .^((unit association:metas) %gx -)
    ;:  weld
      /(scot %p our.bol)/metadata-store/(scot %da now.bol)
      /metadata/graph
      pat
      /noun
    ==
  ::
  ++  shape
    ^-  (unit ?(%chat %link %publish))
    =+  curve
    ?~  dis=dir.-  ~
    ?~  nos=(rush p:(head dis) ;~((glue bar) sym sym sym dem))  ~
    ?+  +>-.u.nos  ~
      %chat     `;;(?(%chat %link %publish) +>-.u.nos)
      %link     `;;(?(%chat %link %publish) +>-.u.nos)
      %publish  `;;(?(%chat %link %publish) +>-.u.nos)
    ==
  --
++  steer
  |%
  ++  endor
    |=  =trail:rudder
    ^-  (unit place:rudder)
    ?~  site=(decap:rudder /apps/oger site.trail)  ~
    ?+  u.site  ~
      ~         `[%page & %main]
      [%$ ~]    `[%away /apps/oger]
    ==
  ++  golem
    |=  =order:rudder
    ^-  [[(unit reply:rudder) (list card)] state-1]
    =;  msg=@t  [[`[%code 404 msg] ~] +.state]
    (rap 3 ~['%oger page ' url.request.order ' not found'])
  ++  djinn
    |=  heap=horde
    ^-  $@(@t [brief:rudder (list card) state-1])
    =+  result=(post heap)
    ?-    -.heap
        %export
      :+  'Export Queued - Check path/to/pier/.urb/put Directory'
      -.result  +>.result  
        %import
      :+  'Import Queued - Response Times May Vary - Check Specified Group'
      -.result  +>.result  
        %permit
      :+  'Permissions Adjusted'
      -.result  +>.result  
        %remove
      :+  'Permissions Adjusted'
      -.result  +>.result  
        %search
      :+  'Search Queued - Response Times May Vary'
      -.result  +>.result  
        %remake
      :+  'Remake Queued - Response Times May Vary - Check Specified Group'
      -.result  +>.result  
    ==
  --
++  post
  |=  vaz=horde
  ^-  (quip card _state)
  ?-    -.vaz
      %export
    ?.  (~(has in resources) res.vaz)                    :: does the resource to be exported exist?
      %.  `state  %-  slog
      :~  leaf+"%oger-export"
          leaf+"-export-failed"
          leaf+"-unknown-resource"
      ==
    =*  ent  (scot %p entity.res.vaz)                    :: then get the resource ready
    =*  nam  (scot %tas name.res.vaz)
    ::
    ?~  ass=~(assoc scry (en-path:res-lib res.vaz))      :: could we find an association in metadata
      %.  `state  %-  slog
      :~  leaf+"%oger-export"
          leaf+"-export-failed"
          leaf+"-no-metadata-found"
      ==
      ::
    ?.  ?=(%graph -.config.metadatum.u.ass)              :: this product only works on graph modules as of the present
      %.  `state  %-  slog
      :~  leaf+"%oger-export"
          leaf+"-export-failed"
          leaf+"-strange-request"
      ==
    =*  app  (scot %tas %graph)                          :: if we're a graph, we know the app and type now
    =*  typ  (scot %tas module.config.metadatum.u.ass)
    ::
    =/  upd=update:store  ~(graph scry [ent nam ~])      :: does our scry give us what we expect
    ?.  ?=(%add-graph -.q.upd)
      %.  `state  %-  slog
      :~  leaf+"%oger-export"
          leaf+"-export-failed"
          leaf+"-strange-display"
      ==
    ::
    ::  export will now form a list of cards to drum put
    ::  
    =|  cop=(list card)
    =/  pag=@ud  1
    =/  par
      %+  sort  ~(tap by graph.q.upd)
      |=([a=[@ node:store] b=[@ node:store]] (gth -.a -.b))
    |-
    =/  jeff                                             ::  my name-a
      (rap 3 ~[nam '|' app '|' typ '|' (scot %ud pag)])
    ?:  (lte (lent par) 50)
      %-  %-  slog
          :~  leaf+"%oger-export"
              leaf+"-export-starting"
              leaf+"-check-directory /pier/.urb/put"
              leaf+"-expected-file-count {<pag>}"
          ==
      :_  state
      %+  welp  cop
      :~  :*
        %pass   /oger/export/(scot %ud pag)/(scot %da now.bol)
        %agent  [our.bol %hood]
        %poke   %drum-put
        !>([/(scot %tas nam)/(scot %tas jeff)/jam (jam par)])
      ==  ==
    %=    $
      par  (oust [0 50] par)
      pag  +(pag)
    ::
        cop
      %+  welp  cop
      :~  :*
        %pass   /oger/export/(scot %ud pag)/(scot %da now.bol)
        %agent  [our.bol %hood]
        %poke   %drum-put
        !>([/(scot %tas nam)/(scot %tas jeff)/jam (jam (scag 50 par))])
      ==  ==
    ==
  ::
      %import
    ?.  ~(exist scry fol.vaz)                            :: do we have a folder where we expect?
      %.  `state  %-  slog
      :~  leaf+"%oger-import"
          leaf+"-import-failed"
          leaf+"-invalid-folder-path {<fol.vaz>}"
          leaf+"-no-jam-files"
      ==
      ::
    ?:  (~(has in resources) [our.bol wer.vaz])         :: does an identical resource already exist?
      %.  `state  %-  slog
      :~  leaf+"%oger-import"
          leaf+"-import-failed"
          leaf+"-invalid-resource [{(scow %p our.bol)} {(scow %tas wer.vaz)}]"
      ==
      ::
    ?.  %.  gro.vaz                                      :: does the specified group exist?
        %~  has  in
        %~  group  scry
        /(scot %p our.bol)/group-store/(scot %da now.bol)/groups
      %.  `state  %-  slog
      :~  leaf+"%oger-import"
          leaf+"-import-failed"
          leaf+"-invalid-group {<gro.vaz>}"
      ==
      ::
    ?~  sha=~(shape scry fol.vaz)                        :: can we determine the shape of the validator for the imprt graph?
      %.  `state  %-  slog
      :~  leaf+"%oger-import"
          leaf+"-import-failed"
          leaf+"-indeterminate-shape"
          leaf+"-call-your-mother!"
      ==
    ::
    ::  import will now form a list of cards to graph-store
    ::
    =|  cop=(list card)
    =/  bak=(list p=path q=*)  ~(notes scry fol.vaz)
    |-
    ?~  bak
      %-  %-  slog
          :~  leaf+"%oger-import"
              leaf+"-import-starting"
              leaf+"-group: {<gro.vaz>}"
              leaf+"-resource: [{(scow %p our.bol)} {<wer.vaz>}]"
          ==
      :_  state
      :-  (graph:make wer.vaz u.sha)
      [(metadata:make wer.vaz gro.vaz u.sha) cop]
    =/  old=graph:store
      %-  malt
      ;;  (list [atom node:store])
      (cue .^(@ %cx :(weld fol.vaz p.i.bak /jam)))
    %=    $
      bak  t.bak
      cop  (welp cop (~(rep by old) ~(renu perk [our.bol wer.vaz])))
    ==
  ::
      %permit
    =.  permits
      (~(uni in permits) per.vaz)
    %.  `state  %-  slog
    :~  leaf+"%oger-permit"
        leaf+"permitted ships: {<permits>}"
        leaf+"added ships: {<per.vaz>}"
    ==
  ::
      %remove
    =.  permits
      (~(del in permits) per.vaz)
    %.  `state  %-  slog
    :~  leaf+"%oger-permit"
        leaf+"permitted ships: {<permits>}"
        leaf+"removed ships: {<per.vaz>}"
    ==
  ::
      %search
    :_  state
    %+  murn  ~(tap in ser.vaz)
    |=  s=ship
    ?:  %-  ~(has in wex.bol)                           ::  do we have a subscription already?
        :_  [%.y /search]                                ::  - if so?  ignore
        [[%oger %search (scot %p s) ~] s %oger]          ::  - if not? subscribe
      ~
    :-  ~
    :+  %pass  /oger/search/(scot %p s)
    [%agent [s %oger] %watch /search]
  ::
      %remake
    ?:  (~(has in resources) [our.bol wer.vaz])
      %.  `state  %-  slog
      :~  leaf+"%oger-remake"
          leaf+"-remake-failed"
          leaf+"-duplicate-destination"
      ==
      ::
    ?.  %.  gro.vaz                                      :: does the specified group exist?
        %~  has  in
        %~  group  scry
        /(scot %p our.bol)/group-store/(scot %da now.bol)/groups
      %.  `state  %-  slog
      :~  leaf+"%oger-remake"
          leaf+"-remake-failed"
          leaf+"-invalid-group {<gro.vaz>}"
      ==
    ?.  ?=(%.y -.wat.vaz)
      ::
      ::  handle remote case
      ::
      =*  sip  `ship`+<.wat.vaz
      =*  res  `resource`+>.wat.vaz
      =/  mud=(map resource ?(%chat %link %publish))
        %-  malt
        ;;  (list [resource ?(%chat %link %publish)])
        ~(tap in (~(get ju known) sip))
      ?.  (~(has by mud) res)
        %.  `state  %-  slog
        :~  leaf+"%oger-remake-remote"
            leaf+"-remake-failed"
            leaf+"-unknown-resource"
        ==
      :_  state
      =-  [%pass -> %agent [sip %oger] %watch -<]~
      :-  /remake/(scot %p entity.res)/(scot %tas name.res)
      ;:  weld
        /remake
        /(scot %tas wer.vaz)
        /(scot %tas (~(got by mud) res))
        /(scot %p -.gro.vaz)/(scot %tas +.gro.vaz)
      ==
    ::
    ::  handle local case
    ::
    =*  res  `resource`+.wat.vaz
    ?.  (~(has in resources) res)                        :: does the resource to be exported exist?
      %.  `state  %-  slog
      :~  leaf+"%oger-remake-local"
          leaf+"-remake-failed"
          leaf+"-unknown-resource"
      ==
    =*  ent  (scot %p entity.res)                        :: then get the resource ready
    =*  nam  (scot %tas name.res)
    ::
    ?~  ass=~(assoc scry (en-path:res-lib res))          :: could we find an association in metadata
      %.  `state  %-  slog
      :~  leaf+"%oger-remake-local"
          leaf+"-remake-failed"
          leaf+"-no-metadata-found"
      ==
      ::
    ?.  ?=(%graph -.config.metadatum.u.ass)              :: state product only works on graph modules as of the present
      %.  `state  %-  slog
      :~  leaf+"%oger-remake-local"
          leaf+"-remake-failed"
          leaf+"-strange-request"
      ==
    =*  app  (scot %tas %graph)                          :: if we're a graph, we know the app and type now
    =*  typ  (scot %tas module.config.metadatum.u.ass)
    ::
    =/  upd=update:store  ~(graph scry [ent nam ~])      :: does our scry give us what we expect
    ?.  ?=(%add-graph -.q.upd)
      %.  `state  %-  slog
      :~  leaf+"%oger-remake-local"
          leaf+"-remake-failed"
          leaf+"-strange-display"
      ==
    ::
    ::  export will now form a list of cards to graph-store
    ::
    %-  %-  slog
        :~  leaf+"%oger-remake-local"
            leaf+"-remake-starting"
            leaf+"-group: {<gro.vaz>}"
            leaf+"-resource: [{(scow %p our.bol)} {<wer.vaz>}]"
        ==
    :_  state
    =-  :-  %-  graph:make
            [wer.vaz ;;(?(%chat %link %publish) typ)]
        :_  -
        %-  metadata:make 
        [wer.vaz gro.vaz ;;(?(%chat %link %publish) typ)]
    (~(rep by graph.q.upd) ~(renu perk [our.bol wer.vaz]))
  ==
--