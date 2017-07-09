#ifndef OPENB3DMODS_B3DSOUND_B3DSOUND_BMX_RELEASE_LINUX_X64_H
#define OPENB3DMODS_B3DSOUND_B3DSOUND_BMX_RELEASE_LINUX_X64_H

#include <brl.mod/blitz.mod/.bmx/blitz.bmx.release.linux.x64.h>
#include <openb3d.mod/openb3d.mod/.bmx/openb3d.bmx.release.linux.x64.h>
#include <brl.mod/audio.mod/.bmx/audio.bmx.release.linux.x64.h>
int __bb_openb3dmods_b3dsound_b3dsound();
struct openb3dmods_b3dsound_ListeningPoint_obj;
struct openb3dmods_b3dsound_SoundPoint_obj;
void _openb3dmods_b3dsound_ListeningPoint_New(struct openb3dmods_b3dsound_ListeningPoint_obj* o);
struct BBClass_openb3dmods_b3dsound_ListeningPoint {
	BBClass*  super;
	void      (*free)( BBObject *o );
	BBDebugScope* debug_scope;
	unsigned int instance_size;
	void      (*ctor)( BBOBJECT o );
	void      (*dtor)( BBOBJECT o );
	BBSTRING  (*ToString)( BBOBJECT x );
	int       (*Compare)( BBOBJECT x,BBOBJECT y );
	BBOBJECT  (*SendMessage)( BBOBJECT o,BBOBJECT m,BBOBJECT s );
	BBINTERFACETABLE itable;
	void*     extra;
	unsigned int obj_size;
};

struct openb3dmods_b3dsound_ListeningPoint_obj {
	struct BBClass_openb3dmods_b3dsound_ListeningPoint* clas;
	struct openb3d_openb3d_TEntity_obj* _openb3dmods_b3dsound_listeningpoint_listenpoint;
	BBFLOAT _openb3dmods_b3dsound_listeningpoint_soundfalloffend;
	BBFLOAT _openb3dmods_b3dsound_listeningpoint_dopplerscale;
};
extern struct BBClass_openb3dmods_b3dsound_ListeningPoint openb3dmods_b3dsound_ListeningPoint;
void _openb3dmods_b3dsound_SoundPoint_New(struct openb3dmods_b3dsound_SoundPoint_obj* o);
void _openb3dmods_b3dsound_SoundPoint_Delete(struct openb3dmods_b3dsound_SoundPoint_obj* o);
typedef struct openb3dmods_b3dsound_SoundPoint_obj* (*openb3dmods_b3dsound_SoundPoint_Create_TSoundPoint_TTSoundTTEntityffb_f)(struct brl_audio_TSound_obj*,struct openb3d_openb3d_TEntity_obj*,BBFLOAT,BBFLOAT,BBBYTE);
struct openb3dmods_b3dsound_SoundPoint_obj* openb3dmods_b3dsound_SoundPoint_Create_TSoundPoint_TTSoundTTEntityffb(struct brl_audio_TSound_obj*,struct openb3d_openb3d_TEntity_obj*,BBFLOAT,BBFLOAT,BBBYTE);
typedef void (*openb3dmods_b3dsound_SoundPoint_UpdatePosition_m)(struct openb3dmods_b3dsound_SoundPoint_obj*);
void _openb3dmods_b3dsound_SoundPoint_UpdatePosition(struct openb3dmods_b3dsound_SoundPoint_obj*);
typedef void (*openb3dmods_b3dsound_SoundPoint_SetAndPlay_m)(struct openb3dmods_b3dsound_SoundPoint_obj*);
void _openb3dmods_b3dsound_SoundPoint_SetAndPlay(struct openb3dmods_b3dsound_SoundPoint_obj*);
typedef void (*openb3dmods_b3dsound_SoundPoint_Update_m)(struct openb3dmods_b3dsound_SoundPoint_obj*);
void _openb3dmods_b3dsound_SoundPoint_Update(struct openb3dmods_b3dsound_SoundPoint_obj*);
typedef void (*openb3dmods_b3dsound_SoundPoint_Stop_m)(struct openb3dmods_b3dsound_SoundPoint_obj*);
void _openb3dmods_b3dsound_SoundPoint_Stop(struct openb3dmods_b3dsound_SoundPoint_obj*);
struct BBClass_openb3dmods_b3dsound_SoundPoint {
	BBClass*  super;
	void      (*free)( BBObject *o );
	BBDebugScope* debug_scope;
	unsigned int instance_size;
	void      (*ctor)( BBOBJECT o );
	void      (*dtor)( BBOBJECT o );
	BBSTRING  (*ToString)( BBOBJECT x );
	int       (*Compare)( BBOBJECT x,BBOBJECT y );
	BBOBJECT  (*SendMessage)( BBOBJECT o,BBOBJECT m,BBOBJECT s );
	BBINTERFACETABLE itable;
	void*     extra;
	unsigned int obj_size;
	openb3dmods_b3dsound_SoundPoint_Create_TSoundPoint_TTSoundTTEntityffb_f f_Create_TSoundPoint_TTSoundTTEntityffb;
	openb3dmods_b3dsound_SoundPoint_UpdatePosition_m m_UpdatePosition;
	openb3dmods_b3dsound_SoundPoint_SetAndPlay_m m_SetAndPlay;
	openb3dmods_b3dsound_SoundPoint_Update_m m_Update;
	openb3dmods_b3dsound_SoundPoint_Stop_m m_Stop;
};

