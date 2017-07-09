#include <openb3dmods.mod/b3dsound.mod/.bmx/b3dsound.bmx.debug.linux.x64.h>
static BBString _s0={
	&bbStringClass,
	11,
	{45,50,46,48,48,48,48,48,48,48,48}
};
static BBString _s1={
	&bbStringClass,
	10,
	{48,46,48,48,48,48,48,48,48,48}
};
struct BBDebugScope_1{int kind; const char *name; BBDebugDecl decls[2]; };
struct BBDebugScope_2{int kind; const char *name; BBDebugDecl decls[3]; };
struct BBDebugScope_23{int kind; const char *name; BBDebugDecl decls[24]; };
struct BBDebugScope_3{int kind; const char *name; BBDebugDecl decls[4]; };
struct BBDebugScope_4{int kind; const char *name; BBDebugDecl decls[5]; };
struct BBDebugScope_5{int kind; const char *name; BBDebugDecl decls[6]; };
struct BBDebugScope_6{int kind; const char *name; BBDebugDecl decls[7]; };
struct openb3dmods_b3dsound_ListeningPoint_obj* openb3dmods_b3dsound_HearingPoint;
struct brl_linkedlist_TList_obj* openb3dmods_b3dsound_SoundPointsList=&bbNullObject;
void _openb3dmods_b3dsound_ListeningPoint_New(struct openb3dmods_b3dsound_ListeningPoint_obj* o) {
	bbObjectCtor(o);
	o->clas = (BBClass*)&openb3dmods_b3dsound_ListeningPoint;
	((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_listeningpoint_listenpoint = &bbNullObject;
	((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_listeningpoint_soundfalloffend = .0f;
	((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_listeningpoint_dopplerscale = .0f;
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
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_relativesoundpoint = &bbNullObject;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_listenangulardifference = &bbNullObject;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_distance = .0f;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_angle = .0f;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_soundchannel = &bbNullObject;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_emiterobject = &bbNullObject;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_loudness = .0f;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_mastervolume = .0f;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_pan = .0f;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_panbump = .0f;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_depth = .0f;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_depthbump = .0f;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_rate = 1.00000000f;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_ratebump = .0f;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_volume = .0f;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_volumebump = .0f;
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_paused = 0;
}
void _openb3dmods_b3dsound_SoundPoint_Delete(struct openb3dmods_b3dsound_SoundPoint_obj* o) {
	struct BBDebugScope_1 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"Delete",
		{
			{
				BBDEBUGDECL_LOCAL,
				"Self",
				":SoundPoint",
				.var_address=&o
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 276, 0};
	bbOnDebugEnterStm(&__stmt_0);
	brl_audio_StopChannel(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_soundchannel );
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 277, 0};
	bbOnDebugEnterStm(&__stmt_1);
	openb3d_openb3d_FreeEntity((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_relativesoundpoint ,&openb3d_openb3d_TEntity));
	struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 278, 0};
	bbOnDebugEnterStm(&__stmt_2);
	openb3d_openb3d_FreeEntity((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_listenangulardifference ,&openb3d_openb3d_TEntity));
	bbOnDebugLeaveScope();
	bbObjectDtor(o);
}
struct openb3dmods_b3dsound_SoundPoint_obj* openb3dmods_b3dsound_SoundPoint_Create_TSoundPoint_TTSoundTTEntityffb(struct brl_audio_TSound_obj* bbt_TheSound,struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity,BBFLOAT bbt_EntityLoudness,BBFLOAT bbt_Volume,BBBYTE bbt_Qued){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_theTemp=&bbNullObject;
	struct BBDebugScope_6 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"Create",
		{
			{
				BBDEBUGDECL_LOCAL,
				"TheSound",
				":TSound",
				.var_address=&bbt_TheSound
			},
			{
				BBDEBUGDECL_LOCAL,
				"NoisyEntity",
				":TEntity",
				.var_address=&bbt_NoisyEntity
			},
			{
				BBDEBUGDECL_LOCAL,
				"EntityLoudness",
				"f",
				.var_address=&bbt_EntityLoudness
			},
			{
				BBDEBUGDECL_LOCAL,
				"Volume",
				"f",
				.var_address=&bbt_Volume
			},
			{
				BBDEBUGDECL_LOCAL,
				"Qued",
				"b",
				.var_address=&bbt_Qued
			},
			{
				BBDEBUGDECL_LOCAL,
				"theTemp",
				":SoundPoint",
				.var_address=&bbt_theTemp
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 149, 0};
	bbOnDebugEnterStm(&__stmt_0);
	bbt_theTemp=bbObjectNew(&openb3dmods_b3dsound_SoundPoint);
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 151, 0};
	bbOnDebugEnterStm(&__stmt_1);
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_theTemp))->_openb3dmods_b3dsound_soundpoint_relativesoundpoint =openb3d_openb3d_CreatePivot(((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_listenpoint );
	struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 152, 0};
	bbOnDebugEnterStm(&__stmt_2);
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_theTemp))->_openb3dmods_b3dsound_soundpoint_listenangulardifference =openb3d_openb3d_CreatePivot(((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_listenpoint );
	struct BBDebugStm __stmt_3 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 154, 0};
	bbOnDebugEnterStm(&__stmt_3);
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_theTemp))->_openb3dmods_b3dsound_soundpoint_emiterobject =bbt_NoisyEntity;
	struct BBDebugStm __stmt_4 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 155, 0};
	bbOnDebugEnterStm(&__stmt_4);
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_theTemp))->_openb3dmods_b3dsound_soundpoint_soundchannel =brl_audio_AllocChannel();
	struct BBDebugStm __stmt_5 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 156, 0};
	bbOnDebugEnterStm(&__stmt_5);
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_theTemp))->_openb3dmods_b3dsound_soundpoint_mastervolume =bbt_Volume;
	struct BBDebugStm __stmt_6 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 157, 0};
	bbOnDebugEnterStm(&__stmt_6);
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_theTemp))->_openb3dmods_b3dsound_soundpoint_loudness =bbt_EntityLoudness;
	struct BBDebugStm __stmt_7 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 158, 0};
	bbOnDebugEnterStm(&__stmt_7);
	brl_audio_CueSound(bbt_TheSound,((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_theTemp))->_openb3dmods_b3dsound_soundpoint_soundchannel );
	struct BBDebugStm __stmt_8 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 160, 0};
	bbOnDebugEnterStm(&__stmt_8);
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_theTemp))->_openb3dmods_b3dsound_soundpoint_paused =bbt_Qued;
	struct BBDebugStm __stmt_9 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 162, 0};
	bbOnDebugEnterStm(&__stmt_9);
	(bbt_theTemp)->clas->m_Update(bbt_theTemp);
	struct BBDebugStm __stmt_10 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 164, 0};
	bbOnDebugEnterStm(&__stmt_10);
	brl_linkedlist_ListAddLast(openb3dmods_b3dsound_SoundPointsList,bbt_theTemp);
	struct BBDebugStm __stmt_11 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 166, 0};
	bbOnDebugEnterStm(&__stmt_11);
	bbOnDebugLeaveScope();
	return bbt_theTemp;
}
void _openb3dmods_b3dsound_SoundPoint_UpdatePosition(struct openb3dmods_b3dsound_SoundPoint_obj* o){
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o));
	BBFLOAT bbt_LastDistance=0;
	struct BBDebugScope_2 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"UpdatePosition",
		{
			{
				BBDEBUGDECL_LOCAL,
				"Self",
				":SoundPoint",
				.var_address=&o
			},
			{
				BBDEBUGDECL_LOCAL,
				"LastDistance",
				"f",
				.var_address=&bbt_LastDistance
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 171, 0};
	bbOnDebugEnterStm(&__stmt_0);
	bbt_LastDistance=.0f;
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 173, 0};
	bbOnDebugEnterStm(&__stmt_1);
	if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_emiterobject !=&bbNullObject){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 175, 0};
		bbOnDebugEnterStm(&__stmt_0);
		openb3d_openb3d_PositionEntity(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_relativesoundpoint ,&openb3d_openb3d_TEntity)),openb3d_openb3d_EntityX(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_emiterobject ,1),openb3d_openb3d_EntityY(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_emiterobject ,1),openb3d_openb3d_EntityZ(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_emiterobject ,1),1);
		struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 177, 0};
		bbOnDebugEnterStm(&__stmt_1);
		openb3d_openb3d_PointEntity(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_listenangulardifference ,&openb3d_openb3d_TEntity)),((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_relativesoundpoint ,&openb3d_openb3d_TEntity)),0.00000000f);
		struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 178, 0};
		bbOnDebugEnterStm(&__stmt_2);
		((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_angle =openb3d_openb3d_EntityYaw(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_listenangulardifference ,&openb3d_openb3d_TEntity)),0);
		struct BBDebugStm __stmt_3 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 180, 0};
		bbOnDebugEnterStm(&__stmt_3);
		bbt_LastDistance=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_distance ;
		struct BBDebugStm __stmt_4 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 181, 0};
		bbOnDebugEnterStm(&__stmt_4);
		((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_distance =openb3d_openb3d_EntityDistance(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_listenangulardifference ,&openb3d_openb3d_TEntity)),((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_relativesoundpoint ,&openb3d_openb3d_TEntity)));
		struct BBDebugStm __stmt_5 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 185, 0};
		bbOnDebugEnterStm(&__stmt_5);
		if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_volumebump !=-2.00000000f){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 186, 0};
			bbOnDebugEnterStm(&__stmt_0);
			((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_volume =(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_mastervolume -(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_distance /(((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_soundfalloffend *((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_loudness )));
			struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 187, 0};
			bbOnDebugEnterStm(&__stmt_1);
			((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_volume +=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_volumebump ;
			struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 188, 0};
			bbOnDebugEnterStm(&__stmt_2);
			if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_volume >1.00000000f){
				struct BBDebugScope __scope = {
					BBDEBUGSCOPE_LOCALBLOCK,
					0,
					{
						BBDEBUGDECL_END 
					}
				};
				bbOnDebugEnterScope(&__scope);
				struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 189, 0};
				bbOnDebugEnterStm(&__stmt_0);
				((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_volume =1.00000000f;
				bbOnDebugLeaveScope();
			}else{
				struct BBDebugScope __scope = {
					BBDEBUGSCOPE_LOCALBLOCK,
					0,
					{
						BBDEBUGDECL_END 
					}
				};
				bbOnDebugEnterScope(&__scope);
				struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 190, 0};
				bbOnDebugEnterStm(&__stmt_0);
				if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_volume <0.00000000f){
					struct BBDebugScope __scope = {
						BBDEBUGSCOPE_LOCALBLOCK,
						0,
						{
							BBDEBUGDECL_END 
						}
					};
					bbOnDebugEnterScope(&__scope);
					struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 191, 0};
					bbOnDebugEnterStm(&__stmt_0);
					((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_volume =0.00000000f;
					bbOnDebugLeaveScope();
				}
				bbOnDebugLeaveScope();
			}
			bbOnDebugLeaveScope();
		}
		struct BBDebugStm __stmt_6 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 196, 0};
		bbOnDebugEnterStm(&__stmt_6);
		if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_panbump !=-2.00000000f){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 197, 0};
			bbOnDebugEnterStm(&__stmt_0);
			((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_pan =(-((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_angle /90.0000000f);
			struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 198, 0};
			bbOnDebugEnterStm(&__stmt_1);
			((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_pan +=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_panbump ;
			struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 199, 0};
			bbOnDebugEnterStm(&__stmt_2);
			if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_pan >1.00000000f){
				struct BBDebugScope __scope = {
					BBDEBUGSCOPE_LOCALBLOCK,
					0,
					{
						BBDEBUGDECL_END 
					}
				};
				bbOnDebugEnterScope(&__scope);
				struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 200, 0};
				bbOnDebugEnterStm(&__stmt_0);
				((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_pan =(1.00000000f-(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_pan -1.00000000f));
				bbOnDebugLeaveScope();
			}else{
				struct BBDebugScope __scope = {
					BBDEBUGSCOPE_LOCALBLOCK,
					0,
					{
						BBDEBUGDECL_END 
					}
				};
				bbOnDebugEnterScope(&__scope);
				struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 201, 0};
				bbOnDebugEnterStm(&__stmt_0);
				if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_pan <-1.00000000f){
					struct BBDebugScope __scope = {
						BBDEBUGSCOPE_LOCALBLOCK,
						0,
						{
							BBDEBUGDECL_END 
						}
					};
					bbOnDebugEnterScope(&__scope);
					struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 202, 0};
					bbOnDebugEnterStm(&__stmt_0);
					((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_pan =(-1.00000000f-(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_pan +1.00000000f));
					bbOnDebugLeaveScope();
				}
				bbOnDebugLeaveScope();
			}
			bbOnDebugLeaveScope();
		}
		struct BBDebugStm __stmt_7 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 208, 0};
		bbOnDebugEnterStm(&__stmt_7);
		if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_depthbump !=-2.00000000f){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 209, 0};
			bbOnDebugEnterStm(&__stmt_0);
			((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_depth =(openb3d_openb3d_EntityZ(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_relativesoundpoint ,&openb3d_openb3d_TEntity)),0)/((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_soundfalloffend );
			struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 210, 0};
			bbOnDebugEnterStm(&__stmt_1);
			((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_depth +=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_depthbump ;
			struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 211, 0};
			bbOnDebugEnterStm(&__stmt_2);
			if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_depth >1.00000000f){
				struct BBDebugScope __scope = {
					BBDEBUGSCOPE_LOCALBLOCK,
					0,
					{
						BBDEBUGDECL_END 
					}
				};
				bbOnDebugEnterScope(&__scope);
				struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 212, 0};
				bbOnDebugEnterStm(&__stmt_0);
				((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_depth =1.00000000f;
				bbOnDebugLeaveScope();
			}else{
				struct BBDebugScope __scope = {
					BBDEBUGSCOPE_LOCALBLOCK,
					0,
					{
						BBDEBUGDECL_END 
					}
				};
				bbOnDebugEnterScope(&__scope);
				struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 213, 0};
				bbOnDebugEnterStm(&__stmt_0);
				if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_depth <-1.00000000f){
					struct BBDebugScope __scope = {
						BBDEBUGSCOPE_LOCALBLOCK,
						0,
						{
							BBDEBUGDECL_END 
						}
					};
					bbOnDebugEnterScope(&__scope);
					struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 214, 0};
					bbOnDebugEnterStm(&__stmt_0);
					((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_depth =-1.00000000f;
					bbOnDebugLeaveScope();
				}
				bbOnDebugLeaveScope();
			}
			bbOnDebugLeaveScope();
		}
		struct BBDebugStm __stmt_8 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 219, 0};
		bbOnDebugEnterStm(&__stmt_8);
		if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_ratebump !=-2.00000000f){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 220, 0};
			bbOnDebugEnterStm(&__stmt_0);
			if(((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_dopplerscale >0.00000000f){
				struct BBDebugScope __scope = {
					BBDEBUGSCOPE_LOCALBLOCK,
					0,
					{
						BBDEBUGDECL_END 
					}
				};
				bbOnDebugEnterScope(&__scope);
				struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 221, 0};
				bbOnDebugEnterStm(&__stmt_0);
				((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_rate =((343.7f+((bbt_LastDistance-((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_distance )*((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_dopplerscale ))/343.7f);
				bbOnDebugLeaveScope();
			}else{
				struct BBDebugScope __scope = {
					BBDEBUGSCOPE_LOCALBLOCK,
					0,
					{
						BBDEBUGDECL_END 
					}
				};
				bbOnDebugEnterScope(&__scope);
				struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 223, 0};
				bbOnDebugEnterStm(&__stmt_0);
				((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_rate =1.00000000f;
				bbOnDebugLeaveScope();
			}
			struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 225, 0};
			bbOnDebugEnterStm(&__stmt_1);
			((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_rate +=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_ratebump ;
			bbOnDebugLeaveScope();
		}
		bbOnDebugLeaveScope();
	}else{
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 228, 0};
		bbOnDebugEnterStm(&__stmt_0);
		((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o));
		((struct openb3dmods_b3dsound_SoundPoint_obj*)o)->clas->m_Stop(o);
		bbOnDebugLeaveScope();
	}
	bbOnDebugLeaveScope();
}
void _openb3dmods_b3dsound_SoundPoint_SetAndPlay(struct openb3dmods_b3dsound_SoundPoint_obj* o){
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o));
	struct BBDebugScope_1 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"SetAndPlay",
		{
			{
				BBDEBUGDECL_LOCAL,
				"Self",
				":SoundPoint",
				.var_address=&o
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 234, 0};
	bbOnDebugEnterStm(&__stmt_0);
	brl_audio_PauseChannel(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_soundchannel );
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 235, 0};
	bbOnDebugEnterStm(&__stmt_1);
	brl_audio_SetChannelVolume(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_soundchannel ,((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_volume );
	struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 236, 0};
	bbOnDebugEnterStm(&__stmt_2);
	if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_volume >0.00000000f){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 237, 0};
		bbOnDebugEnterStm(&__stmt_0);
		brl_audio_SetChannelPan(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_soundchannel ,((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_pan );
		struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 238, 0};
		bbOnDebugEnterStm(&__stmt_1);
		brl_audio_SetChannelRate(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_soundchannel ,((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_rate );
		struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 239, 0};
		bbOnDebugEnterStm(&__stmt_2);
		brl_audio_SetChannelDepth(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_soundchannel ,((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_depth );
		bbOnDebugLeaveScope();
	}
	struct BBDebugStm __stmt_3 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 241, 0};
	bbOnDebugEnterStm(&__stmt_3);
	if(!(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_paused !=0)){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 242, 0};
		bbOnDebugEnterStm(&__stmt_0);
		brl_audio_ResumeChannel(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_soundchannel );
		bbOnDebugLeaveScope();
	}
	bbOnDebugLeaveScope();
}
void _openb3dmods_b3dsound_SoundPoint_Update(struct openb3dmods_b3dsound_SoundPoint_obj* o){
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o));
	struct BBDebugScope_1 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"Update",
		{
			{
				BBDEBUGDECL_LOCAL,
				"Self",
				":SoundPoint",
				.var_address=&o
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 251, 0};
	bbOnDebugEnterStm(&__stmt_0);
	if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_soundchannel != &bbNullObject){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 252, 0};
		bbOnDebugEnterStm(&__stmt_0);
		((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o));
		((struct openb3dmods_b3dsound_SoundPoint_obj*)o)->clas->m_UpdatePosition(o);
		struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 253, 0};
		bbOnDebugEnterStm(&__stmt_1);
		((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o));
		((struct openb3dmods_b3dsound_SoundPoint_obj*)o)->clas->m_SetAndPlay(o);
		struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 254, 0};
		bbOnDebugEnterStm(&__stmt_2);
		if(!(brl_audio_ChannelPlaying(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_soundchannel )!=0) && !(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_paused !=0)){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 255, 0};
			bbOnDebugEnterStm(&__stmt_0);
			((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o));
			((struct openb3dmods_b3dsound_SoundPoint_obj*)o)->clas->m_Stop(o);
			bbOnDebugLeaveScope();
		}
		bbOnDebugLeaveScope();
	}else{
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 259, 0};
		bbOnDebugEnterStm(&__stmt_0);
		((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o));
		((struct openb3dmods_b3dsound_SoundPoint_obj*)o)->clas->m_Stop(o);
		bbOnDebugLeaveScope();
	}
	bbOnDebugLeaveScope();
}
void _openb3dmods_b3dsound_SoundPoint_Stop(struct openb3dmods_b3dsound_SoundPoint_obj* o){
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o));
	struct BBDebugScope_1 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"Stop",
		{
			{
				BBDEBUGDECL_LOCAL,
				"Self",
				":SoundPoint",
				.var_address=&o
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 268, 0};
	bbOnDebugEnterStm(&__stmt_0);
	if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_soundchannel != &bbNullObject){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 269, 0};
		bbOnDebugEnterStm(&__stmt_0);
		brl_audio_StopChannel(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(o))->_openb3dmods_b3dsound_soundpoint_soundchannel );
		bbOnDebugLeaveScope();
	}
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 271, 0};
	bbOnDebugEnterStm(&__stmt_1);
	brl_linkedlist_ListRemove(openb3dmods_b3dsound_SoundPointsList,o);
	bbOnDebugLeaveScope();
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
	struct BBDebugScope_5 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"Init3DSound",
		{
			{
				BBDEBUGDECL_LOCAL,
				"ListeningEntity",
				":TEntity",
				.var_address=&bbt_ListeningEntity
			},
			{
				BBDEBUGDECL_LOCAL,
				"MaxRange",
				"f",
				.var_address=&bbt_MaxRange
			},
			{
				BBDEBUGDECL_LOCAL,
				"ExaggerateDopplerScale",
				"f",
				.var_address=&bbt_ExaggerateDopplerScale
			},
			{
				BBDEBUGDECL_LOCAL,
				"tempSoundPoint",
				":SoundPoint",
				.var_address=&bbt_tempSoundPoint
			},
			{
				BBDEBUGDECL_LOCAL,
				"OldListeningEntity",
				":TEntity",
				.var_address=&bbt_OldListeningEntity
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 314, 0};
	bbOnDebugEnterStm(&__stmt_0);
	bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 315, 0};
	bbOnDebugEnterStm(&__stmt_1);
	bbt_OldListeningEntity=&bbNullObject;
	struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 317, 0};
	bbOnDebugEnterStm(&__stmt_2);
	if(openb3dmods_b3dsound_HearingPoint!= &bbNullObject){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 318, 0};
		bbOnDebugEnterStm(&__stmt_0);
		bbt_OldListeningEntity=((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_listenpoint ;
		bbOnDebugLeaveScope();
	}else{
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 320, 0};
		bbOnDebugEnterStm(&__stmt_0);
		openb3dmods_b3dsound_HearingPoint=bbObjectNew(&openb3dmods_b3dsound_ListeningPoint);
		bbOnDebugLeaveScope();
	}
	struct BBDebugStm __stmt_3 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 322, 0};
	bbOnDebugEnterStm(&__stmt_3);
	((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_listenpoint =bbt_ListeningEntity;
	struct BBDebugStm __stmt_4 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 323, 0};
	bbOnDebugEnterStm(&__stmt_4);
	((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_soundfalloffend =bbt_MaxRange;
	struct BBDebugStm __stmt_5 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 324, 0};
	bbOnDebugEnterStm(&__stmt_5);
	((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_dopplerscale =bbt_ExaggerateDopplerScale;
	struct BBDebugStm __stmt_6 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 326, 0};
	bbOnDebugEnterStm(&__stmt_6);
	if((openb3dmods_b3dsound_SoundPointsList!= &bbNullObject) && (bbt_OldListeningEntity!=((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_listenpoint )){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 327, 0};
		bbOnDebugEnterStm(&__stmt_0);
		struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
		while((bbt_)->clas->m_HasNext(bbt_)!=0){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 327, 0};
			bbOnDebugEnterStm(&__stmt_0);
			bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
			struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 327, 0};
			bbOnDebugEnterStm(&__stmt_1);
			if(bbt_tempSoundPoint==&bbNullObject){
				struct BBDebugScope __scope = {
					BBDEBUGSCOPE_LOCALBLOCK,
					0,
					{
						BBDEBUGDECL_END 
					}
				};
				bbOnDebugEnterScope(&__scope);
				struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 327, 0};
				bbOnDebugEnterStm(&__stmt_0);
				bbOnDebugLeaveScope();
				bbOnDebugLeaveScope();
				continue;
			}
			struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 328, 0};
			bbOnDebugEnterStm(&__stmt_2);
			openb3d_openb3d_EntityParent(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_tempSoundPoint))->_openb3dmods_b3dsound_soundpoint_relativesoundpoint ,&openb3d_openb3d_TEntity)),((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_listenpoint ,1);
			struct BBDebugStm __stmt_3 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 329, 0};
			bbOnDebugEnterStm(&__stmt_3);
			openb3d_openb3d_EntityParent(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_tempSoundPoint))->_openb3dmods_b3dsound_soundpoint_listenangulardifference ,&openb3d_openb3d_TEntity)),((struct openb3dmods_b3dsound_ListeningPoint_obj*)bbNullObjectTest(openb3dmods_b3dsound_HearingPoint))->_openb3dmods_b3dsound_listeningpoint_listenpoint ,1);
			struct BBDebugStm __stmt_4 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 330, 0};
			bbOnDebugEnterStm(&__stmt_4);
			openb3d_openb3d_PositionEntity(((struct openb3d_openb3d_TEntity_obj*)bbObjectDowncast(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_tempSoundPoint))->_openb3dmods_b3dsound_soundpoint_listenangulardifference ,&openb3d_openb3d_TEntity)),0.00000000f,0.00000000f,0.00000000f,0);
			struct BBDebugStm __stmt_5 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 331, 0};
			bbOnDebugEnterStm(&__stmt_5);
			((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_tempSoundPoint))->_openb3dmods_b3dsound_soundpoint_distance =0.00000000f;
			bbOnDebugLeaveScope();
		}
		bbOnDebugLeaveScope();
	}else{
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 334, 0};
		bbOnDebugEnterStm(&__stmt_0);
		openb3dmods_b3dsound_SoundPointsList=brl_linkedlist_CreateList();
		bbOnDebugLeaveScope();
	}
	bbOnDebugLeaveScope();
}
void openb3dmods_b3dsound_Update3DSounds(){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugScope_1 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"Update3DSounds",
		{
			{
				BBDEBUGDECL_LOCAL,
				"tempSoundPoint",
				":SoundPoint",
				.var_address=&bbt_tempSoundPoint
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 344, 0};
	bbOnDebugEnterStm(&__stmt_0);
	bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 346, 0};
	bbOnDebugEnterStm(&__stmt_1);
	struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
	while((bbt_)->clas->m_HasNext(bbt_)!=0){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 346, 0};
		bbOnDebugEnterStm(&__stmt_0);
		bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
		struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 346, 0};
		bbOnDebugEnterStm(&__stmt_1);
		if(bbt_tempSoundPoint==&bbNullObject){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 346, 0};
			bbOnDebugEnterStm(&__stmt_0);
			bbOnDebugLeaveScope();
			bbOnDebugLeaveScope();
			continue;
		}
		struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 347, 0};
		bbOnDebugEnterStm(&__stmt_2);
		(bbt_tempSoundPoint)->clas->m_Update(bbt_tempSoundPoint);
		bbOnDebugLeaveScope();
	}
	bbOnDebugLeaveScope();
}
void openb3dmods_b3dsound_DopplerFrameSkip(){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugScope_1 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"DopplerFrameSkip",
		{
			{
				BBDEBUGDECL_LOCAL,
				"tempSoundPoint",
				":SoundPoint",
				.var_address=&bbt_tempSoundPoint
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 361, 0};
	bbOnDebugEnterStm(&__stmt_0);
	bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 363, 0};
	bbOnDebugEnterStm(&__stmt_1);
	struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
	while((bbt_)->clas->m_HasNext(bbt_)!=0){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 363, 0};
		bbOnDebugEnterStm(&__stmt_0);
		bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
		struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 363, 0};
		bbOnDebugEnterStm(&__stmt_1);
		if(bbt_tempSoundPoint==&bbNullObject){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 363, 0};
			bbOnDebugEnterStm(&__stmt_0);
			bbOnDebugLeaveScope();
			bbOnDebugLeaveScope();
			continue;
		}
		struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 364, 0};
		bbOnDebugEnterStm(&__stmt_2);
		((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_tempSoundPoint))->_openb3dmods_b3dsound_soundpoint_distance =0.00000000f;
		bbOnDebugLeaveScope();
	}
	bbOnDebugLeaveScope();
}
struct openb3dmods_b3dsound_SoundPoint_obj* openb3dmods_b3dsound_Start3DSound(struct brl_audio_TSound_obj* bbt_TheSound,struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity,BBFLOAT bbt_Loudness,BBFLOAT bbt_Volume){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugScope_5 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"Start3DSound",
		{
			{
				BBDEBUGDECL_LOCAL,
				"TheSound",
				":TSound",
				.var_address=&bbt_TheSound
			},
			{
				BBDEBUGDECL_LOCAL,
				"NoisyEntity",
				":TEntity",
				.var_address=&bbt_NoisyEntity
			},
			{
				BBDEBUGDECL_LOCAL,
				"Loudness",
				"f",
				.var_address=&bbt_Loudness
			},
			{
				BBDEBUGDECL_LOCAL,
				"Volume",
				"f",
				.var_address=&bbt_Volume
			},
			{
				BBDEBUGDECL_LOCAL,
				"tempSoundPoint",
				":SoundPoint",
				.var_address=&bbt_tempSoundPoint
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 383, 0};
	bbOnDebugEnterStm(&__stmt_0);
	bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 385, 0};
	bbOnDebugEnterStm(&__stmt_1);
	bbt_tempSoundPoint=openb3dmods_b3dsound_SoundPoint_Create_TSoundPoint_TTSoundTTEntityffb(bbt_TheSound,bbt_NoisyEntity,bbt_Loudness,bbt_Volume,0);
	struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 387, 0};
	bbOnDebugEnterStm(&__stmt_2);
	bbOnDebugLeaveScope();
	return bbt_tempSoundPoint;
}
struct openb3dmods_b3dsound_SoundPoint_obj* openb3dmods_b3dsound_Que3DSound(struct brl_audio_TSound_obj* bbt_TheSound,struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity,BBFLOAT bbt_Loudness,BBFLOAT bbt_Volume){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugScope_5 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"Que3DSound",
		{
			{
				BBDEBUGDECL_LOCAL,
				"TheSound",
				":TSound",
				.var_address=&bbt_TheSound
			},
			{
				BBDEBUGDECL_LOCAL,
				"NoisyEntity",
				":TEntity",
				.var_address=&bbt_NoisyEntity
			},
			{
				BBDEBUGDECL_LOCAL,
				"Loudness",
				"f",
				.var_address=&bbt_Loudness
			},
			{
				BBDEBUGDECL_LOCAL,
				"Volume",
				"f",
				.var_address=&bbt_Volume
			},
			{
				BBDEBUGDECL_LOCAL,
				"tempSoundPoint",
				":SoundPoint",
				.var_address=&bbt_tempSoundPoint
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 405, 0};
	bbOnDebugEnterStm(&__stmt_0);
	bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 407, 0};
	bbOnDebugEnterStm(&__stmt_1);
	bbt_tempSoundPoint=openb3dmods_b3dsound_SoundPoint_Create_TSoundPoint_TTSoundTTEntityffb(bbt_TheSound,bbt_NoisyEntity,bbt_Loudness,bbt_Volume,1);
	struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 409, 0};
	bbOnDebugEnterStm(&__stmt_2);
	bbOnDebugLeaveScope();
	return bbt_tempSoundPoint;
}
struct brl_linkedlist_TList_obj* openb3dmods_b3dsound_List3DSounds(struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity){
	struct brl_linkedlist_TList_obj* volatile bbt_returnSoundPointList=&bbNullObject;
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugScope_3 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"List3DSounds",
		{
			{
				BBDEBUGDECL_LOCAL,
				"NoisyEntity",
				":TEntity",
				.var_address=&bbt_NoisyEntity
			},
			{
				BBDEBUGDECL_LOCAL,
				"returnSoundPointList",
				":TList",
				.var_address=&bbt_returnSoundPointList
			},
			{
				BBDEBUGDECL_LOCAL,
				"tempSoundPoint",
				":SoundPoint",
				.var_address=&bbt_tempSoundPoint
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 419, 0};
	bbOnDebugEnterStm(&__stmt_0);
	bbt_returnSoundPointList=brl_linkedlist_CreateList();
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 420, 0};
	bbOnDebugEnterStm(&__stmt_1);
	bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 422, 0};
	bbOnDebugEnterStm(&__stmt_2);
	struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
	while((bbt_)->clas->m_HasNext(bbt_)!=0){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 422, 0};
		bbOnDebugEnterStm(&__stmt_0);
		bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
		struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 422, 0};
		bbOnDebugEnterStm(&__stmt_1);
		if(bbt_tempSoundPoint==&bbNullObject){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 422, 0};
			bbOnDebugEnterStm(&__stmt_0);
			bbOnDebugLeaveScope();
			bbOnDebugLeaveScope();
			continue;
		}
		struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 423, 0};
		bbOnDebugEnterStm(&__stmt_2);
		if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_tempSoundPoint))->_openb3dmods_b3dsound_soundpoint_emiterobject ==bbt_NoisyEntity){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 424, 0};
			bbOnDebugEnterStm(&__stmt_0);
			brl_linkedlist_ListAddLast(bbt_returnSoundPointList,bbt_tempSoundPoint);
			bbOnDebugLeaveScope();
		}
		bbOnDebugLeaveScope();
	}
	struct BBDebugStm __stmt_3 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 428, 0};
	bbOnDebugEnterStm(&__stmt_3);
	bbOnDebugLeaveScope();
	return bbt_returnSoundPointList;
}
void openb3dmods_b3dsound_Stop3DSound(struct openb3dmods_b3dsound_SoundPoint_obj* bbt_TheSoundPoint){
	struct BBDebugScope_1 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"Stop3DSound",
		{
			{
				BBDEBUGDECL_LOCAL,
				"TheSoundPoint",
				":SoundPoint",
				.var_address=&bbt_TheSoundPoint
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 437, 0};
	bbOnDebugEnterStm(&__stmt_0);
	(bbt_TheSoundPoint)->clas->m_Stop(bbt_TheSoundPoint);
	bbOnDebugLeaveScope();
}
void openb3dmods_b3dsound_Pause3DSound(struct openb3dmods_b3dsound_SoundPoint_obj* bbt_TheSoundPoint){
	struct BBDebugScope_1 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"Pause3DSound",
		{
			{
				BBDEBUGDECL_LOCAL,
				"TheSoundPoint",
				":SoundPoint",
				.var_address=&bbt_TheSoundPoint
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 445, 0};
	bbOnDebugEnterStm(&__stmt_0);
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_TheSoundPoint))->_openb3dmods_b3dsound_soundpoint_paused =1;
	bbOnDebugLeaveScope();
}
void openb3dmods_b3dsound_Resume3DSound(struct openb3dmods_b3dsound_SoundPoint_obj* bbt_TheSoundPoint){
	struct BBDebugScope_1 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"Resume3DSound",
		{
			{
				BBDEBUGDECL_LOCAL,
				"TheSoundPoint",
				":SoundPoint",
				.var_address=&bbt_TheSoundPoint
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 454, 0};
	bbOnDebugEnterStm(&__stmt_0);
	((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_TheSoundPoint))->_openb3dmods_b3dsound_soundpoint_paused =0;
	bbOnDebugLeaveScope();
}
void openb3dmods_b3dsound_EntityStop3DSound(struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugScope_2 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"EntityStop3DSound",
		{
			{
				BBDEBUGDECL_LOCAL,
				"NoisyEntity",
				":TEntity",
				.var_address=&bbt_NoisyEntity
			},
			{
				BBDEBUGDECL_LOCAL,
				"tempSoundPoint",
				":SoundPoint",
				.var_address=&bbt_tempSoundPoint
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 462, 0};
	bbOnDebugEnterStm(&__stmt_0);
	bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 464, 0};
	bbOnDebugEnterStm(&__stmt_1);
	struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
	while((bbt_)->clas->m_HasNext(bbt_)!=0){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 464, 0};
		bbOnDebugEnterStm(&__stmt_0);
		bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
		struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 464, 0};
		bbOnDebugEnterStm(&__stmt_1);
		if(bbt_tempSoundPoint==&bbNullObject){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 464, 0};
			bbOnDebugEnterStm(&__stmt_0);
			bbOnDebugLeaveScope();
			bbOnDebugLeaveScope();
			continue;
		}
		struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 465, 0};
		bbOnDebugEnterStm(&__stmt_2);
		if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_tempSoundPoint))->_openb3dmods_b3dsound_soundpoint_emiterobject ==bbt_NoisyEntity){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 466, 0};
			bbOnDebugEnterStm(&__stmt_0);
			(bbt_tempSoundPoint)->clas->m_Stop(bbt_tempSoundPoint);
			bbOnDebugLeaveScope();
		}
		bbOnDebugLeaveScope();
	}
	bbOnDebugLeaveScope();
}
void openb3dmods_b3dsound_EntityPause3DSound(struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugScope_2 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"EntityPause3DSound",
		{
			{
				BBDEBUGDECL_LOCAL,
				"NoisyEntity",
				":TEntity",
				.var_address=&bbt_NoisyEntity
			},
			{
				BBDEBUGDECL_LOCAL,
				"tempSoundPoint",
				":SoundPoint",
				.var_address=&bbt_tempSoundPoint
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 476, 0};
	bbOnDebugEnterStm(&__stmt_0);
	bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 478, 0};
	bbOnDebugEnterStm(&__stmt_1);
	struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
	while((bbt_)->clas->m_HasNext(bbt_)!=0){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 478, 0};
		bbOnDebugEnterStm(&__stmt_0);
		bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
		struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 478, 0};
		bbOnDebugEnterStm(&__stmt_1);
		if(bbt_tempSoundPoint==&bbNullObject){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 478, 0};
			bbOnDebugEnterStm(&__stmt_0);
			bbOnDebugLeaveScope();
			bbOnDebugLeaveScope();
			continue;
		}
		struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 479, 0};
		bbOnDebugEnterStm(&__stmt_2);
		if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_tempSoundPoint))->_openb3dmods_b3dsound_soundpoint_emiterobject ==bbt_NoisyEntity){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 480, 0};
			bbOnDebugEnterStm(&__stmt_0);
			((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_tempSoundPoint))->_openb3dmods_b3dsound_soundpoint_paused =1;
			bbOnDebugLeaveScope();
		}
		bbOnDebugLeaveScope();
	}
	bbOnDebugLeaveScope();
}
void openb3dmods_b3dsound_EntityResume3DSound(struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity){
	struct openb3dmods_b3dsound_SoundPoint_obj* volatile bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugScope_2 __scope = {
		BBDEBUGSCOPE_FUNCTION,
		"EntityResume3DSound",
		{
			{
				BBDEBUGDECL_LOCAL,
				"NoisyEntity",
				":TEntity",
				.var_address=&bbt_NoisyEntity
			},
			{
				BBDEBUGDECL_LOCAL,
				"tempSoundPoint",
				":SoundPoint",
				.var_address=&bbt_tempSoundPoint
			},
			BBDEBUGDECL_END 
		}
	};
	bbOnDebugEnterScope(&__scope);
	struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 490, 0};
	bbOnDebugEnterStm(&__stmt_0);
	bbt_tempSoundPoint=&bbNullObject;
	struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 492, 0};
	bbOnDebugEnterStm(&__stmt_1);
	struct brl_linkedlist_TListEnum_obj* volatile bbt_=(openb3dmods_b3dsound_SoundPointsList)->clas->m_ObjectEnumerator(openb3dmods_b3dsound_SoundPointsList);
	while((bbt_)->clas->m_HasNext(bbt_)!=0){
		struct BBDebugScope __scope = {
			BBDEBUGSCOPE_LOCALBLOCK,
			0,
			{
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 492, 0};
		bbOnDebugEnterStm(&__stmt_0);
		bbt_tempSoundPoint=((struct openb3dmods_b3dsound_SoundPoint_obj*)bbObjectDowncast((bbt_)->clas->m_NextObject(bbt_),&openb3dmods_b3dsound_SoundPoint));
		struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 492, 0};
		bbOnDebugEnterStm(&__stmt_1);
		if(bbt_tempSoundPoint==&bbNullObject){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 492, 0};
			bbOnDebugEnterStm(&__stmt_0);
			bbOnDebugLeaveScope();
			bbOnDebugLeaveScope();
			continue;
		}
		struct BBDebugStm __stmt_2 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 493, 0};
		bbOnDebugEnterStm(&__stmt_2);
		if(((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_tempSoundPoint))->_openb3dmods_b3dsound_soundpoint_emiterobject ==bbt_NoisyEntity){
			struct BBDebugScope __scope = {
				BBDEBUGSCOPE_LOCALBLOCK,
				0,
				{
					BBDEBUGDECL_END 
				}
			};
			bbOnDebugEnterScope(&__scope);
			struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 494, 0};
			bbOnDebugEnterStm(&__stmt_0);
			((struct openb3dmods_b3dsound_SoundPoint_obj*)bbNullObjectTest(bbt_tempSoundPoint))->_openb3dmods_b3dsound_soundpoint_paused =0;
			bbOnDebugLeaveScope();
		}
		bbOnDebugLeaveScope();
	}
	bbOnDebugLeaveScope();
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
		struct BBDebugScope_4 __scope = {
			BBDEBUGSCOPE_FUNCTION,
			"b3dsound",
			{
				{
					BBDEBUGDECL_CONST,
					"UPDATE_DISABLED",
					"f",
					.const_value=&_s0
				},
				{
					BBDEBUGDECL_CONST,
					"DOPPLER_DISABLED",
					"f",
					.const_value=&_s1
				},
				{
					BBDEBUGDECL_GLOBAL,
					"HearingPoint",
					":ListeningPoint",
					&openb3dmods_b3dsound_HearingPoint
				},
				{
					BBDEBUGDECL_GLOBAL,
					"SoundPointsList",
					":TList",
					&openb3dmods_b3dsound_SoundPointsList
				},
				BBDEBUGDECL_END 
			}
		};
		bbOnDebugEnterScope(&__scope);
		struct BBDebugStm __stmt_0 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 295, 0};
		bbOnDebugEnterStm(&__stmt_0);
		openb3dmods_b3dsound_HearingPoint=bbObjectNew(&openb3dmods_b3dsound_ListeningPoint);
		struct BBDebugStm __stmt_1 = {"/home/mark/bmx-ng/mod/openb3dmods.mod/b3dsound.mod/b3dsound.bmx", 296, 0};
		bbOnDebugEnterStm(&__stmt_1);
		bbOnDebugLeaveScope();
		return 0;
	}
	return 0;
}