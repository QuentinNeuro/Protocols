function OptoPsycho
%Functions used in this protocol:
%"CuedReward_Phase": specify the phase of the training
%"WeightedRandomTrials" : generate random trials sequence

%"Online_LickPlot"      : initialize and update online lick and outcome plot
%"Online_LickEvents"    : extract the data for the online lick plot
%"Online_NidaqPlot"     : initialize and update online nidaq plot
%"Online_NidaqEvents"   : extract the data for the online nidaq plot

global BpodSystem nidaq S

%% Define parameters
S = BpodSystem.ProtocolSettings; % Load settings chosen in launch manager into current workspace as a struct called S
ParamPC=BpodParam_PCdep();
if isempty(fieldnames(S))  % If settings file was an empty struct, populate struct with default settings
    OptoPsycho_TaskParameters(ParamPC);
end

% Initialize parameter GUI plugin and Pause
BpodParameterGUI('init', S);
BpodSystem.Pause=1;
HandlePauseCondition;
S = BpodParameterGUI('sync', S);

S.SmallRew  =   GetValveTimes(S.GUI.SmallReward, S.GUI.RewardValve);
S.InterRew  =   GetValveTimes(S.GUI.InterReward, S.GUI.RewardValve);
S.LargeRew  =   GetValveTimes(S.GUI.LargeReward, S.GUI.RewardValve);

