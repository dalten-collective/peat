/-  spider, group=group-store, oger
/+  *strandio
::
=,  strand=strand:spider
::
::  helper core
::
|%
+$  card   card:agent:gall
+$  horde  horde:oger
--
::
::  makes a group, returns an %oger-horde [%import fil nom]
::
^-  thread:spider
|=  grop=vase
=/  m  (strand ,vase)
^-  form:m
;<  =bowl:spider  bind:m  get-bowl
=,  bowl
::
=+  mynd=!<((unit [ntre=horde hors=term durv=cage]) grop)
?~  mynd  (pure:m !>(~))
=,  u.mynd
;<  ~             bind:m  (poke-our hors durv)
;<  ~             bind:m  (sleep ~s2)
;<  ~             bind:m  (flog-text "%oger -mk-group-return success")
(pure:m !>(`horde`ntre))