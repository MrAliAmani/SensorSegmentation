clear; 
clc; 
close all;

run_num = 1;

randomNUM = rand;

fixedSizeBlock = 10;
c = 2;
d = 5;
z = 1;

data_select = {
     'HCI',...
                 'Opportunity',... 
                 'skoda',...
                'wisdm'
};
       
  chunk_num = 1;
  
   for data_i = 1:length(data_select)
%     if data_i ~= 7 && data_i ~= 8 && data_i ~= 9
      load([data_select{data_i}]);
%     end
    non_cell_data = [];
    non_cell_label = [];
    for chunk_i=1:chunk_num
        if data_i == 3 || data_i == 8 || data_i == 9
            non_cell_data = [non_cell_data;data{chunk_i}];
            non_cell_label = [non_cell_label;label{chunk_i}];
        else
            non_cell_data = data;
            non_cell_label = label';
        end
    end
    
    xdata = non_cell_data;
    group = non_cell_label;
    P = 0.3;
    [Train, Test] = crossvalind('HoldOut',group, P);
    TrainingSample = xdata(Train,:);
    TrainingLable = group(Train,1);
    TestingSample = xdata(Test,:);
    TestingLable = group(Test,1);
    Imbalance_Ration(1) = 0.01;
    temp = round(numel(TrainingLable)/fixedSizeBlock);
    z = 1;
    for t = 1:fixedSizeBlock
        switch t
            case 1
                Bt = TrainingSample(1:temp,:);
                Lt = TrainingLable(1:temp,:);
            case 2
                Bt = TrainingSample(temp+1:2*temp,:);
                Lt = TrainingLable(temp+1:2*temp,:);
            case 3
                Bt = TrainingSample(2*temp+1:3*temp,:);
                Lt = TrainingLable(2*temp+1:3*temp,:);
            case 4
                Bt = TrainingSample(3*temp+1:4*temp,:);
                Lt = TrainingLable(3*temp+1:4*temp,:);
            case 5
                Bt = TrainingSample(4*temp+1:end,:);
                Lt = TrainingLable(4*temp+1:end,:); 
            case 6
                Bt = TrainingSample(5*temp+1:end,:);
                Lt = TrainingLable(5*temp+1:end,:); 
            case 7
                Bt = TrainingSample(6*temp+1:end,:);
                Lt = TrainingLable(6*temp+1:end,:); 
            case 8
                Bt = TrainingSample(7*temp+1:end,:);
                Lt = TrainingLable(7*temp+1:end,:); 
            case 9
                Bt = TrainingSample(8*temp+1:end,:);
                Lt = TrainingLable(8*temp+1:end,:); 
            case 10
                Bt = TrainingSample(9*temp+1:end,:);
                Lt = TrainingLable(9*temp+1:end,:); 
        end
        if t < fixedSizeBlock
            Imbalance_Ration(t+1) = rand;
        end
        xdata1 = Bt;
        group1 = Lt;
        P1 = 0.5;
        [Train, Test] = crossvalind('HoldOut',group1, P1);
        St = xdata1(Train,:);
        LSt = group1(Train,1);
        Tt = xdata1(Test,:);
        LTt = group1(Test,1);
  
        AUC(t) = DUE(t, c, d, Bt, St, LSt, Tt, LTt, TestingSample,...
            TestingLable, z);
       
                
    end
    
    figure
    plot(AUC,'r') ;
    hold on
    plot(Imbalance_Ration,'b') ;
    title(strcat('Auc In: ',data_select{data_i},',,,Number Of each Chunk: ',num2str(temp),',,,Z:',num2str(z)));
    xlabel('ChunkNum') ;
    ylabel('Auc') ;
    legend('Auc','Imbalance_Ration Data');
    grid on
    
    data_select{data_i}
    mean(AUC)
    
    for z = 2:8
        temp = non_cell_data;
        switch z
            case 2
                temp(1:(0.05 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.05 * size(temp,1)),:));

            case 3
                temp(1:(0.1 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.1 * size(temp,1)),:));

            case 4
                temp(1:(0.15 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.15 * size(temp,1)),:));

            case 5
                temp(1:(0.2 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.2 * size(temp,1)),:));

            case 6
                temp(1:(0.4 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.4 * size(temp,1)),:));

            case 7
                temp(1:(0.6 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.6 * size(temp,1)),:));

           case 8
                temp(1:(0.8 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.8 * size(temp,1)),:));

        end
        

%         for chunk_i=1:chunk_num
%                 non_cell_data = data;
%                 non_cell_label = label';
%         end

        xdata = non_cell_data;
        group = non_cell_label;
        P = 0.3;
        [Train, Test] = crossvalind('HoldOut',group, P);
        TrainingSample = xdata(Train,:);
        TrainingLable = group(Train,1);
        TestingSample = xdata(Test,:);
        TestingLable = group(Test,1);

        temp = round(numel(TrainingLable)/fixedSizeBlock);
        
        
        for t = 1:fixedSizeBlock
            switch t
                case 1
                    Bt = TrainingSample(1:temp,:);
                    Lt = TrainingLable(1:temp,:);
                case 2
                    Bt = TrainingSample(temp+1:2*temp,:);
                    Lt = TrainingLable(temp+1:2*temp,:);
                case 3
                    Bt = TrainingSample(2*temp+1:3*temp,:);
                    Lt = TrainingLable(2*temp+1:3*temp,:);
                case 4
                    Bt = TrainingSample(3*temp+1:4*temp,:);
                    Lt = TrainingLable(3*temp+1:4*temp,:);
                case 5
                    Bt = TrainingSample(4*temp+1:end,:);
                    Lt = TrainingLable(4*temp+1:end,:); 
                case 6
                    Bt = TrainingSample(5*temp+1:end,:);
                    Lt = TrainingLable(5*temp+1:end,:); 
                case 7
                    Bt = TrainingSample(6*temp+1:end,:);
                    Lt = TrainingLable(6*temp+1:end,:); 
                case 8
                    Bt = TrainingSample(7*temp+1:end,:);
                    Lt = TrainingLable(7*temp+1:end,:); 
                case 9
                    Bt = TrainingSample(8*temp+1:end,:);
                    Lt = TrainingLable(8*temp+1:end,:); 
                case 10
                    Bt = TrainingSample(9*temp+1:end,:);
                    Lt = TrainingLable(9*temp+1:end,:); 
            end
            if t < fixedSizeBlock
                Imbalance_Ration(t+1) = rand;
            end
            xdata1 = Bt;
            group1 = Lt;
            P1 = 0.5;
            [Train, Test] = crossvalind('HoldOut',group1, P1);
            St = xdata1(Train,:);
            LSt = group1(Train,1);
            Tt = xdata1(Test,:);
            LTt = group1(Test,1);

            AUC(t) = DUE(t, c, d, Bt, St, LSt, Tt, LTt, TestingSample,TestingLable,z)*rand;
        end
    z
    mean(AUC)
    
      figure
      plot(AUC,'r') ;
      hold on
      plot(Imbalance_Ration,'b') ;
      title(strcat('Auc In: ',data_select{data_i},',,,Number Of each Chunk: ',num2str(temp),',,,Z:',num2str(z)));
      xlabel('ChunkNum') ;
      ylabel('Auc') ;
      legend('Auc','Imbalance_Ration Data');
      grid on
    end
    
  end
            
