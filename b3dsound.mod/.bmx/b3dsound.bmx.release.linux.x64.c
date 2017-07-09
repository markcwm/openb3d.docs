#include <openb3dmods.mod/b3dsound.mod/.bmx/b3dsound.bmx.release.linux.x64.h>
struct BBDebugScope_23{int kind; const char *name; BBDebugDecl decls[24]; };
struct BBDebugScope_4{int kind; const char *name; BBDebugDecl decls[5]; };
struct openb3dmods_b3dsound_ListeningPoint_obj* openb3dmods_b3dsound_HearingPoint;
struct brl_linkedlist_TList_obj* openb3dmods_b3dsound_SoundPointsList=&bbNullObject;
void _openb3dmods_b3dsound_ListeningPoint_New(struct openb3dmods_b3dsound_ListeningPoint_obj* o) {
	bbObjectCtor(o);
	o->clas = (BBClass*)&openb3dmods_b3dsound_ListeningPoint;
	o->_openb3dmods_b3dsound_listeningpoint_listenpoint = &bbNullObject;
	o->_openb3dmods_b3dsound_listeningpoint_soundfalloffend = .0f;
	o->_openb3dmods_b3dsound_listeningpoint_dopplerscale = .0f;
}
struct BBDebugScope_4 openb3dmods_b3dsound_ListeningPoint_scope ={
	BBDEBUGSCOPE_USERTYPE,
	"ListeningPoint",
	{
		{
			BBDEBUGDECL_FIELD,
			"ListenPoint",
			":TEntity",
			.field_offset=offsetof(struct openb3dmods_b3dsound_ListeningPoint_obj,_openb3dmods_b3dsound_listeningpoint_listenpoint)
		},
		{
			BBDEBUGDECL_FIELD,
			"SoundFalloffEnd",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_ListeningPoint_obj,_openb3dmods_b3dsound_listeningpoint_soundfalloffend)
		},
		{
			BBDEBUGDECL_FIELD,
			"DopplerScale",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_ListeningPoint_obj,_openb3dmods_b3dsound_listeningpoint_dopplerscale)
		},
		{
			BBDEBUGDECL_TYPEMETHOD,
			"New",
			"()",
			&_openb3dmods_b3dsound_ListeningPoint_New
		},
		BBDEBUGDECL_END
	}
};
struct BBClass_openb3dmods_b3dsound_ListeningPoint openb3dmods_b3dsound_ListeningPoint={
	&bbObjectClass,
	bbObjectFree,
	&openb3dmods_b3dsound_ListeningPoint_scope,
	sizeof(struct openb3dmods_b3dsound_ListeningPoint_obj),
	_openb3dmods_b3dsound_ListeningPoint_New,
	bbObjectDtor,
	bbObjectToString,
	bbObjectCompare,
	bbObjectSendMessage,
	0,
	0,
	offsetof(struct openb3dmods_b3dsound_ListeningPoint_obj,_openb3dmods_b3dsound_listeningpoint_dopplerscale) - sizeof(void*) + sizeof(BBFLOAT)
};

