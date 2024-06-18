function  AUC = DUE(t, c, d, Bt, St, LSt, Tt, LTt, TestingSample, TestingLable,z)

    k = 3;
    f = rand;
    tetha = rand;
    th = rand;
    P = 0.7;
    
    
    
    [CandidateClassifiers, Weight, MSE, Nt, LNt] =...
        TrainingProcedureOfCandidateClassifiers...
        (t, k, f, Bt, St, LSt, Tt, LTt);
        
        
     for i = 1:k
         Whti = exp(MSE{i});
         
         if th < c - k
             th = (th + rand)/2;
         else
             
             Lable = svmclassify(CandidateClassifiers{i},...
                 Nt,'showplot',0);
             
             e = sum(Lable ~= LNt)/numel(LNt);
             
             if e > 0.5
                 CandidateClassifiers{i} = [];
             end
             
         end
     end
     
     for s = 1:size(CandidateClassifiers,2)
         if  size(CandidateClassifiers{s},2) ~= 0
%              size(CandidateClassifiers{s})
            Lable = svmclassify(CandidateClassifiers{s},TestingSample,'showplot',0);
            predict(s,:) = Lable';
         end
     end
     

    for i=1:size(CandidateClassifiers,2)
        if size(predict,1) >= i & size(CandidateClassifiers{s},2) ~= 0
            P(i) = sum(predict(i,:)' == TestingLable)/numel(TestingLable);
        end
    end
     
    

    AUC = mean(P);
end