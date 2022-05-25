::
::  /sur/peat - a series of tubes - by Quartus Corporation
::
/-  store=graph-store, metas=metadata-store, post
/+  *jag
::
^?
|%
::    state-zero
::  - saved  (map resource [index @dr]) - resources that are being auto-saved
::  - given  (jag ship shape resource) - resources shared with you
::  - doled  (jag ship shape resource) - resources you've shared out
::  - known  (jag shape (unit resource) resource)
::    - resources you're aware of in graph store by shape, group
::
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
::
+$  repete
  $%  [%export res=resource rec=(unit @dr)]              ::  export files, recurring? (minimum/default ~d1)
      [%cancel res=resource]                             ::  cancel auto-save
    ::
      $:  %import                                        ::  import files
          fol=path                                       ::  - clay path to import folder
          gro=(each resource term)                       ::  - group in which to place new resource, or name for new group
          wer=term                                       ::  - new resource name - we'll make it for you
      ==
    ::
      [%permit per=(set ship) rys=resources]             ::  permit subscribers
      [%record ~]                                        ::  - on permit
      [%remove per=(set ship) rys=resources]             ::  remove subscribers
      [%depart per=(set ship)]                           ::  remove a subscription
    ::
      $:  %remake                                        ::  remakes a remote or local resource
          wat=(each resource [ship resource])            ::  - which resource to remake, local or remote
          gro=resource                                   ::  - group in which to place the new resource
          wer=term                                       ::  - new resource name - we'll make it for you
      ==
  ==
::
::  peat's facts - agent interface
::
+$  peep
  $%  [%kil to=(set ship) res=resource sup=(unit shape)] ::  remove a resource from available set
      [%hav to=(set ship) raj=(jug shape resource)]      ::  update, added resources/all resources
  ==
--