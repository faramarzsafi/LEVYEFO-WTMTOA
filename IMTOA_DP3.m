clc;
clear;
close all;
%% objective function
fhd=str2func('cec17_func');  %CEC2018 Dataset
func_num=1;

%% setting parameters
No_GTs=100;  % Number of Global Tracker 
No_LTs=10;   % Number of Local Tracker
RM=sqrt(2);  % Maximum Search Radius
Rm=1e-4;     % Minimum Search Radius
Beta=.95;    % Beta
Lambda=2;    % Lambda
Theta=pi/8;  % Theta
R_rate=0.3;
Ps_rate=0.2;
P_field=0.1;
N_field=0.45;
%
Max_Itr=3000;
Min=-100;
Max=100;
D=30;
VarSize=[1 D];  

%% Initialization
% GTs properties
empty_GTs.Position=[];
empty_GTs.Cost=[];
GTs=repmat(empty_GTs,No_GTs,1);

% LTs properties
empty_LTs.Position=[];
empty_LTs.Cost=[];
LTs=repmat(empty_LTs,No_LTs,1);

GlobalBest.Cost=inf;

for i=1:No_GTs
    % The N Global Tracker are assigned to N random locations inthe search space
    GTs(i).Position=unifrnd(Min,Max,VarSize);
    
    % Evaluate the fitness of each Global Tracker location
    GTs(i).Cost=feval(fhd, GTs(i).Position', func_num);
end

% finding the location of the best solution 
   cost=[GTs.Cost];
   [~,      rank]=sort(cost,'ascend'); % sort population
   GlobalBest.Cost=GTs(rank(1)).Cost;
   GlobalBest.Position=GTs(rank(1)).Position;
   
BestCost=zeros(Max_Itr,1);
nop=No_GTs;

best_position=EFO(D,No_GTs,Max_Itr,Min,Max,R_rate,Ps_rate,P_field,N_field,func_num);
%% Main Loop

for it=1:Max_Itr
    for i=1:nop 
       %            Determin RSs and Search by LTs                  
       %--------------------------------------------------------
       Rf=((i-1)/(nop-1))*(RM-Rm)+Rm;
       Rd=1/sqrt(Rf)*exp(-rand/Rf)^2/2*cos(5*(rand/Rf));
       Rs=Rf*(Rf>=Rd)+Rd*(Rd>Rf); 
       % Create of Local Tracker  
          
       for l=1:No_LTs
           LTs(l).Position= GTs(i).Position + unifrnd(-Rs,Rs,1,D); 
           % Evaluate the fitness of each Local Tracker location
           LTs(l).Position=min(LTs(l).Position,Max);
           LTs(l).Position=max(LTs(l).Position,Min);          
           LTs(l).Cost=feval(fhd, LTs(l).Position', func_num);  
       end
           cost=[LTs.Cost];
           [~, rankLTs]=sort(cost,'ascend'); % sort population
           LocalBest.Cost=LTs(rankLTs(1)).Cost;
           LocalBest.Position=LTs(rankLTs(1)).Position;          
           if LocalBest.Cost<GlobalBest.Cost
                GlobalBest.Cost=LocalBest.Cost;
                GlobalBest.Position=LocalBest.Position;
      end    

    end
    %                Search by GTs                  
    %--------------------------------------------------------
   
    
    for i=1:nop
    newposition= New_GT(GTs(i).Position,LocalBest.Position,GlobalBest.Position,Lambda,Theta,Beta);
        
        if rand<0.5
            
           levy=(gamma(1+Beta)*sin(pi*Beta/2)/(gamma((1+Beta)/2)*Beta*2^((Beta-1)/2)))^(1/Beta);
           newposition=rand*best_position+levy*(1/Max_Itr);
        end
    
        newposition=min(newposition,Max);
        newposition=max(newposition,Min);
        
        newcost=feval(fhd, newposition', func_num);
        
        if newcost<GTs(i).Cost
            GTs(i).Position=newposition;
            GTs(i).Cost=newcost;
        end
    end
    
       % finding the location of the best solution 
       cost=[GTs.Cost];
       [~, rank]=sort(cost,'ascend'); % sort population
       GlobalBest.Cost=GTs(rank(1)).Cost;
       GlobalBest.Position=GTs(rank(1)).Position;
       
       BestCost(it)=GlobalBest.Cost;
       BestCost(it)=BestCost(it)-(func_num.*100);

        % Display Iteration Information
       disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
end



