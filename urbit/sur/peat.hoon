::
::  /sur/peat - a series of tubeson
::
/-  store=graph-store, 
    metas=metadata-store,
    post
/+  *jag
::
^?
|%
::  cheat codes
::
+$  flag     (pair ship term)
+$  index    index:store
+$  content  content:post
::
++  groups
  |%
  +$  shape  ?(%chat %heap %diary %all)
  +$  change
    $:  act=?(%rem %add)
        sap=shape
        wat=(each flag (pair flag flag))
    ==
  --
++  graphs
  |%
  ::  +shape: a shorthand for validator purposes
  +$  shape  ?(%chat %link %publish %dm)
  --
+$  repete
  $%  [%graph re-graph]
      [%group re-group]
      [%grade up-grade]
  ==
+$  re-group
  $%  [%export =flag fuse=(unit @dr)]
      [%cancel =flag]
      [%import =path host=(each flag term) name=term]
  ==
::
+$  re-graph
  $%  [%export =flag fuse=(unit @dr)]
      [%cancel =flag]
      [%import =path host=(each flag term) name=term]
  ==
+$  up-grade
  $%  [%import graph-jam=path ]
--