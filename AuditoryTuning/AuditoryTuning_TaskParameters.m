function AuditoryTuning_TaskParameters(Param)
%
%
%

global S
    S.Names.StateToZero={'CueDelivery','blank'};
    S.Names.StateToStim={'CueDelivery'};
    S.Names.Rig=Param.rig;

%% General Parameters    
    S.GUI.Wheel=1;
    S.GUIMeta.Wheel.Style='checkbox';
    S.GUIMeta.Wheel.String='Auto';
 	S.GUI.Photometry=1;
    S.GUIMeta.Photometry.Style='checkbox';
    S.GUIMeta.Photometry.String='Auto';
    S.GUI.DbleFibers=1;
    S.GUIMeta.DbleFibers.Style='checkbox';
    S.GUIMeta.DbleFibers.String='Auto';
    S.GUI.Isobestic405=0;
    S.GUIMeta.Isobestic405.Style='checkbox';
    S.GUIMeta.Isobestic405.String='Auto';
    S.GUI.RedChannel=0;
    S.GUIMeta.RedChannel.Style='checkbox';
    S.GUIMeta.RedChannel.String='Auto';    
    S.GUIPanels.Recording={'Wheel','Photometry','DbleFibers','Isobestic405','RedChannel'};
    
    S.GUI.TimeMin=-1;
    S.GUI.TimeMax=2;
    S.GUI.NidaqMin=-5;
    S.GUI.NidaqMax=10;
    S.GUIPanels.Plot={'TimeMin','TimeMax','NidaqMin','NidaqMax'};
    
	S.GUI.WhiteNoise=1;
    S.GUIMeta.WhiteNoise.Style='checkbox';
    S.GUIMeta.WhiteNoise.String='Auto';
	S.GUI.PureTones=1;
    S.GUIMeta.PureTones.Style='checkbox';
    S.GUIMeta.PureTones.String='Auto';
    S.GUI.Sweeps=1;
    S.GUIMeta.Sweeps.Style='checkbox';
    S.GUIMeta.Sweeps.String='Auto';   
    
    S.GUIPanels.Sounds={'WhiteNoise','PureTones','Sweeps'};
    S.GUITabs.General={'Plot','Recording','Sounds'};
    
%% Timing
    S.GUI.Repetition=5;
    S.GUI.TimePreCue=2;
    S.GUI.TimeCue=0.5; %independent of the actual length of the cue
    S.GUI.TimePostCue=4;
    S.GUIPanels.TaskTiming={'Repetition','TimePreCue','TimeCue','TimePostCue'};
        
    S.GUI.StateToZero=1;
	S.GUIMeta.StateToZero.Style='popupmenu';
    S.GUIMeta.StateToZero.String=S.Names.StateToZero;
    S.GUI.BaselineBegin=0.1;
    S.GUI.BaselineEnd=1.1;
    S.GUI.CueBegin=0;
    S.GUI.CueEnd=0.5;
    S.GUIPanels.PlotTiming={'StateToZero','BaselineBegin','BaselineEnd','CueBegin','CueEnd'};

    S.GUITabs.OnlinePlot={'TaskTiming','PlotTiming'};
    
    
%% Sound Parameters
    S.GUI.intensityFactor=1;
    S.GUI.SoundSamplingRate=192000;
    S.GUIPanels.Sound_Properties={'intensityFactor','SoundSamplingRate'};

    S.GUI.SoundDuration_pt=0.2;
	S.GUI.SoundRamp_pt=0;
    S.GUI.LowFreq_pt=4000;
    S.GUI.HighFreq_pt=20000;
    S.GUI.NbOfTones=5;
    S.GUIPanels.PureTones_Properties={'SoundDuration_pt','SoundRamp_pt','LowFreq_pt','HighFreq_pt','NbOfTones'};
     
    S.GUI.SoundDuration_s=0.2;
    S.GUI.LowFreq_s=4000;
    S.GUI.HighFreq_s=20000;
    S.GUIPanels.Sweeps_Properties={'SoundDuration_s','LowFreq_s','HighFreq_s'};
    
    S.GUI.SoundDuration_wn=0.2;
    S.GUI.SoundRamp_wn=0.05;
    S.GUIPanels.WhiteNoise_Properties={'SoundDuration_wn','SoundRamp_wn'};
 
    S.GUITabs.SoundParameters={'Sound_Properties','PureTones_Properties','Sweeps_Properties','WhiteNoise_Properties'};

%% Nidaq and Photometry
    S.GUI.PhotometryVersion=1;
    S.GUI.Modulation=1;
    S.GUIMeta.Modulation.Style='checkbox';
    S.GUIMeta.Modulation.String='Auto';
	S.GUI.NidaqDuration=10;
    S.GUI.NidaqSamplingRate=6100;
    S.GUI.DecimateFactor=610;
    S.GUI.LED1_Name='Fiber1 470-A1';
    S.GUI.LED1_Amp=Param.LED1Amp;
    S.GUI.LED1_Freq=211;
    S.GUI.LED2_Name='Fiber1 405 / 565';
    S.GUI.LED2_Amp=Param.LED2Amp;
    S.GUI.LED2_Freq=531;
    S.GUI.LED1b_Name='Fiber2 470-mPFC';
    S.GUI.LED1b_Amp=Param.LED1bAmp;
    S.GUI.LED1b_Freq=531;

    S.GUIPanels.Photometry={'PhotometryVersion','Modulation','NidaqDuration',...
                            'NidaqSamplingRate','DecimateFactor',...
                            'LED1_Name','LED1_Amp','LED1_Freq',...
                            'LED2_Name','LED2_Amp','LED2_Freq',...
                            'LED1b_Name','LED1b_Amp','LED1b_Freq'};
                        
    S.GUITabs.Photometry={'Photometry'};
%% Optogenetic stimulation
    S.GUI.Optogenetic=0;
    S.GUIMeta.Optogenetic.Style='checkbox';
    S.GUIMeta.Optogenetic.String='Auto';
    S.GUI.Opto_BNC=Param.BPPP_BNC;
    S.GUI.Opto_Proba=0.5;
    S.GUI.Opto_State=1;
    S.GUIMeta.Opto_State.Style='popupmenu';
    S.GUIMeta.Opto_State.String=S.Names.StateToStim;

    S.GUIPanels.Optogenetic={'Optogenetic','Opto_BNC','Opto_Proba','Opto_State'};
    S.GUITabs.Opto={'Optogenetic'};    
end
