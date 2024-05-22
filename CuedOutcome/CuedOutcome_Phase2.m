function [trialsNames, trialsMatrix, ezTrialsSeq]=CuedOutcome_Phase2(S,PhaseName)

switch PhaseName
	case 'Habituation'
        trialsNames={'Uncued Reward',...
                     'Uncued Omission'};
        trialsMatrix=[...
        % 1.type, 2.proba, 3.sound, 4.delay,    5.valve,                6.Outcome         	7.Marker
            1,   0.5,       0,    S.GUI.Delay,  S.GUI.RewardValve,      S.InterRew,         double('o');...    
            2,   0.5,       0,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s')];
        easyTrials=[4 4 4 5 5 5 5 4 4];

    case 'CuedReward'
        pCR=[0.35 0.05]; pNS=[0 0.3]; pUS=[0.2 0.1];
        if S.GUI.noOmission
            pCR=[0.4 0];
        end
        if S.GUI.TaskRev
            p1=NS; p2=pCR;
            easyTrials=[2 2 3 3 3 3 5 5];
        else
            p1=pCR; p2=pNS;
            easyTrials=[1 1 1 1 4 4 5 5];
        end

        trialsNames={'Cue A Reward','Cue A Omission',...
                     'Cue B Reward','Cue B Omission',...
                     'Uncued Reward','Uncued Omission'};
        trialsMatrix=[...
        % 1.type, 2.proba, 3.sound, 4.delay,    5.valve,                6.Outcome         	7.Marker
            1,   p1(1),       1,    S.GUI.Delay,  S.GUI.RewardValve,    S.InterRew,         double('o');...   
            2,   p1(2),       1,    S.GUI.Delay,  S.GUI.OmissionValve, 	S.InterRew,         double('s');...   
            3,   p2(1),       2,    S.GUI.Delay,  S.GUI.RewardValve,    S.InterRew,         double('o');...   
            4,   p2(2),       2,    S.GUI.Delay,  S.GUI.OmissionValve, 	S.InterRew,         double('s');...   
            5,   pUS(1),      0,    S.GUI.Delay,  S.GUI.RewardValve,    S.InterRew,         double('o');...  
            6,   pUS(2),      0,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s')];

    case 'CuedPunish'
        pCR=[0.35 0.05]; pNS=[0 0.3]; pUS=[0.2 0.1];
        if S.GUI.noOmission
            pCR=[0.4 0];
        end
        if S.GUI.TaskRev
            p1=NS; p2=pCR;
            easyTrials=[2 2 3 3 3 3 5 5];
        else
            p1=pCR; p2=pNS;
            easyTrials=[1 1 1 1 4 4 5 5];
        end

        trialsNames={'Cue A Punish','Cue A Omission',...
                     'Cue B Punish','Cue B Omission',...
                     'Uncued Punish','Uncued Omission'};
        trialsMatrix=[...
        % 1.type, 2.proba, 3.sound, 4.delay,    5.valve,                6.Outcome         	7.Marker
            1,   p1(1),       1,    S.GUI.Delay,  S.GUI.PunishValve,    S.InterRew,         double('o');...   
            2,   p1(2),       1,    S.GUI.Delay,  S.GUI.OmissionValve, 	S.InterRew,         double('s');...   
            3,   p2(1),       2,    S.GUI.Delay,  S.GUI.PunishValve,    S.InterRew,         double('o');...   
            4,   p2(2),       2,    S.GUI.Delay,  S.GUI.OmissionValve, 	S.InterRew,         double('s');...   
            5,   pUS(1),      0,    S.GUI.Delay,  S.GUI.PunishValve,    S.InterRew,         double('o');...  
            6,   pUS(2),      0,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s')];

    case 'RewardPunish'
        pCR=[0.35 0.05]; pCP=[0 0.3]; pUS=[0.2 0.1];
        if S.GUI.noOmission
            pCR=[0.4 0];
        end
        if S.GUI.TaskRev
            p1=NS; p2=pCR; valve1=S.GUI.PunishValve; valve2=S.GUI.RewardValve;
            easyTrials=[2 2 3 3 3 3 5 5];
            trialsNames={'Cue A Punishment','Cue A Omission',...
                'Cue B Reward','Cue B Omission',...
                'Uncued Reward','Uncued Punishment','Uncued Omission'};
        else
            p1=pCR; p2=pNS; valve1=S.GUI.RewardValve; valve2=S.GUI.PunishValve;
            easyTrials=[1 1 1 1 4 4 5 5];
            trialsNames={'Cue A Reward','Cue A Omission',...
                'Cue B Punishment','Cue B Omission',...
                'Uncued Reward','Uncued Punishment','Uncued Omission'};
        end

         easyTrials=[1 1 1 1 3 3 3 5 5 5 ];

        trialsMatrix=[...
        % 1.type, 2.proba, 3.sound, 4.delay,    5.valve,                6.Outcome         	7.Marker
            1,   p1(1),       1,    S.GUI.Delay,  valve1,    S.InterRew,         double('o');...   
            2,   p1(2),       1,    S.GUI.Delay,  S.GUI.OmissionValve, 	S.InterRew,         double('s');...   
            3,   p2(1),       2,    S.GUI.Delay,  valve1,    S.InterRew,         double('o');...   
            4,   p2(2),       2,    S.GUI.Delay,  S.GUI.OmissionValve, 	S.InterRew,         double('s');...   
            5,   0.06,      0,    S.GUI.Delay,   S.GUI.RewardValve,      S.InterRew,         double('o');...    
            6,   0.06,      0,    S.GUI.Delay,   S.GUI.PunishValve,      S.GUI.PunishTime,   double('d');...
            7,   0.06,     0,    S.GUI.Delay,   S.GUI.OmissionValve,    S.InterRew,         double('s')];

	case 'RewardAPunishBValues' 
        trialsNames={'Cue A Reward','Cue A Punishment','Cue A Omission'...
            'Cue B Reward','Cue B Punishment','Cue B Omission',...
            'Uncued Reward','Uncued Punishment','Uncued Omission'};
        trialsMatrix=[...
        %  1.type, 2.proba, 3.sound, 4.delay, 	5.valve,                6.Outcome         	7.Marker
            1,   0.325,     1,    S.GUI.Delay,  S.GUI.RewardValve,  	S.InterRew,         double('o');...   
            2,   0.05,      1,    S.GUI.Delay,  S.GUI.PunishValve,      S.GUI.PunishTime, 	double('d');...   
            3,   0.05,    	1,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s');...   
            4,   0.15,      2,    S.GUI.Delay,  S.GUI.RewardValve,       S.InterRew,         double('o');...    
            5,   0.225,     2,    S.GUI.Delay,  S.GUI.PunishValve,      S.GUI.PunishTime, 	double('d');...    
            6,   0.05,      2,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s');...
            7,   0.05,      0,    S.GUI.Delay,  S.GUI.RewardValve,      S.InterRew,         double('o');...
            8,   0.05,      0,    S.GUI.Delay,  S.GUI.PunishValve,      S.GUI.PunishTime,	double('d');...
            9,   0.05,      0,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s')];
        easyTrials=[1 1 1 1 3 3 3 5 5 5 ];
        
	case 'RewardBPunishAValues' 
        trialsNames={'Cue A Reward','Cue A Punishment','Cue A Omission'...
            'Cue B Reward','Cue B Punishment','Cue B Omission',...
            'Uncued Reward','Uncued Punishment','Uncued Omission'};
        trialsMatrix=[...
        %  1.type, 2.proba, 3.sound, 4.delay, 	5.valve,                6.Outcome         	7.Marker
            1,   0.15,      1,    S.GUI.Delay,  S.GUI.RewardValve,  	S.InterRew,         double('o');...   
            2,   0.225,     1,    S.GUI.Delay,  S.GUI.PunishValve,      S.GUI.PunishTime, 	double('d');...   
            3,   0.05,    	1,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s');...   
            4,   0.325,     2,    S.GUI.Delay,  S.GUI.RewardValve,       S.InterRew,         double('o');...    
            5,   0.05,      2,    S.GUI.Delay,  S.GUI.PunishValve,      S.GUI.PunishTime, 	double('d');...    
            6,   0.05,      2,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s');...
            7,   0.05,      0,    S.GUI.Delay,  S.GUI.RewardValve,      S.InterRew,         double('o');...
            8,   0.05,      0,    S.GUI.Delay,  S.GUI.PunishValve,      S.GUI.PunishTime,	double('d');...
            9,   0.05,      0,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s')]; 
        easyTrials=[1 1 1 1 3 3 3 5 5 5 ];
    
    case 'RewardUncertainty'
        trialsNames={'Cue A Reward','Cue A Omission',...
                     'Cue B Reward','Cue B Omission',...
                     'Cue C Reward','Cue C Omission'};
        trialsMatrix=[...
        % 1.type, 2.proba, 3.sound, 4.delay,    5.valve,                6.Outcome         	7.Marker
            1,   pA,       1,    S.GUI.Delay,  S.GUI.RewardValve,     S.InterRew,        double('o');...   
            2,   pAinv,    1,    S.GUI.Delay,  S.GUI.OmissionValve,   S.InterRew,        double('s');...   
            3,   pB,       2,    S.GUI.Delay,  S.GUI.RewardValve,     S.InterRew,        double('o');...   
            4,   pBinv,    2,    S.GUI.Delay,  S.GUI.OmissionValve,   S.InterRew,        double('s');...    
            5,   pC,       3,    S.GUI.Delay,  S.GUI.RewardValve,     S.InterRew,        double('o');...    
            6,   pCinv,    3,    S.GUI.Delay,  S.GUI.OmissionValve,	  S.InterRew,        double('s')];
        easyTrials=[1 1 2 3 3 4 5 5];
        
end
ezTrialsSeq=easyTrials(randperm(length(easyTrials),length(easyTrials)));
end

%% ------------------- OLD PHASES ---------------------- %%
% 
% case 'Pavlovian1Cue'  % training
%     trialsNames={'Cue A Small Reward ','Cue A Omission',...
%         'Cue A Large Reward','Cue B Omission',...
%         'Uncued Reward','blank'};
%     trialsMatrix=[...
%     %  type, proba,  sound,     delay,       valve,      Pav/Inst 0/1    Marker
%         1,   0.4,     1,    S.GUI.Delay,   S.Valve,    0,              double('o'), S.SmallRew   ;...   % 
%         2,   0.1,     1,    S.GUI.Delay,   S.noValve,  0,              double('s'), S.SmallRew   ;...   % 
%         3,   0.1,     1,    S.GUI.Delay,   S.Valve,    0,              double('d'), S.LargeRew   ;...   % 
%         4,   0.3,     2,    S.GUI.Delay,   S.noValve,  0,              double('s'), S.LargeRew   ;...   % 
%         5,   0.1,     3,    S.GUI.Delay,   S.Valve,    0,              double('o'), S.UncuedRew  ;...   % 
%         6,   0.0,     3,    S.GUI.Delay,   S.Valve,    0,              double('s'), S.UncuedRew];       % 
% 
% case 'Pavlovian2CuesA'
%     trialsNames={'Cue A Small Reward ','Cue A Omission',...
%         'Cue A Large Reward','Cue B Large Reward',...
%         'Cue B Omission','Uncued Small Reward'};
%    trialsMatrix=[...
%     %  type, proba,  sound,     delay,       valve,      Pav/Inst 0/1    Marker
%         1,   0.3,      1,    S.GUI.Delay,   S.Valve,    0,              double('o'), S.SmallRew   ;...   %
%         2,   0.1,      1,    S.GUI.Delay,   S.noValve,  0,              double('s'), S.SmallRew   ;...   %
%         3,   0.1,      1,    S.GUI.Delay,   S.Valve,    0,              double('d'), S.LargeRew   ;...   %
%         4,   0.1,  	   2,    S.GUI.Delay,   S.Valve,    0,              double('d'), S.LargeRew   ;...   %
%         5,   0.3,      2,    S.GUI.Delay,   S.noValve,  0,              double('o'), S.LargeRew   ;...   % 
%         6,   0.1,      3,    S.GUI.Delay,   S.Valve,    0,              double('s'), S.UncuedRew];       % 
% 
%  case 'Pavlovian2CuesB'
%     trialsNames={'Cue A Small Reward ','Cue A Omission',...
%         'Cue A Large Reward','Cue B Large Reward',...
%         'Cue B Omission','Uncued Small Reward'};
%    trialsMatrix=[...
%     %  type, proba,  sound,     delay,       valve,      Pav/Inst 0/1    Marker
%         1,   0.3,      1,    S.GUI.Delay,   S.Valve,    0,              double('o'), S.SmallRew   ;...   %
%         2,   0.1,      1,    S.GUI.Delay,   S.noValve,  0,              double('s'), S.SmallRew   ;...   %
%         3,   0.1,      1,    S.GUI.Delay,   S.Valve,    0,              double('d'), S.LargeRew   ;...   %
%         4,   0.3,  	   2,    S.GUI.Delay,   S.Valve,    0,              double('d'), S.LargeRew   ;...   %
%         5,   0.1,      2,    S.GUI.Delay,   S.noValve,  0,              double('s'), S.LargeRew   ;...   % 
%         6,   0.1,      3,    S.GUI.Delay,   S.Valve,    0,              double('o'), S.UncuedRew];       % 
% 
% case 'Inversion'
%     trialsNames={'Cue A Large Reward ','Cue A Omission',...
%         'Cue B Small Reward','Cue B Omission',...
%         'Uncued Small Reward','blank'};
%    trialsMatrix=[...
%     %  type, proba,  sound,     delay,       valve,      Pav/Inst 0/1    Marker
%         1,   0.35,      1,    S.GUI.Delay,   S.Valve,    0,              double('o'), S.LargeRew   ;...   %
%         2,   0.1,       1,    S.GUI.Delay,   S.noValve,  0,              double('s'), S.LargeRew   ;...   %
%         3,   0.35,      2,    S.GUI.Delay,   S.Valve,    0,              double('v'), S.SmallRew   ;...   %
%         4,   0.1,  	    2,    S.GUI.Delay,   S.noValve,  0,              double('s'), S.SmallRew   ;...   %
%         5,   0.1,       3,    S.GUI.Delay,   S.Valve,    0,              double('o'), S.UncuedRew  ;...   % 
%         6,   0,         3,    S.GUI.Delay,   S.Valve,    0,              double('s'), S.UncuedRew];       %    

       % case 'RewardA_Large'  % training
       %  trialsNames={'Cue A Reward','Cue A Omission',...
       %               'Cue B Omission','Uncued Reward',...
       %               'Uncued Omission','Cue A Large Reward'};
       %  trialsMatrix=[...
       %  % 1.type, 2.proba, 3.sound, 4.delay,    5.valve,                6.Outcome         	7.Marker
       %      1,   0.4,        1,    S.GUI.Delay,  S.GUI.RewardValve,      S.InterRew,         double('o');...   
       %      2,   0.05,       1,    S.GUI.Delay,  S.GUI.OmissionValve, 	S.InterRew,         double('s');...   
       %      3,   0.25,       2,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s');...   
       %      4,   0.15,       0,    S.GUI.Delay,  S.GUI.RewardValve,      S.InterRew,         double('o');...    
       %      5,   0.1,        0,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s');...
       %      6,   0.05,       1,    S.GUI.Delay,  S.GUI.RewardValve,      S.LargeRew,         double('v')];   
       %  easyTrials=[1 1 1 1 3 3 4 4];
       % 
       % case 'RewardB_Large'
       %  trialsNames={'Cue A Omission','Cue B Reward',...
       %               'Cue B Omission','Uncued Reward',...
       %               'Uncued Omission','Cue B Large Reward'};
       %  trialsMatrix=[...
       %  % 1.type, 2.proba, 3.sound, 4.delay,    5.valve,                6.Outcome         	7.Marker
       %      1,   0.25,       1,    S.GUI.Delay,  S.GUI.OmissionValve,    S.InterRew,         double('s');...   
       %      2,   0.4,       2,    S.GUI.Delay,  S.GUI.RewardValve,      S.InterRew,         double('o');...   
       %      3,   0.05,       2,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s');...   
       %      4,   0.15,       0,    S.GUI.Delay,  S.GUI.RewardValve,      S.InterRew,         double('o');...    
       %      5,   0.1,       0,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s');...
       %      6,   0.05,       2,    S.GUI.Delay,  S.GUI.RewardValve,      S.LargeRew,         double('v')];   
       % 
       %  easyTrials=[1 1 2 2 2 2 4 4]; 

        %    case 'RewardA_DREADD'  % training
        % trialsNames={'Cue A Reward','Cue B Omission',...
        %              'blank','blank',...
        %              'blank','blank'};
        % trialsMatrix=[...
        % % 1.type, 2.proba, 3.sound, 4.delay,    5.valve,                6.Outcome         	7.Marker
        %     1,   0.5,       1,    S.GUI.Delay,  S.GUI.RewardValve,      S.InterRew,         double('o');...   
        %     2,   0.5,       2,    S.GUI.Delay,  S.GUI.OmissionValve, 	S.InterRew,         double('s');...   
        %     3,   0,         0,    S.GUI.Delay,  S.GUI.RewardValve,	S.InterRew,         double('s');...   
        %     4,   0,         4,    S.GUI.Delay,  S.GUI.OmissionValve,      S.InterRew,         double('o');...    
        %     5,   0,         3,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,         double('s')];
        % easyTrials=[1 1 1 1 2 2 2 1];      

        %    	case 'RewardBACValues'
        % trialsNames={'Cue A Reward','Cue A Omission',...
        %              'Cue B Reward','Cue B Omission',...
        %              'Cue C Reward','Cue C Omission'};
        % trialsMatrix=[...
        % % 1.type, 2.proba, 3.sound, 4.delay,    5.valve,                6.Outcome         	7.Marker
        %     1,   0.17,       1,    S.GUI.Delay,  S.GUI.RewardValve,     S.InterRew,        double('o');...   
        %     2,   0.17,       1,    S.GUI.Delay,  S.GUI.OmissionValve,   S.InterRew,        double('s');...   
        %     3,   0.08,       3,    S.GUI.Delay,  S.GUI.RewardValve,     S.InterRew,        double('o');...   
        %     4,   0.25,       3,    S.GUI.Delay,  S.GUI.OmissionValve,   S.InterRew,        double('s');...    
        %     5,   0.25,       2,    S.GUI.Delay,  S.GUI.RewardValve,     S.InterRew,        double('o');...    
        %     6,   0.08,       2,    S.GUI.Delay,  S.GUI.OmissionValve,	S.InterRew,        double('s')];
        % easyTrials=[1 1 2 3 3 4 5 5];

        %     case 'RewardValues' 
        % trialsNames={'Cue A Small Reward','Cue A Inter Reward',...
        %     'Cue A Omission','Cue B Inter Reward',...
        %     'Cue B Large Reward','Cue B Omission',...
        %     'Uncued Inter Reward'};
        % trialsMatrix=[...
        % %  1.type, 2.proba, 3.sound, 4.delay,   5.valve,                6.Outcome         	7.Marker
        %     1,   0.175,     1,    S.GUI.Delay,  S.GUI.RewardValve,  	S.SmallRew,         double('o');...   
        %     2,   0.175,     1,    S.GUI.Delay,	S.GUI.RewardValve,      S.InterRew,         double('d');...   
        %     3,   0.1,       1,    S.GUI.Delay,	S.GUI.OmissionValve,	S.InterRew,         double('s');...   
        %     4,   0.175,     2,    S.GUI.Delay,	S.GUI.RewardValve,       S.InterRew,         double('o');...    
        %     5,   0.175,     2,    S.GUI.Delay,	S.GUI.RewardValve,      S.LargeRew,         double('d');...    
        %     6,   0.01,      2,    S.GUI.Delay,	S.GUI.OmissionValve,	S.InterRew,         double('s');...
        %     7,   0.01,      0,    S.GUI.Delay,	S.GUI.RewardValve,      S.InterRew,         double('o')];    
        % easyTrials=[1 1 2 3 3 4 5 5];