% sound for no lick period
soundSR=192000;
WhiteNoise=WhiteNoiseGenerator(soundSR,S.GUI.TimeNoLick+1,0);
PsychToolboxSoundServer('init');
PsychToolboxSoundServer('Load', 1, WhiteNoise);
BpodSystem.SoftCodeHandlerFunction = 'SoftCodeHandler_PlaySound';
%% Trial Sequence
[S.TrialsNames, S.TrialsMatrix]=OptoPsycho_Phase(S);
TrialSequence=WeightedRandomTrials(S.TrialsMatrix(:,2)', S.GUI.MaxTrials);
S.NumTrialTypes=max(TrialSequence);
FigLick=Online_LickPlot('ini',TrialSequence);

%% Stimulation
if S.GUI.Optogenetic
    PulsePal(ParamPC.PPCOM);
    S.PulsePalProtocol=S.Names.PPProtocols{S.GUI.PulsePalProtocol};
    load(S.PulsePalProtocol);
    ParameterMatrix{5,1+S.GUI.PulsePalProtocol}=S.GUI.CueDuration;
    ParameterMatrix{8,1+S.GUI.PulsePalProtocol}=S.GUI.CueDuration;
    ParameterMatrix{9,1+S.GUI.PulsePalProtocol}=S.GUI.CueDuration+1;
    ParameterMatrix{11,1+S.GUI.PulsePalProtocol}=S.GUI.CueDuration+1;
    S.OptoPowers=linspace(S.GUI.Opto_PowerMin,S.GUI.Opto_PowerMax,S.GUI.Opto_PowerNb);
    for p=1:S.GUI.Opto_PowerNb
        thisPM=ParameterMatrix;
        thisPM{3,1+S.GUI.PulsePalProtocol}=S.OptoPowers(p);
        S.ParameterMatrix{p}=thisPM;
    end
end
%% NIDAQ Initialization and Plots
if S.GUI.Photometry || S.GUI.Wheel
    if (S.GUI.DbleFibers+S.GUI.Isobestic405+S.GUI.RedChannel)*S.GUI.Photometry >1
        disp('Error - Incorrect photometry recording parameters')
        return
    end
    Nidaq_photometry('ini',ParamPC);
end
[FigPhoto1,FigPhoto2,FigWheel]=Online_NidaqPlots('ini');

%% Bonsai
if S.GUI.Bonsai
    BpodSystem.Pause=1;
    disp('Adjust ROI - resume when ready');
    success=Bpod2Bonsai_Quentin()
    HandlePauseCondition;
end

%% Main trial loop
BpodSystem.Data.TrialTypes = []; % The trial type of each trial completed will be added here.
for currentTrial = 1:S.GUI.MaxTrials
    S = BpodParameterGUI('sync', S); % Sync parameters with BpodParameterGUI plugin 
%% Initialize current trial parameters
    S.ITI = 100;
    while S.ITI > 3 * S.GUI.ITI
        S.ITI = exprnd(S.GUI.ITI);
    end
    S.Power       =	S.TrialsMatrix(TrialSequence(currentTrial),3);
	S.Delay     =	S.TrialsMatrix(TrialSequence(currentTrial),4)+(S.GUI.DelayIncrement*(currentTrial-1));
	S.Valve     =	S.TrialsMatrix(TrialSequence(currentTrial),5);
	S.Outcome   =   S.TrialsMatrix(TrialSequence(currentTrial),6);
%% Opto
    ProgramPulsePal(S.ParameterMatrix{TrialSequence(currentTrial)});
%% Assemble State matrix
 	sma = NewStateMatrix();
    sma = AddState(sma,'Name', 'ITI',...
        'Timer',S.ITI,...
        'StateChangeConditions', {'Tup', 'PreState'},...
        'OutputActions',{});
    %Pre task states
    sma = AddState(sma, 'Name','PreState',...
        'Timer',S.GUI.PreCue,...
        'StateChangeConditions',{'Tup','CueDelivery'},...
        'OutputActions',{'BNCState',1});
    %Stimulus delivery
    sma=AddState(sma,'Name', 'CueDelivery',...
        'Timer',S.GUI.CueDuration,...
        'StateChangeConditions',{'Tup', 'PostOutcome','Port1In','Delay'},...
        'OutputActions', {'BNCState',2});
    %Delay
    sma=AddState(sma,'Name', 'Delay',...
        'Timer',S.GUI.Delay,...
        'StateChangeConditions', {'Tup', 'Outcome'},...
        'OutputActions', {});
    %Reward
    sma=AddState(sma,'Name', 'Outcome',...
        'Timer',S.Outcome,...
        'StateChangeConditions', {'Tup', 'PostOutcome'},...
        'OutputActions', {'ValveState', S.Valve});  
 %Post task states
    sma=AddState(sma,'Name', 'PostOutcome',...
        'Timer',S.GUI.PostOutcome,...
        'StateChangeConditions',{'Tup', 'NoLick'},...
        'OutputActions',{});
    if S.GUI.noLickPeriod
%ITI + noLick period
    sma = AddState(sma,'Name', 'NoLick', ...
        'Timer', S.GUI.TimeNoLick,...
        'StateChangeConditions', {'Tup', 'End','Port1In','RestartNoLick'},...
        'OutputActions', {'SoftCode',1);  
    sma = AddState(sma,'Name', 'RestartNoLick', ...
        'Timer', 0,...
        'StateChangeConditions', {'Tup', 'NoLick',},...
        'OutputActions', {'SoftCode',1}); 
    else
    sma = AddState(sma,'Name', 'NoLick', ...
        'Timer', S.GUI.TimeNoLick,...
        'StateChangeConditions', {'Tup', 'End'},...
        'OutputActions', {});  
    end
    sma = AddState(sma,'Name', 'End',...
        'Timer',1,...
        'StateChangeConditions', {'Tup', 'exit'},...
        'OutputActions',{'SoftCode', 255});
    SendStateMatrix(sma);
 
%% NIDAQ Get nidaq ready to start
if S.GUI.Photometry || S.GUI.Wheel
    Nidaq_photometry('WaitToStart');
end
     RawEvents = RunStateMatrix;
    
%% NIDAQ Stop acquisition and save data in bpod structure
if S.GUI.Photometry || S.GUI.Wheel
    Nidaq_photometry('Stop');
    [PhotoData,WheelData,Photo2Data]=Nidaq_photometry('Save');
    if S.GUI.Photometry
        BpodSystem.Data.NidaqData{currentTrial}=PhotoData;
        if S.GUI.DbleFibers || S.GUI.RedChannel
            BpodSystem.Data.Nidaq2Data{currentTrial}=Photo2Data;
        end
    end
    if S.GUI.Wheel
        BpodSystem.Data.NidaqWheelData{currentTrial}=WheelData;
    end
end

%% Save
if ~isempty(fieldnames(RawEvents))                                          % If trial data was returned
    BpodSystem.Data = AddTrialEvents(BpodSystem.Data,RawEvents);            % Computes trial events from raw data
    BpodSystem.Data.TrialSettings(currentTrial) = S;                        % Adds the settings used for the current trial to the Data struct (to be saved after the trial ends)
    BpodSystem.Data.TrialTypes(currentTrial) = TrialSequence(currentTrial); % Adds the trial type of the current trial to data
    SaveBpodSessionData;                                                    % Saves the field BpodSystem.Data to the current data file
end

%% PLOT - extract events from BpodSystem.data and update figures
try
[currentOutcome, currentLickEvents]=Online_LickEvents(S.Names.StateToZero{S.GUI.StateToZero});
FigLick=Online_LickPlot('update',[],FigLick,currentOutcome,currentLickEvents);
[FigPhoto1,FigPhoto2,FigWheel]=Online_NidaqPlots('update',FigPhoto1,FigPhoto2,FigWheel,currentLickEvents);
catch
    disp('Oups, something went wrong with the online analysis... May be you closed a plot ?') 
end

%% Photometry QC
if currentTrial==1 && S.GUI.Photometry
    thismax=max(PhotoData(S.GUI.NidaqSamplingRate:S.GUI.NidaqSamplingRate*2,1))
    if thismax>4 || thismax<0.3
        disp('WARNING - Something is wrong with fiber #1 - run check-up! - unpause to ignore')
        BpodSystem.Pause=1;
        HandlePauseCondition;
    end
    if S.GUI.DbleFibers
    thismax=max(Photo2Data(S.GUI.NidaqSamplingRate:S.GUI.NidaqSamplingRate*2,1))
    if thismax>4 || thismax<0.3
        disp('WARNING - Something is wrong with fiber #2 - run check-up! - unpause to ignore')
        BpodSystem.Pause=1;
        HandlePauseCondition;
    end
    end
end

%% End of trial
HandlePauseCondition; % Checks to see if the protocol is paused. If so, waits until user resumes.
if BpodSystem.BeingUsed == 0
    return
end
end
try
    sprintf('Water collected : %.0d ul', FigLick.water)
    Analysis_Photometry_Launcher;
catch
    disp('Post recording analysis failed - check whether analysis pipeline is present')
end
end
