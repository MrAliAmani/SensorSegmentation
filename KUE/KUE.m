function AUC = KUE(S, f, k, q, TrainingSample, TrainingLable, TestingSample, TestingLable)

    xdata = TrainingSample;
    group = TrainingLable;
    P = 0.3;
    [Train, Test] = crossvalind('HoldOut',group, P);
    TrainingSample2 = xdata(Train,:);
    TrainingLable2 = group(Train,1);
    TestingSample2 = xdata(Test,:);
    TestingLable2 = group(Test,1);
    
    [N,D] = size(TrainingSample2);

    Weight = zeros(1,N);
    Weight(:,:) = 1/N;
    
    for j=1:k
        
        if j == 1
            for i=1:q
                ind = Bootstrap_Sample(Weight,N);
                Xi = TrainingSample2(ind,:);
                Yi = TrainingLable2(ind,:);
                Tree{i} = classregtree(Xi,Yi);

                Lable1 = round(Tree{i}(TestingSample(:,:)));
                Lable1(find(Lable1 == 0)) = 1;
                predict1(i,:) = Lable1;


                kappa(i) = (size(TrainingSample2,1)* numel(find(Lable1==1)))-size(TrainingSample2,1)*size(TrainingSample2,2)/...
                (size(TrainingSample2,1)^2)-size(TrainingSample2,1)*size(TrainingSample2,2);
            end
        else
            
            for i=1:q

                ind_prim = ceil(N*rand(N,1));
                Xip = TrainingSample2(ind_prim,:);
                Yip = TrainingLable2(ind_prim,:);
                Tree{i} = classregtree(Xip,Yip);
                Lable = round(Tree{i}(Xip(:,:)));
                kappa(i) = (size(TrainingSample2,1)* numel(find(Lable==1)))-size(TrainingSample2,1)*size(TrainingSample2,2)/...
                (size(TrainingSample2,1)^2)-size(TrainingSample2,1)*size(TrainingSample2,2);
                
                
                ind = Bootstrap_Sample(Weight,N);
                Xi = TrainingSample2(ind,:);
                Yi = TrainingLable2(ind,:);
                Tree_prim{i} = classregtree(Xi,Yi);
                Lable = round(Tree_prim{i}(Xi(:,:)));
                That = Lable';
                e = Weight * (Yi'~=That)';
        %         Lable1 = SVMclassify(Test,TestingLable);
                
                Lable1 = round(Tree{i}(TestingSample(:,:)));
                Lable1(find(Lable1 == 0)) = 1;
                predict1(i,:) = Lable1;

                if e>0.5
                    Weight(:,:) = 1/N;
                    continue;
                end

                alpha(i) = (0.5) * log((1-e)/e);
                %     Weight = Weight * exp(-alpha(i)*TrainingLable*That);
                Weight = Weight .* exp((-alpha(i)) * (Yi'==That));
                Weight = Weight .* exp(alpha(i) * (Yi'~=That));
                Weight = Weight/sum(Weight);
                kappa_prim(i) = (size(TrainingSample2,1)* numel(find(Lable1==1)))-size(TrainingSample2,1)*size(TrainingSample2,2)/...
                (size(TrainingSample2,1)^2)-size(TrainingSample2,1)*size(TrainingSample2,2);
                
                if kappa_prim(i) > kappa(i)
                    
                    ind = ind_prim;
                    Tree{i} = Tree_prim{i};
                    kappa(i) = kappa_prim(i);
                    
                end
            end
            
        end
        

    end    
    
    for i=1:q
        if size(predict1,1) >= i
            P(i) = sum(predict1(i,:)' == TestingLable)/numel(TestingLable);
        end
    end

    AUC = mean(P);


end