struct openb3dmods_b3dsound_SoundPoint_obj {
	struct BBClass_openb3dmods_b3dsound_SoundPoint* clas;
	struct openb3d_openb3d_TPivot_obj* _openb3dmods_b3dsound_soundpoint_relativesoundpoint;
	struct openb3d_openb3d_TPivot_obj* _openb3dmods_b3dsound_soundpoint_listenangulardifference;
	BBFLOAT _openb3dmods_b3dsound_soundpoint_distance;
	BBFLOAT _openb3dmods_b3dsound_soundpoint_angle;
	struct brl_audio_TChannel_obj* _openb3dmods_b3dsound_soundpoint_soundchannel;
	struct openb3d_openb3d_TEntity_obj* _openb3dmods_b3dsound_soundpoint_emiterobject;
	BBFLOAT _openb3dmods_b3dsound_soundpoint_loudness;
	BBFLOAT _openb3dmods_b3dsound_soundpoint_mastervolume;
	BBFLOAT _openb3dmods_b3dsound_soundpoint_pan;
	BBFLOAT _openb3dmods_b3dsound_soundpoint_panbump;
	BBFLOAT _openb3dmods_b3dsound_soundpoint_depth;
	BBFLOAT _openb3dmods_b3dsound_soundpoint_depthbump;
	BBFLOAT _openb3dmods_b3dsound_soundpoint_rate;
	BBFLOAT _openb3dmods_b3dsound_soundpoint_ratebump;
	BBFLOAT _openb3dmods_b3dsound_soundpoint_volume;
	BBFLOAT _openb3dmods_b3dsound_soundpoint_volumebump;
	BBBYTE _openb3dmods_b3dsound_soundpoint_paused;
};
extern struct BBClass_openb3dmods_b3dsound_SoundPoint openb3dmods_b3dsound_SoundPoint;
void openb3dmods_b3dsound_Init3DSound(struct openb3d_openb3d_TEntity_obj* bbt_ListeningEntity,BBFLOAT bbt_MaxRange,BBFLOAT bbt_ExaggerateDopplerScale);
void openb3dmods_b3dsound_Update3DSounds();
void openb3dmods_b3dsound_DopplerFrameSkip();
struct openb3dmods_b3dsound_SoundPoint_obj* openb3dmods_b3dsound_Start3DSound(struct brl_audio_TSound_obj* bbt_TheSound,struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity,BBFLOAT bbt_Loudness,BBFLOAT bbt_Volume);
struct openb3dmods_b3dsound_SoundPoint_obj* openb3dmods_b3dsound_Que3DSound(struct brl_audio_TSound_obj* bbt_TheSound,struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity,BBFLOAT bbt_Loudness,BBFLOAT bbt_Volume);
struct brl_linkedlist_TList_obj* openb3dmods_b3dsound_List3DSounds(struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity);
void openb3dmods_b3dsound_Stop3DSound(struct openb3dmods_b3dsound_SoundPoint_obj* bbt_TheSoundPoint);
void openb3dmods_b3dsound_Pause3DSound(struct openb3dmods_b3dsound_SoundPoint_obj* bbt_TheSoundPoint);
void openb3dmods_b3dsound_Resume3DSound(struct openb3dmods_b3dsound_SoundPoint_obj* bbt_TheSoundPoint);
void openb3dmods_b3dsound_EntityStop3DSound(struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity);
void openb3dmods_b3dsound_EntityPause3DSound(struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity);
void openb3dmods_b3dsound_EntityResume3DSound(struct openb3d_openb3d_TEntity_obj* bbt_NoisyEntity);

#endif
