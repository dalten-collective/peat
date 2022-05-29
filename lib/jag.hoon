|%
++  jag
  |$  [kex kax val]
  (map kex (jug kax val))
++  ba
  |*  [kex=mold kax=mold val=mold]
  |_  a=(jag kex kax val)
  ++  has
    |=  [b=kex c=kax]
    ::~>  %bout.[0 'has:ba:jag-moist']
    ^-  ?
    !=(~ (get b c))
  ::
  ++  key
    |=  b=kex
    ::~>  %bout.[0 'kax:ba:jag-moist']
    ^-  (set kax)
    ~(key by `(jug kax val)`(~(gut by a) b ~))
  ::
  ++  gut
    |=  [b=kex c=kax d=(set val)]
    ::~>  %bout.[0 'gut:ba:jag-moist']
    ^-  (set val)
    (~(gut by (~(gut by a) b ~)) c d)
  ::
  ++  get
    |=  [b=kex c=kax]
    ::~>  %bout.[0 'get:ba:jag-moist']
    ^-  (set val)
    (~(get ju `(jug kax val)`(~(gut by a) b ~)) c)
  ::
  ++  gas
    |=  b=(list [p=kex q=kax r=(set val)])
    ::~>  %bout.[0 'gas:ba:jag-moist']
    |-  ^+  a
    ?~  b
      a
    =+  gab=(get p.i.b q.i.b)
    %=  $
      b  t.b
    ::
        a
      %+  ~(put by a)  p.i.b
      %+  ~(put by `(jug kax val)`(~(gut by a) p.i.b ~))
      q.i.b  (~(uni in gab) r.i.b)
    ==
  ++  car                                               ::  like gas, but w/ individual values for the jug
    |=  b=(list [p=kex q=kax r=val])
    ::~>  %bout.[0 'car:ba:jag-moist']
    |-  ^+  a
    ?~  b
      a
    =+  gab=(get p.i.b q.i.b)
    %=  $
      b  t.b
    ::
        a
      %+  ~(put by a)  p.i.b
      %+  ~(put by `(jug kax val)`(~(gut by a) p.i.b ~))
      q.i.b  (~(put in gab) r.i.b)
    ==
  ::
  ++  put
    |=  [b=kex c=kax d=val]
    ::~>  %bout.[0 'put:ba:jag-moist']
    ^+  a
    %+  ~(put by a)  b
    %.  [c d]
    %~  put  ju
    `(jug kax val)`(~(gut by a) b ~)
  ::
  ++  put-s                                              ::  unify or put an incoming set
    |=  [b=kex c=kax d=(set val)]
    ::~>  %bout.[0 'put-s:ba:jag-moist']
    ?~  hab=(~(get by a) b)
      (~(put by a) b (~(put by *(map _c _d)) c d))
    ?~  haf=(~(get by u.hab) c)
      (~(put by a) b (~(put by u.hab) c d))
    %+  ~(put by a)  b
    %+  ~(put by (~(del by u.hab) c))  c
    (~(uni in u.haf) d)
  ::
  ++  del
    |=  [b=kex c=kax d=val]
    ::~>  %bout.[0 'del:ba:jag-moist']
    ?~  hab=(~(get by a) b)  a
    (~(put by a) b (~(del ju u.hab) c d))
  ::
  ++  del-s                                              ::  compare set for set,
    |=  [b=kex c=kax d=(set val)]                                    ::  deleting items from sample set
    ::~>  %bout.[0 'del-s:ba:jag-moist']
    ?~  hab=(~(get by a) b)  a
    ?~  haf=(~(get by u.hab) c)  a
    %+  ~(put by a)  b
    (~(put by u.hab) c (~(dif in u.haf) d))
  ::
  ++  tap
    ::NOTE  idk what naive turn-based implementation find-errors are ):
    =<  $
    =+  b=`(list [kex kax (set val)])`~
    |.  ^+  b
    ::~>  %bout.[0 'tap:ba:jag-moist']
    ?~  a
      b
    $(a r.a, b `_b`(welp (turn ~(tap by q.n.a) (lead p.n.a)) $(a l.a)))
  --
--