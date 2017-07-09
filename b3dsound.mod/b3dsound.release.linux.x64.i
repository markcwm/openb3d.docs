superstrict
ModuleInfo "Version: 1.2"
ModuleInfo "Author: Logan Chittenden"
ModuleInfo "License: You are free to use this code as you please."
ModuleInfo "History: 1.2 Added Stop3DSound() : EntityStop3DSound() : Pause3DSound() : EntityPause3DSound() :"
ModuleInfo " Resume3DSound() : EntityResume3DSound() : Fixed some misc memory bugs. Removed redundent lines."
ModuleInfo " Minor Speed Optimizations. Minor internal restructuring. Updated documentation."
ModuleInfo "History: 1.1 Added DopplerFrameSkip() : Que3DSound() : UPDATE_DISABLED option :"
ModuleInfo " SoundPoint.Playing : List3DSounds() : Fixed un-necessarily confusing dopper effect stuff."
ModuleInfo "History: 1.0 Initial Release"
import brl.blitz
import openb3d.openb3d
import brl.audio
DOPPLER_DISABLED#=0.00000000#
UPDATE_DISABLED#=-2.00000000#
ListeningPoint^Object{
.ListenPoint:TEntity&
.SoundFalloffEnd#&
.DopplerScale#&
}="openb3dmods_b3dsound_ListeningPoint"
SoundPoint^Object{
.RelativeSoundPoint:TPivot&
.ListenAngularDifference:TPivot&
.Distance#&
.Angle#&
.SoundChannel:TChannel&
.EmiterObject:TEntity&
.Loudness#&
.MasterVolume#&
.Pan#&
.PanBump#&
.Depth#&
.DepthBump#&
.Rate#&
.RateBump#&
.Volume#&
.VolumeBump#&
.Paused@&
-Delete()="_openb3dmods_b3dsound_SoundPoint_Delete"
+Create:SoundPoint(TheSound:TSound,NoisyEntity:TEntity,EntityLoudness#=1.00000000#,Volume#=1.00000000#,Qued@=0)="openb3dmods_b3dsound_SoundPoint_Create_TSoundPoint_TTSoundTTEntityffb"
-UpdatePosition()="openb3dmods_b3dsound_SoundPoint_UpdatePosition"
-SetAndPlay()="openb3dmods_b3dsound_SoundPoint_SetAndPlay"
-Update()="openb3dmods_b3dsound_SoundPoint_Update"
-Stop()="openb3dmods_b3dsound_SoundPoint_Stop"
}="openb3dmods_b3dsound_SoundPoint"
Init3DSound(ListeningEntity:TEntity,MaxRange#,ExaggerateDopplerScale#=0.00000000#)="openb3dmods_b3dsound_Init3DSound"
Update3DSounds()="openb3dmods_b3dsound_Update3DSounds"
DopplerFrameSkip()="openb3dmods_b3dsound_DopplerFrameSkip"
Start3DSound:SoundPoint(TheSound:TSound,NoisyEntity:TEntity,Loudness#=1.00000000#,Volume#=1.00000000#)="openb3dmods_b3dsound_Start3DSound"
Que3DSound:SoundPoint(TheSound:TSound,NoisyEntity:TEntity,Loudness#=1.00000000#,Volume#=1.00000000#)="openb3dmods_b3dsound_Que3DSound"
List3DSounds:TList(NoisyEntity:TEntity)="openb3dmods_b3dsound_List3DSounds"
Stop3DSound(TheSoundPoint:SoundPoint)="openb3dmods_b3dsound_Stop3DSound"
Pause3DSound(TheSoundPoint:SoundPoint)="openb3dmods_b3dsound_Pause3DSound"
Resume3DSound(TheSoundPoint:SoundPoint)="openb3dmods_b3dsound_Resume3DSound"
EntityStop3DSound(NoisyEntity:TEntity)="openb3dmods_b3dsound_EntityStop3DSound"
EntityPause3DSound(NoisyEntity:TEntity)="openb3dmods_b3dsound_EntityPause3DSound"
EntityResume3DSound(NoisyEntity:TEntity)="openb3dmods_b3dsound_EntityResume3DSound"