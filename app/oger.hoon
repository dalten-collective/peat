::
:: oger - a pack rat
::
/-  *oger,
    post,
    resource,
    store=graph-store,
    metas=metadata-store
/+  default-agent, dbug, res-lib=resource
::
|%
+$  versioned-state
    $%  state-zero
        state-one
    ==
::
::    state-one adds per, which simply is a set of ships
::  who are allowed to ask you about your resources and
::  to clone them.
::
+$  state-one
  $:  %1 
      resources=(set resource)
      permits=(set ship)
      known=(jug ship [res=resource con=md-config:metas])
  ==
+$  state-zero  [%0 ser=(set resource)]
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
  [%pass /graph-store/keys %agent [our.bowl %graph-store] %watch /keys]~
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
    %1  [check-watch this(state old)]
    %0  $(old [%1 ser.old ~ ~])
  ==
  ++  check-watch
    =|  caz=(list card)
    =?    caz
        %-  ~(has in wex.bowl)
        :_  [%.y /keys]
        [/keys/oger/(scot %p our.bowl) our.bowl %graph-store]
      :_  caz
      :+  %pass  /keys/oger/(scot %p our.bowl)
      [%agent [our.bowl %graph-store] %leave ~]
    ?:  %-  ~(has in wex.bowl)
        :_  [%.y /keys]
        [/keys/oger/(scot %p our.bowl) our.bowl %graph-store]
      caz
    :_  caz
    :+  %pass  /graph-store/keys
    [%agent [our.bowl %graph-store] %watch /keys]
  --
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  =(mark %oger-horde)
  =/  vaz  !<(horde vase)
  ?-    -.vaz
      %export
    ::  :graph-store &graph-update-3 [~2021.12.20..18.57.55..220c.49ba.5e35.3f7c [%add-nodes [~zod %transferred-post-6460] my-map]]
    ?.  (~(has in resources) res.vaz)
      %.  `this  %-  slog
      :~  leaf+"%oger-export"
          leaf+"-unknown-resource"
      ==
      ::
    =*  ent  (scot %p entity.res.vaz)
    =*  nam  (scot %tas name.res.vaz)
    =/  met=path
      %+  weld  /=metadata-store=/metas/graph
      (weld (en-path:res-lib res.vaz) /noun)
    ?~  ass=~(assoc scry:hc met)
      %.  `this  %-  slog
      :~  leaf+"%oger-export"
          leaf+"-no-metadata-found"
          leaf+"-report-to-management"
      ==
      ::
    ?.  ?=(%graph -.config.metadatum.u.ass)
      %.  `this  %-  slog
      :~  leaf+"%oger-export"
          leaf+"-strange-request"
          leaf+"-report-to-management"
      ==
      ::
    =*  app  (scot %tas %graph)
    =*  typ  (scot %tas module.config.metadatum.u.ass)
    ::
    =/  upd=update:store  ~(graph scry:hc /ent/nam)
    ?.  ?=(%add-graph -.q.upd)
      %.  `this  %-  slog
      :~  leaf+"%oger-export"
          leaf+"-strange-display"
          leaf+"-report-to-management"
      ==
      ::
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
      %+  rap  3
      ~[nam '|' app '|' typ '|' (scot %ud pag)]
    ?:  (lte (lent par) 50)
      %-  %-  slog
          :~  leaf+"%oger-export"
              leaf+"-export-starting"
              leaf+"-check-directory /pier/.urb/put"
              leaf+"-expected-file-count {<pag>}"
          ==
      :_  this
      %+  welp  cop
      :~  :*
        %pass   /oger/export/(scot %ud pag)/(scot %da now.bowl)
        %agent  [our.bowl %hood]
        %poke   %drum-put  !>([/nam/(scot %ta jeff)/jam (jam par)])
      ==  ==
    %=    $
      par  (oust [0 50] par)
      pag  +(pag)
    ::
        cop
      %+  welp  cop
      :~  :*
        %pass   /oger/export/(scot %ud pag)/(scot %da now.bowl)
        %agent  [our.bowl %hood]
        %poke   %drum-put  !>([/nam/(scot %ta jeff)/jam (jam (scag 50 par))])
      ==  ==
    ==
    ::
        %import
      ?.  ~(exist scry:hc fol.vaz)
        %.  `this  %-  slog
        :~  leaf+"%oger-import"
            leaf+"-import-failed"
            leaf+"-invalid-folder-path {<fol.vaz>}"
        ==
        ::
      ?:  (~(has in resources) [our.bowl wer.vaz])
        %.  `this  %-  slog
        :~  leaf+"%oger-import"
            leaf+"-import-failed"
            leaf+"-invalid-resource [{(scow %p our.bowl)} {(scow %tas wer.vaz)}]"
            leaf+"-already-extant!"
        ==
        ::
      ?.  %.  gro.vaz
          %~  has  in
          ~(group scry:hc /(scot %p our.bowl)/group-store/(scot %da now.bowl)/groups)
        %.  `this  %-  slog
        :~  leaf+"%oger-import"
            leaf+"-import-failed"
            leaf+"-invalid-group {<gro.vaz>}"
        ==
        ::
      ?.  ~(exist scry:hc fol.vaz)
        %.  `this  %-  slog
        :~  leaf+"%oger-import"
            leaf+"-import-failed"
            leaf+"-invalid-path {<fol.vaz>}"
            leaf+"-no-jam-files"
        ==
        ::
      ?~  sha=~(shape scry:hc fol.vaz)
        %.  `this  %-  slog
        :~  leaf+"%oger-import"
            leaf+"-import-failed"
            leaf+"-indeterminate-shape"
            leaf+"-call-your-mother!"
        ==
        ::
      =|  cop=(list card)
      =/  bak=(list p=path q=*)  ~(notes scry:hc fol.vaz)
      |-
      ?~  bak
        %-  %-  slog
            :~  leaf+"%oger-import"
                leaf+"-import-starting"
                leaf+"-group: {<gro.vaz>}"
                leaf+"-resource: [{(scow %p our.bowl)} {<wer.vaz>}]"
            ==
        :_  this
        :-  (graph:make:hc wer.vaz u.sha)
        [(metadata:make:hc wer.vaz gro.vaz u.sha) cop]
      =/  old=graph:store
        %-  malt
        ;;  (list [atom node:store])
        (cue .^(@ %cx :(weld fol.vaz p.i.bak /jam)))
      %=    $
        bak  t.bak
        cop  (welp cop (~(rep by old) ~(renu perk [our.bowl wer.vaz])))
      ==
    ::
        %permit
      =.  permits
        (~(uni in permits) per.vaz)
      %.  `this  %-  slog
      :~  leaf+"%oger-permit"
          leaf+"permitted ships: {<permits>}"
          leaf+"added ships: {<per.vaz>}"
      ==
    ::
        %remove
      =.  permits
        (~(del in permits) per.vaz)
      %.  `this  %-  slog
      :~  leaf+"%oger-permit"
          leaf+"permitted ships: {<permits>}"
          leaf+"removed ships: {<per.vaz>}"
      ==
    ::
        %search
      `this
        %remake
      `this
    ==
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    -.sign  `this
      %kick
    =+  (slav %uv +<.wire)
    :_  this
    :~  :*
      %pass   /keys/oger/(scot %p our.bowl)
      %agent  [src.bowl %graph-store]
      %watch  /keys
    ==  ==
  ::
      %fact
    ?>  =(/keys/oger/(scot %p our.bowl) wire)
    ?.  ?=(%graph-update-3 p.cage.sign)
      `this
    =/  upd=update:store  !<(update:store q.cage.sign)
    ?+    -.q.upd  !!
        %keys
      `this(resources resources.q.upd)
    ==
  ==
