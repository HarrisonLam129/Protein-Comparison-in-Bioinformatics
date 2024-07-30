function [vsub] = vsub(S,T,blosum,letters)
    i = length(S);
    j = length(T);
    vsfx = zeros(i+1, j+1);
    for index1 = 2:i+1
        for index2 = 2:j+1
           letterIndex1 = letters==S(index1-1);
           letterIndex2 = letters==T(index2-1);
           a1 = vsfx(index1-1, index2-1)+blosum(letterIndex1, letterIndex2);
           a2 = vsfx(index1-1, index2)-2;
           a3 = vsfx(index1, index2-1)-2;               
           vsfx(index1, index2) = max([0 a1 a2 a3]);
        end 
    end 
    %Return v_sub = max{V_sfx(i,j)}
    vsub = max(vsfx, [], 'all');
end