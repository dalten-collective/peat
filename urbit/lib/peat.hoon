::
::  /lib/peat - a macbook pro, baby
::
/-  store=graph-store,
    views=graph-view,
    metas=metadata-store,
    grops=group-store,
    grews=group-view,
    group,
    pushy=push-hook,
    *peat
/+  res-lib=resource
::^?
=>  
  |%
  +$  card  card:agent:gall
  ::
  ::  graph stuff
  ::
  +$  node       node:store
  +$  update     update:store
  +$  action     action:store
  +$  gra-vew    action:views
  ::
  ::  metas stuff
  ::
  +$  met-act      action:metas
  +$  association  association:metas
  +$  md-resource  md-resource:metas
  ::
  ::  group stuff
  ::
  +$  diff     diff:policy:group
  +$  gro-act  action:grops
  +$  gro-vew  action:grews
  ::
  ::  push-hook stuff
  ::
  +$  pew-act  action:pushy
  --
|_  bol=bowl:gall
++  pek
  |%
  ++  gra-p
    (path /(scot %p our.bol)/graph-store/(scot %da now.bol))
  ++  gro-p
    (path /(scot %p our.bol)/group-store/(scot %da now.bol))
  ++  met-p
    (path /(scot %p our.bol)/metadata-store/(scot %da now.bol))
  ::
  ++  arc-s                                              ::  scry an arch
    |=  pat=path
    ^-  arch
    .^(arch %cy (welp /(scot %p our.bol)/peat/(scot %da now.bol)/hav pat))
  ++  gra-s                                              ::  scry a graph thing
    |*  [mol=mold pat=path]
    ^-  ,mol
    .^(mol %gx ;:(weld gra-p pat /noun))
  ++  met-s                                              ::  scry a metadata thing
    |*  [mol=mold pat=path]
    ^-  ,mol
    .^(mol %gx ;:(weld met-p pat /noun))
  ::
  ++  recent                                             ::  most recent post in a graph
    |=  r=resource
    ^-  (unit time)
    ;;  (unit time)
    .^  *  %gx
      %+  weld  gra-p
      /update-log/(scot %p -.r)/(scot %tas +.r)/latest/noun
    ==
  ::
  ++  llaves                                             ::  current graph keys
    ^-  (set resource)
    =+  upd=(gra-s:pek update /keys)
    ?>  ?=(%keys -.q.upd)
    resources.q.upd
  ++  mippet                                             ::  get shape, group of resource
    |=  r=resource
    ;;  (unit [shape (unit resource) resource])
    =;  u=[w=(unit @tas) b=(unit resource)]
      ?~  w.u  ~
      %+  rush  u.w.u
      ;~  pfix
        (jest 'graph-validator-')
        (cook |=(@tas [;;(shape +<) b.u r]) sym)
      ==
    =-  ?~  mar=-  [~ ~]
        ?:  ?=(%graph-validator-post u.mar)  [~ ~]
        :-  mar
        =-  ?~(emc=- ~ `group.u.emc)
        %.  `md-resource`[%graph r]
        %~  get  by
        (met-s:pek (map md-resource association) /associations)
    %+  gra-s  (unit @tas)
    /graph/(scot %p entity.r)/(scot %tas name.r)/mark
  ::
  ++  stacks                                             ::  what's in /hav (jug shape [name=@tas lent=@ud])
    ^-  (jug shape [name=@tas lent=@ud])
    %-  ~(rep in dir:(arc-s /))
    |=  [p=[n=@ta %~] q=(jug shape [name=@tas lent=@ud])]
    ?~  dir=~(tap in dir:(arc-s:pek /[n.p]))  q
    ?~  dyt=(rush p.i.dir ;~((glue cab) sym sym dem))  q
    (~(put ju q) ;;(shape +<.u.dyt) [n.p (lent dir)])
  ::
  ++  tables                                             ::  in: (set known-resource) -> out: (set resource length)
    |=  p=resources
    ^-  (set [res=resource lent=@ud])
    %-  sy  %+  murn  ~(tap in p)
    |=  r=resource
    ^-  (unit [res=resource lent=@ud])
    =;  upd=update
      ?.(?=(%add-nodes -.q.upd) ~ `[r (lent nodes.q.upd)])
    %+  gra-s:pek  update
    /graph/(scot %p entity.r)/(scot %tas name.r)
  ::
  ++  groups                                             ::  groups where I'm admin
    ^-  (set resource)
    %-  ~(rep in .^((set resource) %gy (weld gro-p /groups)))
    |=  [r=resource q=(set resource)]
    =;  g=(unit group:group)
      ?~  g  q
      ?.  (~(has in (~(get ju tags.u.g) %admin)) our.bol)
        ~
      (~(put in q) r)
    .^  (unit group:group)  %gx
      ;:(welp gro-p /groups (en-path:res-lib r) /noun)
    ==
  --
