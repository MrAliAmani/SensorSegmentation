# ACDWM (Adaptive Chunk-based Dynamic Weighted Majority)
# Example: python main.py sea_abrupt.npz

from numpy import *
from chunk_size_select import *
from dwmil import *
from chunk_based_methods import *
from online_methods import *
from check_measure import *
import matplotlib.pyplot as plt
import sys
import random
import scipy.io



# data_name = 'sea_abrupt.npz'
# load_data = load('data/' + data_name)
# data = load_data['data']
# label = load_data['label']
# reset_pos = load_data['reset_pos'].astype(int)


load_data = scipy.io.loadmat('data/sea.mat')
datat = load_data['data']
labelt = load_data['label']
data = datat[0][0]
label = labelt[0][0]
reset_pos = array([ 0, 31])



data_num = data.shape[0]
chunk_size = 1000

print('data_num : ',data_num)

run_num = 10

# noise = random()
acdwmNoisy = []
pq_result_acdwm = [{} for _ in range(run_num)]

for run_i in range(run_num):

    acss = ChunkSizeSelect()
    model_acdwm = DWMIL(data_num=data_num, chunk_size=0)
    pred_acdwm = array([])

    print('Round ' + str(run_i))
    for i in range(data_num):
        # data[i] = [data[i][0]*noise, data[i][1]*noise]
        acss.update(data[i], label[i])
        # print('noisyData ' + str(noisyData))
        # print('data[i] ' + str(data[i]))
        # print('label ' + str(label[i]))
        if i == data_num - 1:
            chunk_data, chunk_label = acss.get_chunk_2()
            pred_acdwm = append(pred_acdwm, model_acdwm.predict(chunk_data))
        elif acss.get_enough() == 1:
            chunk_data, chunk_label = acss.get_chunk()
            pred_acdwm = append(pred_acdwm, model_acdwm.update_chunk(chunk_data, chunk_label))

    pq_result_acdwm[run_i] = prequential_measure(pred_acdwm, label, reset_pos)

plt.plot(pq_result_acdwm)
plt.show()
# print('acdwm: %f' % mean([pq_result_acdwm[i]['gm'][-1] for i in range(run_num)]))
acdwmNature =  mean([pq_result_acdwm[i]['gm'][-1] for i in range(run_num)])

for x in range(7):
 
    for run_i in range(run_num):

        acss = ChunkSizeSelect()
        model_acdwm = DWMIL(data_num=data_num, chunk_size=0)
        pred_acdwm = array([])

        print('Round ' + str(run_i))
        for i in range(data_num):

            if x==0:
                if i < (0.05*data_num):
                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    #  data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    data[i] = [random.gauss(Average(data), data[i][0]), random.gauss(Average(data), data[i][1]), random.gauss(Average(data), data[i][2])]

            elif x==1:
                if i < (0.1*data_num):
                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    #  data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    data[i] = [random.gauss(Average(data), data[i][0]), random.gauss(Average(data), data[i][1]), random.gauss(Average(data), data[i][2])]

            elif x==2:
                if i < (0.15*data_num):
                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]


                #    data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    data[i] = [random.gauss(Average(data), data[i][0]), random.gauss(Average(data), data[i][1]), random.gauss(Average(data), data[i][2])]

            elif x==3:
                if i < (0.2*data_num):
                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    #  data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    data[i] = [random.gauss(Average(data), data[i][0]), random.gauss(Average(data), data[i][1]), random.gauss(Average(data), data[i][2])]
            elif x==4:
                if i < (0.4*data_num):
                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    #  data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    data[i] = [random.gauss(Average(data), data[i][0]), random.gauss(Average(data), data[i][1]), random.gauss(Average(data), data[i][2])]
            elif x==5:
                if i < (0.6*data_num):
                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    #  data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    data[i] = [random.gauss(Average(data), data[i][0]), random.gauss(Average(data), data[i][1]), random.gauss(Average(data), data[i][2])]

            elif x==6:
                if i < (0.8*data_num):
                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    #  data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise, data[i][2]*noise, data[i][3]*noise, data[i][4]*noise,
                    #  data[i][5]*noise, data[i][6]*noise]

                    # data[i] = [data[i][0]*noise, data[i][1]*noise]

                    data[i] = [random.gauss(Average(data), data[i][0]), random.gauss(Average(data), data[i][1]), random.gauss(Average(data), data[i][2])]

          
              

            acss.update(data[i], label[i])
            if i == data_num - 1:
                chunk_data, chunk_label = acss.get_chunk_2()
                pred_acdwm = append(pred_acdwm, model_acdwm.predict(chunk_data))
            elif acss.get_enough() == 1:
                chunk_data, chunk_label = acss.get_chunk()
                pred_acdwm = append(pred_acdwm, model_acdwm.update_chunk(chunk_data, chunk_label))

        pq_result_acdwm[run_i] = prequential_measure(pred_acdwm, label, reset_pos)

    acdwmNoisy.append(mean([pq_result_acdwm[i]['gm'][-1] for i in range(run_num)]))
    print('x:', x)
    print('acdwmNoisy: ', acdwmNoisy)

print('acdwmNature: %f' % acdwmNature)

for z in range(7):
    print(z , ' acdwmNoisy: %f' % acdwmNoisy[z])

def Average(lst):
    print(sum(lst))
    return sum(lst) / len(lst)