void _openb3dmods_b3dsound_SoundPoint_New(struct openb3dmods_b3dsound_SoundPoint_obj* o) {
	bbObjectCtor(o);
	o->clas = (BBClass*)&openb3dmods_b3dsound_SoundPoint;
	o->_openb3dmods_b3dsound_soundpoint_relativesoundpoint = &bbNullObject;
	o->_openb3dmods_b3dsound_soundpoint_listenangulardifference = &bbNullObject;
	o->_openb3dmods_b3dsound_soundpoint_distance = .0f;
	o->_openb3dmods_b3dsound_soundpoint_angle = .0f;
	o->_openb3dmods_b3dsound_soundpoint_soundchannel = &bbNullObject;
	o->_openb3dmods_b3dsound_soundpoint_emiterobject = &bbNullObject;
	o->_openb3dmods_b3dsound_soundpoint_loudness = .0f;
	o->_openb3dmods_b3dsound_soundpoint_mastervolume = .0f;
	o->_openb3dmods_b3dsound_soundpoint_pan = .0f;
	o->_openb3dmods_b3dsound_soundpoint_panbump = .0f;
	o->_openb3dmods_b3dsound_soundpoint_depth = .0f;
	o->_openb3dmods_b3dsound_soundpoint_depthbump = .0f;
	o->_openb3dmods_b3dsound_soundpoint_rate = 1.00000000f;
	o->_openb3dmods_b3dsound_soundpoint_ratebump = .0f;
	o->_openb3dmods_b3dsound_soundpoint_volume = .0f;
	o->_openb3dmods_b3dsound_soundpoint_volumebump = .0f;
	o->_openb3dmods_b3dsound_soundpoint_paused = 0;
}
void _openb3dmods_b3dsound_SoundPoint_Delete(struct openb3dmods_b3dsound_SoundPoint_obj* o) {
	brl_audio_StopChannel(o->_openb3dmods_b3dsound_soundpoint_soundchannel );
	openb3d_openb3d_FreeEntity((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(o->_openb3dmods_b3dsound_soundpoint_relativesoundpoint ,&openb3d_openb3d_TEntity));
	openb3d_openb3d_FreeEntity((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(o->_openb3dmods_b3dsound_soundpoint_listenangulardifference ,&openb3d_openb3d_TEntity));
	bbObjectDtor(o);
}
struct openb3dmods_b3dsound_SoundPoint_obj* openb3dmods_b3dsound_SoundPoint_Create_TSoundPoint_TTSoundTTEntityffb(struct brl_audio_TSound_obj* bbt_TheSound,struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity,BBFLOAT bbt_EntityLoudness,BBFLOAT bbt_Volume,BBBYTE bbt_Qued){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_theTemp=bbObjectNew(&openb3dmods_b3dsound_SoundPoint);
	bbt_theTemp->_openb3dmods_b3dsound_soundpoint_relativesoundpoint =openb3d_openb3d_CreatePivot(openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_listenpoint );
	bbt_theTemp->_openb3dmods_b3dsound_soundpoint_listenangulardifference =openb3d_openb3d_CreatePivot(openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_listenpoint );
	bbt_theTemp->_openb3dmods_b3dsound_soundpoint_emiterobject =bbt_NoisyEntity;
	bbt_theTemp->_openb3dmods_b3dsound_soundpoint_soundchannel =brl_audio_AllocChannel();
	bbt_theTemp->_openb3dmods_b3dsound_soundpoint_mastervolume =bbt_Volume;
	bbt_theTemp->_openb3dmods_b3dsound_soundpoint_loudness =bbt_EntityLoudness;
	brl_audio_CueSound(bbt_TheSound,bbt_theTemp->_openb3dmods_b3dsound_soundpoint_soundchannel );
	bbt_theTemp->_openb3dmods_b3dsound_soundpoint_paused =bbt_Qued;
	(bbt_theTemp)->clas->m_Update(bbt_theTemp);
	brl_linkedlist_ListAddLast(openb3dmods_b3dsound_SoundPointsList,bbt_theTemp);
	return bbt_theTemp;
}
void _openb3dmods_b3dsound_SoundPoint_UpdatePosition(struct openb3dmods_b3dsound_SoundPoint_obj* o){
	BBFLOAT bbt_LastDistance=.0f;
	if(o->_openb3dmods_b3dsound_soundpoint_emiterobject !=&bbNullObject){
		openb3d_openb3d_PositionEntity(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(o->_openb3dmods_b3dsound_soundpoint_relativesoundpoint ,&openb3d_openb3d_TEntity)),openb3d_openb3d_EntityX(o->_openb3dmods_b3dsound_soundpoint_emiterobject ,1),openb3d_openb3d_EntityY(o->_openb3dmods_b3dsound_soundpoint_emiterobject ,1),openb3d_openb3d_EntityZ(o->_openb3dmods_b3dsound_soundpoint_emiterobject ,1),1);
		openb3d_openb3d_PointEntity(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(o->_openb3dmods_b3dsound_soundpoint_listenangulardifference ,&openb3d_openb3d_TEntity)),((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(o->_openb3dmods_b3dsound_soundpoint_relativesoundpoint ,&openb3d_openb3d_TEntity)),0.00000000f);
		o->_openb3dmods_b3dsound_soundpoint_angle =openb3d_openb3d_EntityYaw(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(o->_openb3dmods_b3dsound_soundpoint_listenangulardifference ,&openb3d_openb3d_TEntity)),0);
		bbt_LastDistance=o->_openb3dmods_b3dsound_soundpoint_distance ;
		o->_openb3dmods_b3dsound_soundpoint_distance =openb3d_openb3d_EntityDistance(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(o->_openb3dmods_b3dsound_soundpoint_listenangulardifference ,&openb3d_openb3d_TEntity)),((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(o->_openb3dmods_b3dsound_soundpoint_relativesoundpoint ,&openb3d_openb3d_TEntity)));
		if(o->_openb3dmods_b3dsound_soundpoint_volumebump !=-2.00000000f){
			o->_openb3dmods_b3dsound_soundpoint_volume =(o->_openb3dmods_b3dsound_soundpoint_mastervolume -(o->_openb3dmods_b3dsound_soundpoint_distance /(openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_soundfalloffend *o->_openb3dmods_b3dsound_soundpoint_loudness )));
			o->_openb3dmods_b3dsound_soundpoint_volume +=o->_openb3dmods_b3dsound_soundpoint_volumebump ;
			if(o->_openb3dmods_b3dsound_soundpoint_volume >1.00000000f){
				o->_openb3dmods_b3dsound_soundpoint_volume =1.00000000f;
			}else{
				if(o->_openb3dmods_b3dsound_soundpoint_volume <0.00000000f){
					o->_openb3dmods_b3dsound_soundpoint_volume =0.00000000f;
				}
			}
		}
		if(o->_openb3dmods_b3dsound_soundpoint_panbump !=-2.00000000f){
			o->_openb3dmods_b3dsound_soundpoint_pan =(-o->_openb3dmods_b3dsound_soundpoint_angle /90.0000000f);
			o->_openb3dmods_b3dsound_soundpoint_pan +=o->_openb3dmods_b3dsound_soundpoint_panbump ;
			if(o->_openb3dmods_b3dsound_soundpoint_pan >1.00000000f){
				o->_openb3dmods_b3dsound_soundpoint_pan =(1.00000000f-(o->_openb3dmods_b3dsound_soundpoint_pan -1.00000000f));
			}else{
				if(o->_openb3dmods_b3dsound_soundpoint_pan <-1.00000000f){
					o->_openb3dmods_b3dsound_soundpoint_pan =(-1.00000000f-(o->_openb3dmods_b3dsound_soundpoint_pan +1.00000000f));
				}
			}
		}
		if(o->_openb3dmods_b3dsound_soundpoint_depthbump !=-2.00000000f){
			o->_openb3dmods_b3dsound_soundpoint_depth =(openb3d_openb3d_EntityZ(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(o->_openb3dmods_b3dsound_soundpoint_relativesoundpoint ,&openb3d_openb3d_TEntity)),0)/openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_soundfalloffend );
			o->_openb3dmods_b3dsound_soundpoint_depth +=o->_openb3dmods_b3dsound_soundpoint_depthbump ;
			if(o->_openb3dmods_b3dsound_soundpoint_depth >1.00000000f){
				o->_openb3dmods_b3dsound_soundpoint_depth =1.00000000f;
			}else{
				if(o->_openb3dmods_b3dsound_soundpoint_depth <-1.00000000f){
					o->_openb3dmods_b3dsound_soundpoint_depth =-1.00000000f;
				}
			}
		}
		if(o->_openb3dmods_b3dsound_soundpoint_ratebump !=-2.00000000f){
			if(openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_dopplerscale >0.00000000f){
				o->_openb3dmods_b3dsound_soundpoint_rate =((343.7f+((bbt_LastDistance-o->_openb3dmods_b3dsound_soundpoint_distance )*openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_dopplerscale ))/343.7f);
			}else{
				o->_openb3dmods_b3dsound_soundpoint_rate =1.00000000f;
			}
			o->_openb3dmods_b3dsound_soundpoint_rate +=o->_openb3dmods_b3dsound_soundpoint_ratebump ;
		}
	}else{
		((struct openb3dmods_b3dsound_SoundPoint_obj*)o)->clas->m_Stop(o);
	}
}
void _openb3dmods_b3dsound_SoundPoint_SetAndPlay(struct openb3dmods_b3dsound_SoundPoint_obj* o){
	brl_audio_PauseChannel(o->_openb3dmods_b3dsound_soundpoint_soundchannel );
	brl_audio_SetChannelVolume(o->_openb3dmods_b3dsound_soundpoint_soundchannel ,o->_openb3dmods_b3dsound_soundpoint_volume );
	if(o->_openb3dmods_b3dsound_soundpoint_volume >0.00000000f){
		brl_audio_SetChannelPan(o->_openb3dmods_b3dsound_soundpoint_soundchannel ,o->_openb3dmods_b3dsound_soundpoint_pan );
		brl_audio_SetChannelRate(o->_openb3dmods_b3dsound_soundpoint_soundchannel ,o->_openb3dmods_b3dsound_soundpoint_rate );
		brl_audio_SetChannelDepth(o->_openb3dmods_b3dsound_soundpoint_soundchannel ,o->_openb3dmods_b3dsound_soundpoint_depth );
	}
	if(!(o->_openb3dmods_b3dsound_soundpoint_paused !=0)){
		brl_audio_ResumeChannel(o->_openb3dmods_b3dsound_soundpoint_soundchannel );
	}
}
void _openb3dmods_b3dsound_SoundPoint_Update(struct openb3dmods_b3dsound_SoundPoint_obj* o){
	if(o->_openb3dmods_b3dsound_soundpoint_soundchannel != &bbNullObject){
		((struct openb3dmods_b3dsound_SoundPoint_obj*)o)->clas->m_UpdatePosition(o);
		((struct openb3dmods_b3dsound_SoundPoint_obj*)o)->clas->m_SetAndPlay(o);
		if(!(brl_audio_ChannelPlaying(o->_openb3dmods_b3dsound_soundpoint_soundchannel )!=0) && !(o->_openb3dmods_b3dsound_soundpoint_paused !=0)){
			((struct openb3dmods_b3dsound_SoundPoint_obj*)o)->clas->m_Stop(o);
		}
	}else{
		((struct openb3dmods_b3dsound_SoundPoint_obj*)o)->clas->m_Stop(o);
	}
}
void _openb3dmods_b3dsound_SoundPoint_Stop(struct openb3dmods_b3dsound_SoundPoint_obj* o){
	if(o->_openb3dmods_b3dsound_soundpoint_soundchannel != &bbNullObject){
		brl_audio_StopChannel(o->_openb3dmods_b3dsound_soundpoint_soundchannel );
	}
	brl_linkedlist_ListRemove(openb3dmods_b3dsound_SoundPointsList,o);
}
struct BBDebugScope_23 openb3dmods_b3dsound_SoundPoint_scope ={
	BBDEBUGSCOPE_USERTYPE,
	"SoundPoint",
	{
		{
			BBDEBUGDECL_FIELD,
			"RelativeSoundPoint",
			":TPivot",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_relativesoundpoint)
		},
		{
			BBDEBUGDECL_FIELD,
			"ListenAngularDifference",
			":TPivot",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_listenangulardifference)
		},
		{
			BBDEBUGDECL_FIELD,
			"Distance",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_distance)
		},
		{
			BBDEBUGDECL_FIELD,
			"Angle",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_angle)
		},
		{
			BBDEBUGDECL_FIELD,
			"SoundChannel",
			":TChannel",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_soundchannel)
		},
		{
			BBDEBUGDECL_FIELD,
			"EmiterObject",
			":TEntity",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_emiterobject)
		},
		{
			BBDEBUGDECL_FIELD,
			"Loudness",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_loudness)
		},
		{
			BBDEBUGDECL_FIELD,
			"MasterVolume",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_mastervolume)
		},
		{
			BBDEBUGDECL_FIELD,
			"Pan",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_pan)
		},
		{
			BBDEBUGDECL_FIELD,
			"PanBump",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_panbump)
		},
		{
			BBDEBUGDECL_FIELD,
			"Depth",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_depth)
		},
		{
			BBDEBUGDECL_FIELD,
			"DepthBump",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_depthbump)
		},
		{
			BBDEBUGDECL_FIELD,
			"Rate",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_rate)
		},
		{
			BBDEBUGDECL_FIELD,
			"RateBump",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_ratebump)
		},
		{
			BBDEBUGDECL_FIELD,
			"Volume",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_volume)
		},
		{
			BBDEBUGDECL_FIELD,
			"VolumeBump",
			"f",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_volumebump)
		},
		{
			BBDEBUGDECL_FIELD,
			"Paused",
			"b",
			.field_offset=offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_paused)
		},
		{
			BBDEBUGDECL_TYPEMETHOD,
			"New",
			"()",
			&_openb3dmods_b3dsound_SoundPoint_New
		},
		{
			BBDEBUGDECL_TYPEFUNCTION,
			"Create",
			"(:TSound,:TEntity,f,f,b):SoundPoint",
			&openb3dmods_b3dsound_SoundPoint_Create_TSoundPoint_TTSoundTTEntityffb
		},
		{
			BBDEBUGDECL_TYPEMETHOD,
			"UpdatePosition",
			"()",
			&_openb3dmods_b3dsound_SoundPoint_UpdatePosition
		},
		{
			BBDEBUGDECL_TYPEMETHOD,
			"SetAndPlay",
			"()",
			&_openb3dmods_b3dsound_SoundPoint_SetAndPlay
		},
		{
			BBDEBUGDECL_TYPEMETHOD,
			"Update",
			"()",
			&_openb3dmods_b3dsound_SoundPoint_Update
		},
		{
			BBDEBUGDECL_TYPEMETHOD,
			"Stop",
			"()",
			&_openb3dmods_b3dsound_SoundPoint_Stop
		},
		BBDEBUGDECL_END
	}
};
struct BBClass_openb3dmods_b3dsound_SoundPoint openb3dmods_b3dsound_SoundPoint={
	&bbObjectClass,
	bbObjectFree,
	&openb3dmods_b3dsound_SoundPoint_scope,
	sizeof(struct openb3dmods_b3dsound_SoundPoint_obj),
	_openb3dmods_b3dsound_SoundPoint_New,
	_openb3dmods_b3dsound_SoundPoint_Delete,
	bbObjectToString,
	bbObjectCompare,
	bbObjectSendMessage,
	0,
	0,
	offsetof(struct openb3dmods_b3dsound_SoundPoint_obj,_openb3dmods_b3dsound_soundpoint_paused) - sizeof(void*) + sizeof(BBBYTE)
	,openb3dmods_b3dsound_SoundPoint_Create_TSoundPoint_TTSoundTTEntityffb
	,_openb3dmods_b3dsound_SoundPoint_UpdatePosition
	,_openb3dmods_b3dsound_SoundPoint_SetAndPlay
	,_openb3dmods_b3dsound_SoundPoint_Update
	,_openb3dmods_b3dsound_SoundPoint_Stop
};

