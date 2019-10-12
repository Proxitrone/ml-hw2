function bin_val = str2bin(char_bin)
%STR2BIN Summary of this function goes here
%   Detailed explanation goes here
    bin_val = 0;
    pos_mult = 0;
    for i=numel(char_bin):-1:1
        bin_val = bin_val + 2^pos_mult * (char_bin(i)-48);
        pos_mult = pos_mult+1;
    end
end