++  biz
  |%
  ++  add-to-old-group
    |=  [r=resource s=shape gr=resource]                 ::  graph shape group
    ?.  (~(has in groups:pek) gr)                       ::  - are we a group admin?
      ~_(leaf+"%peat-fail -bad-group-remake" !!)
    :~  (graph name.r s)
        (metas r s gr)
        (pushy name.gr %graph-push-hook)
    ==
  ++  add-to-new-group
    |=  [r=resource s=shape n=term]                      ::  graph shape group-name
    :~  (group n)
        (pushy n %group-push-hook)
        (metag n)
        (pushy n %metadata-push-hook)
        (pushy n %contact-push-hook)
        (graph name.r s)
        (metas r s [our.bol n])
        (pushy n %graph-push-hook)
        (joins n)
    ==
  ++  group
    |=  n=term
    ^-  card
    :^  %pass  /pete/grop/[n]/(scot %da now.bol)  %agent
    :^  [our.bol %group-store]  %poke  %group-action
    !>(`gro-act`[%add-group [our.bol n] [%open ~ ~] %.n])
  ::
  ++  pushy
    |=  [n=term a=term]
    ^-  card
    :+  %pass  /pete/push/[n]/[a]/(scot %da now.bol)
    :^  %agent  [our.bol a]  %poke
    [%push-hook-action !>(`pew-act`[%add our.bol n])]
  ::
  ++  graph
    |=  [n=term s=shape]
    =-  ^-  card
      :^  %pass  /pete/grap/[n]/(scot %da now.bol)  %agent
      :^  [our.bol %graph-store]  %poke  %graph-update-3
      !>(`update`[now.bol [%add-graph [our.bol n] ~ `- %.y]])
    ?-  s
      %publish  %graph-validator-publish
      %link     %graph-validator-link
      %chat     %graph-validator-chat
      %dm       %graph-validator-dm
    ==
  ::
  ++  joins
    |=  n=term
    ^-  card
    :^  %pass  /pete/join/[n]/(scot %da now.bol)  %agent
    :^  [our.bol %group-store]  %poke  %group-action
    !>(`gro-act`[%add-members [our.bol n] (sy ~[our.bol])])
  ::
  ++  metas
    |=  [r=resource s=shape g=resource]
    ^-  card
    :^  %pass  /pete/metas/[name.r]/(scot %da now.bol)  %agent
    :^  [our.bol %metadata-push-hook]  %poke  %metadata-update-2
    =-  !>(`met-act`[%add g graph+r -])
    %*  .  *metadatum:^metas
      title         name.r
      description   '-revived by Peat from Quartus Co'
      picture       'https://ipfs.io/ipfs/QmZbUnGxk7JPndNMQNNbremEBpbNnMKCfuUnWEiDZNpfrL'
      date-created  now.bol
      creator       our.bol
      config        graph+s
      hidden        %.n
    ==
  ::
  ++  metag
    |=  n=term
    ^-  card
    :^  %pass  /pete/metag/[n]/(scot %da now.bol)  %agent
    :^  [our.bol %metadata-store]  %poke  %metadata-action
    !>  ^-  met-act
    :^  %add  [our.bol n]  groups+[our.bol n]
    %*  .  *metadatum:^metas
      title         n
      description   '-revived by Peat from Quartus Co'
      picture       'https://ipfs.io/ipfs/QmZbUnGxk7JPndNMQNNbremEBpbNnMKCfuUnWEiDZNpfrL'
      date-created  now.bol
      creator       our.bol
      config        group+~
      hidden        %.n
    ==
  --
--