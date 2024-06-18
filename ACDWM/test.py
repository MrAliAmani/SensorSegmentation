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


# mat = scipy.io.loadmat('data/electricity.mat')

# print(mat)


# data_name = scipy.io.loadmat('data/electricity.mat')

# load_data = scipy.io.loadmat('data/electricity.mat')
# data = load_data['data']
# label = load_data['label']
# print(data[0][0])
# print(label[0])


# data_name = 'sea_abrupt.npz'
# load_data = load('data/' + data_name)
# print(load_data)
# data = load_data['data']
# label = load_data['label']
# reset_pos = load_data['reset_pos'].astype(int)
# print('fdsf',reset_pos)

# print('dsf : ',sum(18549 >= reset_pos) - 1)

# reset_pos = array([ 0, 41])
# a = a.astype(int)
# print('a : ',a)
# print('tewe : ',sum(14 >= a) - 1)
# print('cxcc : ',random.gauss(10,14))

# Prints random item
# print(random())

# a = []

# a.append(1)
# a.append(2)
# print(a,'tyu')


# print(a[0])

load_data = scipy.io.loadmat('data/sea.mat')
datat = load_data['data']
labelt = load_data['label']
data = datat[0][0]
label = labelt[0][0]
reset_pos = array([ 0, 31])



data_num = data.shape[0]
chunk_size = 1000

print('data_num1 : ',data)
print('data_num2 : ',sum(data))
print('data_num3 : ',len(data))
print('data_num4 : ',Average(data))


def Average(lst):
    return sum(lst) / len(lst)