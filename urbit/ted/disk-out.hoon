/-  spider, *peat, store=graph-store, metas=metadata-store
/+  *strandio, plib=peat
::
=,  strand=strand:spider
::
^-  thread:spider
|^  disk-drive
::
++  disk-drive
^-  thread:spider
|=  insert=vase
=/  m  (strand ,vase)
^-  form:m
;<  =time  bind:m  (io !<([bowl:gall resource] insert))
(pure:m !>(time))
::
++  io
  |=  [bol=bowl:gall r=resource]
  =/  m  (strand ,time)
  ^-  form:m
  =+  pl=~(. plib bol)
  =+  dr=~(. diskette bol r)
  |^
  ;<  ~  bind:m  io-nize
  ;<  tim=time  bind:m  io-time
  (pure:m tim)
  ::
  ++  io-file
    |=  [fna=@t fil=(list [@ node:store])]
    =/  m  (strand ,~)
    ^-  form:m
    =-  ;<  ~  bind:m  (poke [our.bol %hood] -)
      (pure:m ~)
    [%dill-blit !>([%sag /[nam:dr]/[fna]/jam fil])]
  ::
  ++  io-read
    =/  m  (strand ,update:store)
    ^-  form:m
    ;<  upd=update:store  bind:m  (scry update:store sector-g-graph:dr)
    (pure:m upd)
  ::
  ++  io-time
    =/  m  (strand ,time)
    ^-  form:m
    ;<  maybe-time=*  bind:m  (scry * sector-g-time:dr)
    (pure:m `time`(need ;;((unit time) maybe-time)))
  ::
  ++  io-json
    |=  jon=json
    =/  m  (strand ,~)
    ;<  ~  bind:m  %+  poke
                     [our.bol %peat]
                   [%peat-repete !>(`repete`[%relay jon])]
    (pure:m ~)
  ::
  ++  io-type
    =/  m  (strand ,[app=@t typ=@t])
    ^-  form:m
    ;<  ass=(unit association:metas)  bind:m
      (scry (unit association:metas) sector-m-assoc:dr)
    =-  (pure:m -)
    ?~  ass  ~.dm^~.dm
    ?>  ?=(%graph -.config.metadatum.u.ass)
    ~.graph^(scot %tas module.config.metadatum.u.ass)
  ::
  ++  io-nize
    =/  m  (strand ,~)
    ^-  form:m
    ;<  upd=update:store  bind:m  io-read
    ?>  ?=(%add-graph -.q.upd)
    =/  par=(list [@ node:store])
      (bap:((on @ node:store) gth) graph.q.upd)
    =/  tot=@ud
      (add (div (lent par) 500) (mod (lent par) 500))
    =/  pag=@ud  1
    ;<  phrase=[app=@t mod=@t]  bind:m  io-type
    |-
    =/  filename=@t
      (rap 3 ~[app.phrase '_' mod.phrase '_' (scot %ud pag)])
    ?:  (lte (lent par) 500)
      ;<  ~  bind:m  (io-file filename par)
      ;<  ~  bind:m  %-  io-json
                     %-  pairs:enjs:format
                     :~  :-  %resource
                         %-  pairs:enjs:format
                         :~  entity+s+(scot %p entity.r)
                             name+s+name.r
                         ==
                       ::
                         [status+s+'Export Complete']
                     ==
      %-  %-  slog
      :~  leaf+"%peat -disk-out"
          leaf+"-exporting-{(trip +.phrase)}"
          leaf+"-check-directory /pier/.urb/put/{(trip +.r)}"
      ==
      (pure:m ~)
    ;<  ~  bind:m  (io-file filename (scag 500 par))
    ;<  ~  bind:m  %-  io-json
                   %-  pairs:enjs:format
                   :~  :-  %resource
                       %-  pairs:enjs:format
                       :~  entity+s+(scot %p entity.r)
                           name+s+name.r
                       ==
                     ::
                       [%page-count (numb:enjs:format tot)]
                       [%page-next (numb:enjs:format pag)]
                   ==
    ;<  ~  bind:m  (sleep ~s0..2aaa.aaaa.aaaa.aaaa)
    $(pag +(pag), par (oust [0 500] par))
  --
::
++  diskette
  |_  [b=bowl:gall r=resource]
  ++  our
    (scot %p our.b)
  ++  now
    (scot %da now.b)
  ++  ent                                                ::  resource entity as path
    (scot %p entity.r)
  ++  nam                                                ::  resource name as path
    (scot %tas name.r)
  ++  sector-g-time                                      ::  latest timestamp
    ^-  path
    /gx/graph-store/update-log/[ent]/[nam]/latest/noun
  ++  sector-g-graph                                     ::  graph
    ^-  path
    /gx/graph-store/graph/[ent]/[nam]/noun
  ++  sector-m-assoc                                     ::  associations
    ^-  path
    /gx/metadata-store/metadata/graph/ship/[ent]/[nam]/noun
  --
--