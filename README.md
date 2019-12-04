# Huffman-coding
# Matlab
# 컴퓨터학개론
# solting
## 데이터를 읽어드려 분류,
## Huffman-codin 가장 효율좋은 순간 


% 기존값과의 충돌 방지를 위한 초기화

clc; close all; clear; 

% 파일 불러오기

f_id = fopen('source_JPARK2019_vfinal.txt', 'r');

format_read = '%2s';

Sample_r = fscanf(f_id,format_read);

OurSource = [];
SourceCount = [];

sample_length = length(Sample_r);

% 표본의 개수 결정


LearningPhase_array = 1:10:10^5;



% 카운팅 솔트

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
    % ASCII로 읽은 표본 개수+1 부터 Last 까지 호프만 으로 읽기위한 설정
    for idx = 1:length(OurSource)
        HuffmanCount_temp(idx) = count(Sample_r(LearningPhase+1:100000), (OurSource(idx)));
    end
    % Huffman Coding 의 개수를 저장하기위한 카운터 배열 선언
    HuffmanCount = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    % 결과를 각각의 배열에 저장
    for i=1:1:length(HuffmanCount_temp)
        HuffmanCount(1,i)=HuffmanCount_temp(1,i);
    end
    % 코딩결과에따른 Prob_temp 행열의 열개수 변화로 공배열(Prob)을 만들어 [a-z]맞춤
    Prob_temp = SourceCount/LearningPhase;
    Prob = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
    for i=1:1:length(Prob_temp)
        Prob(1,i)=Prob_temp(1,i);
    end
    
    % Huffman Coding 내장함수 사용
    symbols = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26];
    huffman_bit = huffmandict(symbols,Prob);
    

     for i=1:1:26
  	 huffman_length(1,i)=length(huffman_bit{i,2});
     end
    % 호프만 비트길이 * 호프만 코딩 개수
     for i=1:1:26
     Huffman_bitlength(1,i) =  huffman_length(1,i) .* HuffmanCount(1,i);
     end
    % 호프만 으로 코딩한 Total 을 구하기위한 초기화
     Huffman_bitlength_sum = 0;
    % 각각의 배열의 결과값의 총 하
     for i=1:1:26
     Huffman_bitlength_sum = Huffman_bitlength(1,i) + Huffman_bitlength_sum;
     end
     
    
    % P 개수의 ASCII 코드로 읽은 비트와 (10^5-P) 개수의 Huffman coding한 비트 총합 
         Total_bit_1 = 7*LearningPhase + Huffman_bitlength_sum;
    % if ASCII 코드가 7이아닌 5 or 2 일때 Total 비트
         Total_bit_2 = 5*LearningPhase + Huffman_bitlength_sum;
         Total_bit_3 = 2*LearningPhase + Huffman_bitlength_sum;
    % 구한 토탈비트를 전체 개수로 나눔
         Avg_bit_1(idx_learning) = Total_bit_1/10^5;
         Avg_bit_2(idx_learning) = Total_bit_2/10^5;
         Avg_bit_3(idx_learning) = Total_bit_3/10^5;
    
end


 plot(LearningPhase_array, Avg_bit_1,'b')% ASCII 비트 7 파랑으로 표시
 
 hold
 
 plot(LearningPhase_array, Avg_bit_2,'--r')% if 비트5 일때 빨강 점선으로 표시
 
 bar(LearningPhase_array, Avg_bit_3,'y')% if 비트4 일때 노랑 막대로 표시
 
## 최종 작업공간

![최종수정](https://user-images.githubusercontent.com/58453290/70116268-8a10e780-16a5-11ea-8cb9-2e8aa3d8cfeb.PNG)

## 결과값
![최종2](https://user-images.githubusercontent.com/58453290/70116232-6baaec00-16a5-11ea-9d54-436c4e541bf3.PNG)

## 결과값 2
![최종](https://user-images.githubusercontent.com/58453290/70116244-749bbd80-16a5-11ea-91ee-a75ef314c03d.PNG)

## 호프만비트 읽은작업
![호프만비트 읽은것](https://user-images.githubusercontent.com/58453290/70116261-85e4ca00-16a5-11ea-9709-52b330eb2815.PNG)