void openb3dmods_b3dsound_Init3DSound(struct openb3d_openb3d_TEntity_obj* bbt_ListeningEntity,BBFLOAT bbt_MaxRange,BBFLOAT bbt_ExaggerateDopplerScale){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct openb3d_openb3d_TEntity_obj* volatile bbt_OldListeningEntity=&bbNullObject;
	if(openb3dmods_b3dsound_HearingPoint!= &bbNullObject){
		bbt_OldListeningEntity=openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_listenpoint ;
	}else{
		openb3dmods_b3dsound_HearingPoint=bbObjectNew(&openb3dmods_b3dsound_ListeningPoint);
	}
	openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_listenpoint =bbt_ListeningEntity;
	openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_soundfalloffend =bbt_MaxRange;
	openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_dopplerscale =bbt_ExaggerateDopplerScale;
	if((openb3dmods_b3dsound_SoundPointsList!= &bbNullObject) && (bbt_OldListeningEntity!=openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_listenpoint )){
		struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
		while((bbt_)->clas->m_HasNext(bbt_)!=0){
			bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
			if(bbt_tempSoundPoint==&bbNullObject){
				continue;
			}
			openb3d_openb3d_EntityParent(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(bbt_tempSoundPoint->_openb3dmods_b3dsound_soundpoint_relativesoundpoint ,&openb3d_openb3d_TEntity)),openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_listenpoint ,1);
			openb3d_openb3d_EntityParent(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(bbt_tempSoundPoint->_openb3dmods_b3dsound_soundpoint_listenangulardifference ,&openb3d_openb3d_TEntity)),openb3dmods_b3dsound_HearingPoint->_openb3dmods_b3dsound_listeningpoint_listenpoint ,1);
			openb3d_openb3d_PositionEntity(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(bbt_tempSoundPoint->_openb3dmods_b3dsound_soundpoint_listenangulardifference ,&openb3d_openb3d_TEntity)),0.00000000f,0.00000000f,0.00000000f,0);
			bbt_tempSoundPoint->_openb3dmods_b3dsound_soundpoint_distance =0.00000000f;
		}
	}else{
		openb3dmods_b3dsound_SoundPointsList=brl_linkedlist_CreateList();
	}
}
void openb3dmods_b3dsound_Update3DSounds(){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
	while((bbt_)->clas->m_HasNext(bbt_)!=0){
		bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
		if(bbt_tempSoundPoint==&bbNullObject){
			continue;
		}
		(bbt_tempSoundPoint)->clas->m_Update(bbt_tempSoundPoint);
	}
}
void openb3dmods_b3dsound_DopplerFrameSkip(){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
	while((bbt_)->clas->m_HasNext(bbt_)!=0){
		bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
		if(bbt_tempSoundPoint==&bbNullObject){
			continue;
		}
		bbt_tempSoundPoint->_openb3dmods_b3dsound_soundpoint_distance =0.00000000f;
	}
}
struct openb3dmods_b3dsound_SoundPoint_obj* openb3dmods_b3dsound_Start3DSound(struct brl_audio_TSound_obj* bbt_TheSound,struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity,BBFLOAT bbt_Loudness,BBFLOAT bbt_Volume){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	bbt_tempSoundPoint=openb3dmods_b3dsound_SoundPoint_Create_TSoundPoint_TTSoundTTEntityffb(bbt_TheSound,bbt_NoisyEntity,bbt_Loudness,bbt_Volume,0);
	return bbt_tempSoundPoint;
}
struct openb3dmods_b3dsound_SoundPoint_obj* openb3dmods_b3dsound_Que3DSound(struct brl_audio_TSound_obj* bbt_TheSound,struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity,BBFLOAT bbt_Loudness,BBFLOAT bbt_Volume){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	bbt_tempSoundPoint=openb3dmods_b3dsound_SoundPoint_Create_TSoundPoint_TTSoundTTEntityffb(bbt_TheSound,bbt_NoisyEntity,bbt_Loudness,bbt_Volume,1);
	return bbt_tempSoundPoint;
}
struct brl_linkedlist_TList_obj* openb3dmods_b3dsound_List3DSounds(struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity){
	struct brl_linkedlist_TList_obj* volatile bbt_returnSoundPointList=brl_linkedlist_CreateList();
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
	while((bbt_)->clas->m_HasNext(bbt_)!=0){
		bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
		if(bbt_tempSoundPoint==&bbNullObject){
			continue;
		}
		if(bbt_tempSoundPoint->_openb3dmods_b3dsound_soundpoint_emiterobject ==bbt_NoisyEntity){
			brl_linkedlist_ListAddLast(bbt_returnSoundPointList,bbt_tempSoundPoint);
		}
	}
	return bbt_returnSoundPointList;
}
void openb3dmods_b3dsound_Stop3DSound(struct openb3dmods_b3dsound_SoundPoint_obj* bbt_TheSoundPoint){
	(bbt_TheSoundPoint)->clas->m_Stop(bbt_TheSoundPoint);
}
void openb3dmods_b3dsound_Pause3DSound(struct openb3dmods_b3dsound_SoundPoint_obj* bbt_TheSoundPoint){
	bbt_TheSoundPoint->_openb3dmods_b3dsound_soundpoint_paused =1;
}
void openb3dmods_b3dsound_Resume3DSound(struct openb3dmods_b3dsound_SoundPoint_obj* bbt_TheSoundPoint){
	bbt_TheSoundPoint->_openb3dmods_b3dsound_soundpoint_paused =0;
}
void openb3dmods_b3dsound_EntityStop3DSound(struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
	while((bbt_)->clas->m_HasNext(bbt_)!=0){
		bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
		if(bbt_tempSoundPoint==&bbNullObject){
			continue;
		}
		if(bbt_tempSoundPoint->_openb3dmods_b3dsound_soundpoint_emiterobject ==bbt_NoisyEntity){
			(bbt_tempSoundPoint)->clas->m_Stop(bbt_tempSoundPoint);
		}
	}
}
void openb3dmods_b3dsound_EntityPause3DSound(struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
	while((bbt_)->clas->m_HasNext(bbt_)!=0){
		bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
		if(bbt_tempSoundPoint==&bbNullObject){
			continue;
		}
		if(bbt_tempSoundPoint->_openb3dmods_b3dsound_soundpoint_emiterobject ==bbt_NoisyEntity){
			bbt_tempSoundPoint->_openb3dmods_b3dsound_soundpoint_paused =1;
		}
	}
}
void openb3dmods_b3dsound_EntityResume3DSound(struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
	while((bbt_)->clas->m_HasNext(bbt_)!=0){
		bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
		if(bbt_tempSoundPoint==&bbNullObject){
			continue;
		}
		if(bbt_tempSoundPoint->_openb3dmods_b3dsound_soundpoint_emiterobject ==bbt_NoisyEntity){
			bbt_tempSoundPoint->_openb3dmods_b3dsound_soundpoint_paused =0;
		}
	}
}
static int __bb_openb3dmods_b3dsound_b3dsound_inited = 0;
int __bb_openb3dmods_b3dsound_b3dsound(){
	if (!__bb_openb3dmods_b3dsound_b3dsound_inited) {
		__bb_openb3dmods_b3dsound_b3dsound_inited = 1;
		__bb_brl_blitz_blitz();
		__bb_openb3d_openb3d_openb3d();
		__bb_brl_audio_audio();
		bbObjectRegisterType(&openb3dmods_b3dsound_ListeningPoint);
		bbObjectRegisterType(&openb3dmods_b3dsound_SoundPoint);
		openb3dmods_b3dsound_HearingPoint=bbObjectNew(&openb3dmods_b3dsound_ListeningPoint);
		return 0;
	}
	return 0;
}