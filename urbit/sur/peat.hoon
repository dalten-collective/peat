::
::  /sur/peat - a series of tubeson
::
/-  store=graph-store, metas=metadata-store, post
/+  *jag
::
^?
|%
::  cheat codes
::
+$  index      index:store
+$  content    content:post
+$  resource   resource:store
+$  resources  (set resource)
::
::  shape - a shorthand for validator purposes
::
+$  shape  ?(%chat %link %publish %dm)
::
::  repete - peat's actions - user interface
::    -  [%export res=resource rec=(unit @dr)]
::      export files, recurring? (minimum/default ~d1)
::    -  [%cancel res=resource]
::      cancel auto-save
::    -  [%import gol=path gro=(each resource term) wer=term]
::      import files
::        > clay path to import folder
::        > extant group resource or new group name
::        > new resource name - we'll make it for you
::    -  [%permit per=(set ship) rys=resources]
::      permit subscribers to some resources
::    -  [%record ~]
::      on permit, subscribe
::    -  [%remove per=(set ship) rys=resources]
::      remove subscribers from some resources
::    -  [%depart p=ship]
::      remove a subscription you have
::    -  $:  %remake                                    
::         wat=(each resource [p=ship q=shape r=resource]
::         gro=(each resource term)                      
::         wer=term                                      
::       ==
::      remakes a remote or local resource
::        > which resource to remake, local or remote
::        > group in which to place the new resource
::        > new resource name - we'll make it for you
::
+$  repete
  $%  [%export res=resource rec=(unit @dr)]
      [%cancel res=resource]
    ::
      $:  %import
          fol=path
          gro=(each resource term)
          wer=term
      ==
    ::
      [%permit per=(set ship) rys=resources]
      [%record ~]
      [%remove per=(set ship) rys=resources]
      [%depart p=ship]
    ::
      $:  %remake
          wat=(each resource [p=ship q=shape r=resource])
          gro=(each resource term)
          wer=term
      ==
      [%relay jon=json]
  ==
::
::  peat's facts - agent interface
::  -  %kil - remove a resource from available set
::  -  %hav - update, added resources/allresources
::
+$  peep
  $%  [%kil to=(set ship) res=resource sup=(unit shape)]
      [%hav to=(set ship) raj=(jug shape resource)]
  ==
--