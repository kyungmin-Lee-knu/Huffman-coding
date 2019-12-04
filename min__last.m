%--------------------------------------------------------------------------
% Code by Jeonghun Park, 2019 Apr.
% ITEC201006 : Introduction to Computer Science and Engineering Project
% name : Lee Kyung Min
% number: 2017117997
%--------------------------------------------------------------------------

% ���������� �浹 ������ ���� �ʱ�ȭ
clc; close all; clear; 

% ���� �ҷ�����
f_id = fopen('source_JPARK2019_vfinal.txt', 'r');
format_read = '%2s';

Sample_r = fscanf(f_id,format_read);

OurSource = [];
SourceCount = [];

sample_length = length(Sample_r);

% ǥ���� ���� ����
LearningPhase_array = 1:10:10^5;

% ī���� ��Ʈ
for idx_learning = 1:length(LearningPhase_array)
    LearningPhase = LearningPhase_array(idx_learning);
    
    for idx = 1:LearningPhase
        if ismember(Sample_r(idx), OurSource)
            sample_idx = find(Sample_r(idx) == OurSource);
        else
            OurSource = [OurSource, Sample_r(idx)];
        end
    end
    
    for idx = 1:length(OurSource)
        SourceCount(idx) = count(Sample_r(1:LearningPhase), (OurSource(idx)));
    end
    % ASCII�� ���� ǥ�� ����+1 ���� Last ���� ȣ���� ���� �б����� ����
    for idx = 1:length(OurSource)
        HuffmanCount_temp(idx) = count(Sample_r(LearningPhase+1:100000), (OurSource(idx)));
    end
    % Huffman Coding �� ������ �����ϱ����� ī���� �迭 ����
    HuffmanCount = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    % ����� ������ �迭�� ����
    for i=1:1:length(HuffmanCount_temp)
        HuffmanCount(1,i)=HuffmanCount_temp(1,i);
    end
    % �ڵ���������� Prob_temp �࿭�� ������ ��ȭ�� ���迭(Prob)�� ����� [a-z]����
    Prob_temp = SourceCount/LearningPhase;
    Prob = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    for i=1:1:length(Prob_temp)
        Prob(1,i)=Prob_temp(1,i);
    end
    
    % Huffman Coding �����Լ� ���
    symbols = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26];
    huffman_bit = huffmandict(symbols,Prob);
    

     for i=1:1:26
  	 huffman_length(1,i)=length(huffman_bit{i,2});
     end
    % ȣ���� ��Ʈ���� * ȣ���� �ڵ� ����
     for i=1:1:26
     Huffman_bitlength(1,i) =  huffman_length(1,i) .* HuffmanCount(1,i);
     end
    % ȣ���� ���� �ڵ��� Total �� ���ϱ����� �ʱ�ȭ
     Huffman_bitlength_sum = 0;
    % ������ �迭�� ������� �� ��
     for i=1:1:26
     Huffman_bitlength_sum = Huffman_bitlength(1,i) + Huffman_bitlength_sum;
     end
     
    
    % P ������ ASCII �ڵ�� ���� ��Ʈ�� (10^5-P) ������ Huffman coding�� ��Ʈ ���� 
         Total_bit_1 = 7*LearningPhase + Huffman_bitlength_sum;
    % if ASCII �ڵ尡 7�̾ƴ� 5 or 2 �϶� Total ��Ʈ
         Total_bit_2 = 5*LearningPhase + Huffman_bitlength_sum;
         Total_bit_3 = 2*LearningPhase + Huffman_bitlength_sum;
    % ���� ��Ż��Ʈ�� ��ü ������ ����
         Avg_bit_1(idx_learning) = Total_bit_1/10^5;
         Avg_bit_2(idx_learning) = Total_bit_2/10^5;
         Avg_bit_3(idx_learning) = Total_bit_3/10^5;
    
end

 plot(LearningPhase_array, Avg_bit_1,'b')% ASCII ��Ʈ 7 �Ķ����� ǥ��
 hold
 plot(LearningPhase_array, Avg_bit_2,'--r')% if ��Ʈ5 �϶� ���� �������� ǥ��
 bar(LearningPhase_array, Avg_bit_3,'y')% if ��Ʈ4 �϶� ��� ����� ǥ��


