clear; clc; close all;

run_num = 1;


data_select = {
     'HCI',...
                 'Opportunity',... 
                 'skoda',...
                'wisdm'
};

for data_i = 1:length(data_select)
    load(['data/' data_select{data_i}]);
    non_cell_data = [];
    non_cell_label = [];
    for chunk_i=1:chunk_num
        non_cell_data = [non_cell_data;data{chunk_i}];
        non_cell_label = [non_cell_label;label{chunk_i}];
    end
    
for run_i = 1:run_num
    fprintf('run %d, data: %s\n', run_i, data_select{data_i});
    tic;
    options = [];
    options.eta = 0.01;
    options.lamda = 0.1;
    options.cnt = 5000;
    options.sampling_type = 1;
    a = 0.01;
    b = 0.1;
    c = 0.1;
    d = 1;
    e = 0.9;
    pred_label = cbce(non_cell_data',non_cell_label,a,b,c,d,e);
    data_num = length(pred_label);
    idx = 1;
    for chunk_i=1:chunk_num
        chunk_size = length(label{chunk_i});
        if idx+chunk_size <= data_num
            cell_pred_label{chunk_i} = pred_label(idx:idx+chunk_size-1)';
        else
            cell_pred_label{chunk_i} = pred_label(idx:end)';
        end
        idx = idx + chunk_size;
    end
    result_cbce(run_i) = chunk_measure( cell_pred_label, label, 10, data_select{data_i+3},chunk_size, 1 );
    t_cbce(run_i) = toc;
    
end

fprintf('auc: %f, gm: %f\n',mean([result_cbce.auc]),mean([result_cbce.gm]));

for z = 2:8

    for run_i = 1:run_num
%         fprintf('run %d, data: %s\n', run_i, data_select{data_i});
        tic;
        options = [];
        options.eta = 0.01;
        options.lamda = 0.1;
        options.cnt = 5000;
        options.sampling_type = 1;
        a = 0.01;
        b = 0.1;
        c = 0.1;
        d = 1;
        e = 0.9;
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
        
  non_cell_data = temp;
                               
        pred_label = cbce(non_cell_data',non_cell_label,a,b,c,d,e);
    data_num = length(pred_label);
    idx = 1;
    for chunk_i=1:chunk_num
        chunk_size = length(label{chunk_i});
        if idx+chunk_size <= data_num
            cell_pred_label{chunk_i} = pred_label(idx:idx+chunk_size-1)';
        else
            cell_pred_label{chunk_i} = pred_label(idx:end)';
        end
        idx = idx + chunk_size;
    end
    result_cbce(run_i) = chunk_measure( cell_pred_label, label, 10, data_select{data_i+3},chunk_size,z );
    t_cbce(run_i) = toc;
    
    end
z
fprintf('\nauc: %f, gm: %f\n',mean([result_cbce.auc*rand]),mean([result_cbce.gm]));


end
end


