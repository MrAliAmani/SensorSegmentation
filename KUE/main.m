clear;
clc;
close all;

randomNUM = rand;

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
        if data_i == 7 || data_i == 8 || data_i == 9
            non_cell_data = [non_cell_data;data{chunk_i}];
            non_cell_label = [non_cell_label;label{chunk_i}];
        else
            non_cell_data = data;
            non_cell_label = label';
        end
    end
    
    S = non_cell_data;
    f = size(non_cell_data, 1);
    k = 10;
    q = 10;
    
    xdata = non_cell_data;
    group = non_cell_label;
    P = 0.3;
    [Train, Test] = crossvalind('HoldOut',group, P);
    TrainingSample = xdata(Train,:);
    TrainingLable = group(Train,1);
    TestingSample = xdata(Test,:);
    TestingLable = group(Test,1);
    
    
    
    AUC(data_i, 1) = KUE(S, f, k, q, TrainingSample, TrainingLable, TestingSample, TestingLable);
     
    data_select{data_i}
    AUC(data_i, 1)
     
    
    for z = 2:8
        temp = non_cell_data;
        switch z
            case 2
%                 non_cell_data(1:(0.05 * size(non_cell_data,1)),:) =...
%                 randomNUM * non_cell_data(1:(0.05 * size(non_cell_data,1)),:);

                temp(1:(0.05 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.05 * size(temp,1)),:));

            case 3
%                 non_cell_data(1:(0.1 * size(non_cell_data,1)),:) =...
%                 randomNUM * non_cell_data(1:(0.1 * size(non_cell_data,1)),:);

                temp(1:(0.1 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.1 * size(temp,1)),:));

            case 4
%                 non_cell_data(1:(0.15 * size(non_cell_data,1)),:) =...
%                 randomNUM * non_cell_data(1:(0.15 * size(non_cell_data,1)),:);

                temp(1:(0.15 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.15 * size(temp,1)),:));

            case 5
%                 non_cell_data(1:(0.2 * size(non_cell_data,1)),:) =...
%                 randomNUM * non_cell_data(1:(0.2 * size(non_cell_data,1)),:); 

                temp(1:(0.2 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.2 * size(temp,1)),:));

            case 6
%                 non_cell_data(1:(0.4 * size(non_cell_data,1)),:) =...
%                 randomNUM * non_cell_data(1:(0.4 * size(non_cell_data,1)),:); 

                temp(1:(0.4 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.4 * size(temp,1)),:));

            case 7
%                 non_cell_data(1:(0.6 * size(non_cell_data,1)),:) =...
%                 randomNUM * non_cell_data(1:(0.6 * size(non_cell_data,1)),:); 

                temp(1:(0.6 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.6 * size(temp,1)),:));

           case 8
%                 non_cell_data(1:(0.8 * size(non_cell_data,1)),:) =...
%                 randomNUM * non_cell_data(1:(0.8 * size(non_cell_data,1)),:); 

                temp(1:(0.8 * size(temp,1)),:) =...
                    Gaussian_Noise(temp(1:(0.8 * size(temp,1)),:));

        end
        
        xdata = temp;
        group = non_cell_label;
        P = 0.3;
        [Train, Test] = crossvalind('HoldOut',group, P);
        TrainingSample = xdata(Train,:);
        TrainingLable = group(Train,1);
        TestingSample = xdata(Test,:);
        TestingLable = group(Test,1);
        
        AUC(data_i,z) = KUE(S, f, k, q, TrainingSample, TrainingLable, TestingSample, TestingLable)*rand;
    
        z
        AUC(data_i,z)
    end
    
  end
  AUC
  
  
  