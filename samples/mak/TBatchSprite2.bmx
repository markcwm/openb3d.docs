' TBatchSprite2.bmx
' note: this code isn't finished

'Rem
'bbdoc: Batch sprite mesh entity
'End Rem
Type TBatchSpriteMesh2 Extends TMesh

	'Field surf:TSurface 
	'Field free_stack:Int[1] ' list of available vertex
	'Field num_sprites:Int=0
	'Field sprite_list:TList
	''Field mat_sp:Matrix=New Matrix
	'Field id:Int=0
	'Field cam_sprite:TSprite ' use this to get cam info
	
	Function CreateObject:TBatchSpriteMesh2( inst:Byte Ptr ) ' Create and map object from C++ instance
	
		If inst=Null Then Return Null
		Local obj:TBatchSpriteMesh2=New TBatchSpriteMesh2
		?bmxng
		ent_map.Insert( inst,obj )
		?Not bmxng
		ent_map.Insert( String(Int(inst)),obj )
		?
		obj.instance=inst
		obj.InitFields()
		Return obj
		
	End Function
	
	Method InitFields() ' Once per CreateObject
	
		Super.InitFields()
		
	End Method
	
	Rem
	Function NewBatchSpriteMesh:TBatchSpriteMesh2()
	
		Local inst:Byte Ptr=NewMesh_()
		Return CreateObject(inst)
		
	End Function
	EndRem
	
	' create batch controller
	Function Create:TBatchSpriteMesh2( parent_ent:TEntity=Null )
	
		
		
	EndFunction
	
	Method Update()
	
		
		
	EndMethod
	
EndType

Type TBatchSprite2 Extends TSprite

	'Field batch_id:Int ' ids start at 1
	'Field vertex_id:Int
	''Field sprite_link:list.Node<TBatchSprite>
	'Field sprite_link:TLink
	
	'Global b_min_x:Float, b_min_y:Float, b_max_x:Float, b_max_y:Float, b_min_z:Float, b_max_z:Float
	Global mainsprite:TBatchSpriteMesh2[]=New TBatchSpriteMesh2[10]	
	Global total_batch:Int=0
	'Global temp_mat:TMatrix=NewMatrix()
	
	Function CreateObject:TBatchSprite2( inst:Byte Ptr ) ' Create and map object from C++ instance
	
		If inst=Null Then Return Null
		Local obj:TBatchSprite2=New TBatchSprite2
		?bmxng
		ent_map.Insert( inst,obj )
		?Not bmxng
		ent_map.Insert( String(Int(inst)),obj )
		?
		obj.instance=inst
		obj.InitFields()
		Return obj
		
	End Function
	
	Method InitFields() ' Once per CreateObject
	
		Super.InitFields()
		
	End Method
	
	Rem
	Function NewBatchSprite:TBatchSprite2()
	
		Local inst:Byte Ptr=NewSprite_()
		Return CreateObject(inst)
		
	End Function
	EndRem
	
	Method New()
		' new batch sprite, not added to entity list
	EndMethod
	
	Method Copy()
		' use CreateSprite(), since they should all be the same
	EndMethod
	
	' add a parent to the entire batch mesh -- position only
	Function BatchSpriteParent( id:Int=0, ent:TEntity, glob:Int=True )
	
		
		
	EndFunction
	
	' return the sprite batch main mesh entity
	Function BatchSpriteEntity:TEntity( batch_sprite:TBatchSprite2=Null )
	
		Local inst:Byte Ptr=BatchSpriteEntity_( GetInstance(batch_sprite) )
		Local ent:TEntity=TEntity.GetObject(inst)
		'If ent=Null And inst<>Null Then ent=TEntity.CreateObject(inst)
		Return ent
		
	EndFunction
	
	' move the batch sprite origin for depth sorting
	Method BatchSpriteOrigin( x:Float, y:Float, z:Float )
		
		
	EndMethod
	
	Function CreateBatchMesh:TBatchSpriteMesh2( batchid:Int )
	
		
		
	EndFunction
	
	' add sprite to batch, use this instead of TSprite.CreateSprite()
	' if you want to add to specifc batch controller, use BatchSpriteEntity as parent_ent
	Function CreateBatchSprite:TBatchSprite2( parent_ent:TEntity=Null )
	
		Local inst:Byte Ptr=CreateBatchSprite_( GetInstance(parent_ent) )
		Return CreateObject(inst)
		
	EndFunction
	
	Function LoadBatchTexture:TBatchSpriteMesh2( tex_file$, tex_flag:Int=1, id:Int=0 )
	
		Select TGlobal.Texture_Loader
		
			Case 2 ' library
				Local cString:Byte Ptr=tex_file.ToCString()
				Local inst:Byte Ptr=LoadBatchTexture_( cString,tex_flag,id )
				Local mesh:TBatchSpriteMesh2=TBatchSpriteMesh2.CreateObject(inst)
				MemFree cString
				Return mesh
				
			Default ' wrapper
				' does not create sprite, just loads texture
				If id<=0 Or id>total_batch Then id=total_batch
				If id=0 Then id=1
				CreateBatchMesh(id)
				
				Local tex:TTexture=LoadTexture(tex_file, tex_flag)
				mainsprite[id].EntityTexture(tex)
				
				' additive blend if sprite doesn't have alpha or masking flags set
				If (tex_flag & 2)=0 And (tex_flag & 4)=0
					mainsprite[id].EntityBlend 3
				EndIf
				
				Return mainsprite[id]
				
		EndSelect
	
		
		
	EndFunction
	
	Method UpdateBatch( cam_sprite:TSprite )
	
		
		
	End Method
	
EndType