::
++  on-arvo  on-arvo:def
++  on-fail  on-fail.def
++  on-peek  on-peek:def
++  on-leave  on-leave:def
++  on-watch  on-watch:def
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
  ++  metadata
    |=  [name=term group=resource shape=?(%chat %link %publish)]
    ^-  card:agent:gall
    :^  %pass  `path`/oger/assoc/meta  %agent
    :^  [our.bol %metadata-store]  %poke  %metadata-update-2
    !>  ^-  action:metas
    :^  %add  group  [%graph [our.bol name]]
    [`@t`name '' 0x0 now.bol our.bol [%graph shape] '' %.n %.n %$]
  --
++  scry
  |_  pat=path
  ++  assoc
    ^-  (unit association:metas)
    .^((unit association:metas) %gx pat)  
  ++  curve
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
  ++  graph
    ^-  update:store
    .^(update:store %gx ;:(weld /graph pat /noun))
  ++  group
    ^-  (set resource)
    .^  (set resource)  %gy
        /(scot %p our.bol)/group-store/(scot %da now.bol)/groups
    ==
  ++  shape
    ^-  (unit ?(%chat %link %publish))
    =+  curve
    ?~  dis=dir.-  ~
    ?~  nos=(rush p:(head dis) ;~((glue bar) sym sym sym dem))  ~
    =+  typ=+>-.u.nos
    ?+  typ  ~
      %chat     `;;(?(%chat %link %publish) typ)
      %link     `;;(?(%chat %link %publish) typ)
      %publish  `;;(?(%chat %link %publish) typ)
    ==
  --
--