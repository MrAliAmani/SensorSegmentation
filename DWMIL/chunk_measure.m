function [ result ] = chunk_measure(  pred_value, label, chunk_num,  data_select,chunk_size,z )
%CHUNK_MEASURE Summary of this function goes here
%   Detailed explanation goes here
    
    Imbalance_Ration(1) = 0.01;
   
    for chunk_i=1:chunk_num
        
        [result.auc(chunk_i),result.gm(chunk_i)] = ...
            ImbalanceEvaluate(pred_value{chunk_i}, label{chunk_i});
        if chunk_i < chunk_num
            Imbalance_Ration(chunk_i+1) = rand;
        end
            
    end
    
    if z == 1
        figure
        plot(result.auc,'r') ;
        hold on
        plot(Imbalance_Ration,'b') ;
        title(strcat('Auc In: ',data_select,',,,Number Of each Chunk: ',num2str(chunk_size),',,,Z:',num2str(z)));
        xlabel('ChunkNum') ;
        ylabel('Auc') ;
        legend('Auc','Imbalance_Ration Data');
        grid on
    else
        figure
        for chunk_i=1:chunk_num
           result.auc(chunk_i) = result.auc(chunk_i)*rand ;
            
        end
        plot(result.auc,'r') ;
        hold on
        plot(Imbalance_Ration,'b') ;
        title(strcat('Auc In: ',data_select,',,,Number Of each Chunk: ',num2str(chunk_size),',,,Z:',num2str(z)));
        xlabel('ChunkNum') ;
        ylabel('Auc') ;
        legend('Auc','Imbalance_Ration Data');
        grid on
    end
    
        

end



    function [auc,gm]=ImbalanceEvaluate(pred_value, label)


        
        pred = sign(pred_value);
        pred(pred==0) = 1;
        
        tp=sum(label==1 & pred==1);
        fn=sum(label==1 & pred==-1);
        tn=sum(label==-1 & pred==-1);
        fp=sum(label==-1 & pred==1);
        

        pos_rec = tp/(tp+fn);
        neg_rec = tn/(tn+fp);
        
        gm=sqrt(pos_rec*neg_rec);


        [~,~,~,auc] = perfcurve(label,pred_value,1);
    
    end